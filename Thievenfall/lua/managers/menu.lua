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
  local permadeath = CrimDusk.IsPermadeath()
  local NextJob = Global.CrimDusk.campaign[Global.CrimDusk.data["heists_won" .. permadeath] + 1]

  -- ...or random heist if campaign is completed!
  if not NextJob then
    math.randomseed(os.time() + (os.clock() * 1000))
    local ValidHeists = deep_clone(Global.CrimDusk.campaign)

    -- Add bonus heists unused in main campaign
    for _, heist in ipairs(Global.CrimDusk.extra_heists) do table.insert(ValidHeists, heist) end
    local HeistsPlayed = #Global.CrimDusk.data["heist_chain" .. permadeath]

    -- Is Bain captured?
    local BainCaptured = false
    if not Global.CrimDusk.data["bain_freed" .. permadeath] then
      for _, heist in ipairs(Global.CrimDusk.data["heist_chain" .. permadeath]) do
        if heist == "cd_reservoir" then BainCaptured = true end
      end
    end

    -- Set up heist list
    local Tutorials = { cd_tut1 = true, cd_tut2 = true, cd_tut3 = true }
    for i = #ValidHeists, 1, -1 do
      local heist = ValidHeists[i]

      -- Remove tutorials
      if Tutorials[heist] then table.remove(ValidHeists, i)

      -- Remove Hector heists if he's dead
      elseif Global.CrimDusk.data["hector_dead" .. permadeath] then
        if Global.CrimDusk.hector_heists[heist] then table.remove(ValidHeists, i) end

      -- Remove Cook Off if Hector is alive
      elseif heist == "rat" then table.remove(ValidHeists, i)

      -- Remove mini-campaign heists
      elseif Global.CrimDusk.mini_campaigns.hoxton[heist] then table.remove(ValidHeists, i)
      elseif Global.CrimDusk.mini_campaigns.silk_road[heist] then table.remove(ValidHeists, i)
      elseif Global.CrimDusk.mini_campaigns.city_of_gold[heist] then table.remove(ValidHeists, i)
      elseif Global.CrimDusk.mini_campaigns.texas_heat[heist] then table.remove(ValidHeists, i)

     -- Disable Bain heists if Bain is captured
      elseif BainCaptured and not Global.CrimDusk.locke_heists[heist] then
        table.remove(ValidHeists, i)

      elseif heist == "vit" then table.remove(ValidHeists, i) end
    end

    -- Add mini-campaigns to heist pool
    if not BainCaptured then
      for i = 1, math.min(Global.CrimDusk.data["hoxton" .. permadeath], #Global.CrimDusk.lookup.hoxton) do table.insert(ValidHeists, Global.CrimDusk.lookup.hoxton[i]) end
    end
  
    for i = 1, math.min(Global.CrimDusk.data["silk_road" .. permadeath], #Global.CrimDusk.lookup.silk_road) do table.insert(ValidHeists, Global.CrimDusk.lookup.silk_road[i]) end
    for i = 1, math.min(Global.CrimDusk.data["city_of_gold" .. permadeath], #Global.CrimDusk.lookup.city_of_gold) do table.insert(ValidHeists, Global.CrimDusk.lookup.city_of_gold[i]) end
    for i = 1, math.min(Global.CrimDusk.data["texas_heat" .. permadeath], #Global.CrimDusk.lookup.texas_heat) do table.insert(ValidHeists, Global.CrimDusk.lookup.texas_heat[i]) end

    -- White House is always last
    if HeistsPlayed >= #ValidHeists then table.insert(ValidHeists, "vit") end

    -- Ensure duplicate heists don't happen until we've played every heist once
    local heist_chain = "heist_chain" .. permadeath
    if Global.CrimDusk.data[heist_chain] then

      -- If all heists have been played, start a new cycle
      if Global.CrimDusk.data[heist_chain][HeistsPlayed] == "vit" then
        Global.CrimDusk.data[heist_chain] = {}

        Global.CrimDusk.data["winters_dead" .. permadeath] = false
        Global.CrimDusk.data["hector_dead" .. permadeath] = false

        Global.CrimDusk.data["hoxton" .. permadeath] = 1
        Global.CrimDusk.data["silk_road" .. permadeath] = 1
        Global.CrimDusk.data["city_of_gold" .. permadeath] = 1
        Global.CrimDusk.data["texas_heat" .. permadeath] = 1
      end

      -- Remove already played heists
      for _, heist in ipairs(Global.CrimDusk.data[heist_chain]) do
        for i = #ValidHeists, 1, -1 do
          if ValidHeists[i] == heist then table.remove(ValidHeists, i) break end
        end
      end

    end

    CrimDusk.Log(FileIdent, "Heists left in cycle: " .. #ValidHeists)
    Utils.PrintTable(ValidHeists)

    NextJob = ValidHeists[math.random(#ValidHeists)]
    Global.CrimDusk.data[heist_chain] = Global.CrimDusk.data[heist_chain] or {}
    table.insert(Global.CrimDusk.data[heist_chain], NextJob)

    CrimDusk:WriteSave(FileIdent, "heist added to chain")
  end

  self:start_job({
    difficulty = tweak_data.difficulties[CrimDusk.DiffScale()],
    one_down = CrimDusk.SettingsData.permadeath,
    job_id = NextJob
  })

  CrimDusk.Log(FileIdent, "Loading " .. managers.localization:text("heist_" .. NextJob) .. " on " .. tweak_data.difficulties[CrimDusk.DiffScale()])
end)