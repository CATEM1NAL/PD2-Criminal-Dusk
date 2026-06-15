local FileIdent = "MenuManager"

function MenuCallbackHandler:CrimDawn_CreateLobby() self:create_lobby() end

function MenuCallbackHandler:CrimDawn_SaveToggleSettings(item)
  CrimDawn.SettingsData[item:name():sub(10)] = item:value() == "on"
	io.save_as_json(CrimDawn.SettingsData, CrimDawn.SettingsFile)
end

function MenuCallbackHandler:CrimDawn_SaveChoiceSettings(item)
  CrimDawn.SettingsData[item:name():sub(10)] = item:value()
	io.save_as_json(CrimDawn.SettingsData, CrimDawn.SettingsFile)
end

-- Add custom buttons to menu
local function InjectCrimDawnButtons(node)
  local data = {
    type = "CoreMenuItem.Item",
  }

  local params = {
    name = "crimdawn_createlobby_btn",
    text_id = "crimdawn_enter_lobby_title",
    help_id = "crimdawn_enter_lobby_desc",
    callback = "CrimDawn_CreateLobby",
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
Hooks:Add("MenuManagerBuildCustomMenus", "CrimDawn_MenuTweaks", function(menu_manager, nodes)
  local mainmenu = nodes.main
  local pausemenu = nodes.pause
  local lobbymenu = nodes.lobby

  -- Main Menu
  if mainmenu ~= nil then

    -- Play button
    managers.localization:add_localized_strings({
      ["crimdawn_continue_run_desc"] = managers.localization:text("crimdawn_play_next_desc", {
        HEIST = managers.localization:text("heist_" .. Global.CrimDawn.campaign[Global.CrimDawn.data.heists_won + 1])
      })
    })

    local HeistNumText = ""
    local IsEndless = Global.CrimDawn.data.heists_won >= #Global.CrimDawn.campaign
    if IsEndless then HeistNumText = (Global.CrimDawn.data.heists_won + 1)
    else HeistNumText = Global.CrimDawn.data.heists_won + 1 .. "/" .. #Global.CrimDawn.campaign end

    managers.localization:add_localized_strings({
      ["crimdawn_continue_run_title"] = managers.localization:text("crimdawn_play_next_title", {
        HEIST_NUM = HeistNumText
      })
    })

    -- Create Lobby
    managers.localization:add_localized_strings({
      ["crimdawn_enter_lobby_title"] = managers.localization:text("crimdawn_create_lobby_title"),
      ["crimdawn_enter_lobby_desc"] = managers.localization:text("crimdawn_create_lobby_desc")
    })

    InjectCrimDawnButtons(mainmenu)

    -- Hides all the unnecessary menu buttons
    local HiddenButtons = {
      crimenet = true, crimenet_offline = true, story_missions = true,
      fbi_files = true, gamehub = true, movie_theater = true,
      achievements = true
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

        item._parameters.text_id = "crimdawn_continue_run_title"
        item._parameters.help_id = "crimdawn_continue_run_desc"
        break
      end
    end

    -- Hides all the unnecessary menu buttons
    local HiddenButtons = { story_missions = true, achievements = true, side_jobs = true,
                            crimdawn_createlobby_btn = true, crimenet_nj = true, crimenet_j = true  }

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

Hooks:PreHook(MenuCallbackHandler, "start_the_game", "CrimDawn_PreStartGame", function(self)
  if Utils:IsInGameState() or CrimDawn.state.heist_started then return end


  if NetworkHelper:IsHost() then -- Pick starting heist if no active run
    -- Activate mutators
    dofile(CrimDawn.ModPath .. "lua/tables/mutators.lua")

    local NextJob
    -- Select next heist in campaign...
    if Global.CrimDawn.campaign[Global.CrimDawn.data.heists_won + 1] then
      NextJob = Global.CrimDawn.campaign[Global.CrimDawn.data.heists_won + 1]
    else NextJob = Global.CrimDawn.campaign[math.random(#Global.CrimDawn.campaign)] end
    -- ...or random heist if campaign is completed!

    self:start_job({
      difficulty = tweak_data.difficulties[CrimDawn.DiffScale()],
      job_id = NextJob
    })

    CrimDawn.Log(FileIdent, "Loading " .. managers.localization:text("heist_" .. NextJob) .. " on " ..
    tweak_data.difficulties[CrimDawn.DiffScale()])
  end

  -- Prevent from running again, otherwise peer mutators become desynced
  CrimDawn.state.heist_started = true
end)

Hooks:OverrideFunction(MenuCallbackHandler, "abort_mission", function(self)
  if game_state_machine:current_state_name() == "disconnected" then return end

  local function yes_func()
    NetworkHelper:SendToPeers("CrimDawn_ResetRun", true)
    CrimDawn:RunReset(FileIdent)

    self:load_start_menu_lobby()
    managers.preplanning:reset_rebuy_assets()
  end

  managers.menu:show_abort_mission_dialog({ yes_func = yes_func })
end)