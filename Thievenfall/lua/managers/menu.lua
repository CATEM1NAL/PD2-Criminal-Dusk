local FileIdent = "MenuManager"

function MenuCallbackHandler:CrimDusk_CreateLobby() self:create_lobby() end

function MenuCallbackHandler:CrimDusk_SaveToggleSettings(item)
  if Utils:IsInGameState() then CrimDusk.Log(FileIdent, "Can't change settings in-game!") return end
  CrimDusk.SettingsData[item:name():sub(10)] = item:value() == "on"

  CrimDusk.PlayButtonLoc()
  io.save_as_json(CrimDusk.SettingsData, CrimDusk.SettingsFile)
end

-- Currently unused
function MenuCallbackHandler:CrimDusk_SaveChoiceSettings(item)
  if Utils:IsInGameState() then CrimDusk.Log(FileIdent, "Can't change settings in-game!") return end
  CrimDusk.SettingsData[item:name():sub(10)] = item:value()
  io.save_as_json(CrimDusk.SettingsData, CrimDusk.SettingsFile)
end

function MenuCallbackHandler:CrimDusk_ResetCampaign()
  if Utils:IsInGameState() then CrimDusk.Log(FileIdent, "Can't change settings in-game!") return end
  Global.CrimDusk.data.heists_won = 0
  Global.CrimDusk.data.lives = 4
  Global.CrimDusk.data.winters_dead = false

  CrimDusk.PlayButtonLoc()
  CrimDusk:WriteSave(FileIdent, "campaign reset")
end

-- Add custom buttons to menu
local function InjectCrimDuskButtons(node)
  local data = {
    type = "CoreMenuItem.Item",
  }

  local params = {
    name = "crimdusk_createlobby_btn",
    text_id = "crimdusk_create_lobby_title",
    help_id = "crimdusk_create_lobby_desc",
    callback = "CrimDusk_CreateLobby",
    font_size = 35,
    font = tweak_data.menu.pd2_large_font
  }

  local new_item = node:create_item(data, params)

  new_item.dirty_callback = callback(node, node, "item_dirty")
  if node.callback_handler then
    new_item:set_callback_handler(node.callback_handler)
  end

  local position = 2
  table.insert(node._items, position, new_item)
end

-- MENU CHANGES START HERE --
Hooks:Add("MenuManagerBuildCustomMenus", "CrimDusk_MenuTweaks", function(menu_manager, nodes)
  local mainmenu = nodes.main
  local pausemenu = nodes.pause
  local lobbymenu = nodes.lobby

  -- Main Menu
  if mainmenu ~= nil then

    CrimDusk.PlayButtonLoc()
    InjectCrimDuskButtons(mainmenu)

    -- Hides all the unnecessary menu buttons
    local HiddenButtons = {
      crimenet = true, crimenet_offline = true, story_missions = true
    }

    for i, item in pairs(mainmenu._items) do
      if HiddenButtons[item._parameters.name] then item:set_visible(false) end
    end

    if RestructuredMenus then
      if RestructuredMenus.settings.main_add_crimenet_broker then
        MenuHelper:HideMenuItem(mainmenu, 'contract_broker')
      end
    end
  end

  -- Lobby
  if lobbymenu ~= nil then
    -- Make start game button always visible
    for i, item in pairs(lobbymenu._items) do
      if item._parameters.name == "start_the_game" then
        table.remove(item._visible_callback_list, 2)

        item._parameters.text_id = "crimdusk_continue_run_title"
        item._parameters.help_id = "crimdusk_continue_run_desc"
        break
      end
    end

    -- Hides all the unnecessary menu buttons
    local HiddenButtons = {
      story_missions = true, crimdawn_createlobby_btn = true, crimenet_nj = true, crimenet_j = true
    }

    for i, item in pairs(lobbymenu._items) do
      if HiddenButtons[item._parameters.name] then item:set_visible(false) end
    end

    if RestructuredMenus then
      if RestructuredMenus.settings.lobby_add_contract_broker then
        MenuHelper:HideMenuItem(lobbymenu, "contract_broker")
      end
    end
  end

  -- Pause Menu
  if pausemenu ~= nil then
    local breakCounter = 0
    for i, item in pairs(pausemenu._items) do

      if item._parameters.name == "abort_mission" then
        item:set_visible(false)
        breakCounter = breakCounter + 1

      elseif item._parameters.name == "end_game" then
        item._enabled = false
        breakCounter = breakCounter + 1
      end

      if breakCounter == 2 then break end
    end
  end
end)
-- MENU CHANGES END HERE --

Hooks:PreHook(MenuCallbackHandler, "start_the_game", "CrimDusk_PreStartGame", function(self)
  if Utils:IsInGameState() or NetworkHelper:IsClient() then return end

  -- Select next heist in campaign...
  local campaign = CrimDusk.SettingsData.permadeath and "heists_won_perma" or "heists_won"
  local NextJob = Global.CrimDusk.campaign[Global.CrimDusk.data[campaign] + 1]

  -- ...or random heist if campaign is completed!
  if not NextJob then
    math.randomseed(os.time() + (os.clock() * 1000))
    local ValidHeists = deep_clone(Global.CrimDusk.campaign)

    -- Ensure duplicate heists don't happen until we've played every heist once
    campaign = CrimDusk.SettingsData.permadeath and "heist_chain_perma" or "heist_chain"
    if Global.CrimDusk.data[campaign] then

      -- If all heists have been played, start a new cycle
      if #Global.CrimDusk.data[campaign] == #Global.CrimDusk.campaign then
        Global.CrimDusk.data[campaign] = {}
        Global.CrimDusk.data.winters_dead = false
      end

      -- Remove already played heists
      for _, heist in ipairs(Global.CrimDusk.data[campaign]) do
        for i = #ValidHeists, 1, -1 do
          if ValidHeists[i] == heist then table.remove(ValidHeists, i) break end
        end
      end

    end

    CrimDusk.Log(FileIdent, "Heists left in cycle: " .. #ValidHeists)

    NextJob = ValidHeists[math.random(#ValidHeists)]
    Global.CrimDusk.data[campaign] = Global.CrimDusk.data[campaign] or {}
    table.insert(Global.CrimDusk.data[campaign], NextJob)

    CrimDusk:WriteSave(FileIdent, "heist added to chain")
  end

  self:start_job({
    difficulty = tweak_data.difficulties[CrimDusk.DiffScale()],
    one_down = CrimDusk.SettingsData.permadeath,
    job_id = NextJob
  })

  CrimDusk.Log(FileIdent, "Loading " .. managers.localization:text("heist_" .. NextJob) .. " on " .. tweak_data.difficulties[CrimDusk.DiffScale()])
end)