local FileIdent = "MenuManager"

local function SelectNextHeist()
  local permadeath = CrimDusk.IsPermadeath()
  local NextJob = Global.CrimDusk.campaign[Global.CrimDusk.data["heists_won" .. permadeath] + 1]

  -- ...or random heist if campaign is completed!
  if not NextJob or permadeath == "_perma" then

    -- If all heists have been played, start a new cycle
    local heist_chain = "heist_chain" .. permadeath
    local HeistsPlayed = #Global.CrimDusk.data["heist_chain" .. permadeath]
    if Global.CrimDusk.data[heist_chain][HeistsPlayed] == "vit" then CrimDusk.SoftReset() end

    math.randomseed(os.time() + (os.clock() * 1000))
    local ValidHeists = deep_clone(Global.CrimDusk.custom_campaign_base)

    -- Add mini-campaigns into pool
    local CampaignData = Global.CrimDusk.mini_campaign_data
    for campaign, _ in pairs(Global.CrimDusk.mini_campaigns) do
      table.insert(ValidHeists, Global.CrimDusk.mini_campaigns[campaign][Global.CrimDusk.data[campaign .. permadeath]])
    end

    -- Add Cook Off if Hector dead
    if Global.CrimDusk.data["hector_dead" .. permadeath] then table.insert(ValidHeists, "rat") end

    -- Are friends captured?
    local BainCaptured = false
    local VladCaptured = false
    local AlmirCaptured = false
    local LockeBetrayed = false

    for _, heist in ipairs(Global.CrimDusk.data["heist_chain" .. permadeath]) do
      if heist == "cd_reservoir" and not Global.CrimDusk.data["bain_freed" .. permadeath] then BainCaptured = true
      elseif heist == "chas" and not Global.CrimDusk.data["vlad_freed" .. permadeath] then VladCaptured = true
      elseif heist == "bex" and not Global.CrimDusk.data["almir_freed" .. permadeath] then AlmirCaptured = true
      elseif heist == "wwh" then LockeBetrayed = true end
    end

    CrimDusk.Log(FileIdent,
      "Bain Captured: " .. tostring(BainCaptured) ..
      "\nVlad Captured: " .. tostring(VladCaptured) ..
      "\nAlmir Captured: " .. tostring(AlmirCaptured) ..
      "\nLocke Betrayed: " .. tostring(LockeBetrayed),
      true
    )

    if BainCaptured then
      CrimDusk.Log(FileIdent, "Adding end-game Locke heists...", true)
      for heist, _ in pairs(CampaignData.bain_captured) do table.insert(ValidHeists, heist) end
    end

    -- Set up heist list
    for i = #ValidHeists, 1, -1 do
      local heist = ValidHeists[i]
      local LockeHeist = CampaignData.silk_road[heist] or CampaignData.city_of_gold[heist] or CampaignData.texas_heat[heist]

      -- Remove Hector heists if he's dead
      if Global.CrimDusk.data["hector_dead" .. permadeath] and CampaignData.hector_dead[heist] then
        CrimDusk.Log(FileIdent, "Hector is dead; removing " .. heist, true)
        table.remove(ValidHeists, i)

      -- Remove friend heists if captured
      elseif BainCaptured and not CampaignData.bain_captured[heist] and not LockeHeist then
        CrimDusk.Log(FileIdent, "Bain is captured; removing " .. heist, true)
        table.remove(ValidHeists, i)

      elseif VladCaptured and CampaignData.vlad_captured[heist] then
        CrimDusk.Log(FileIdent, "Vlad is captured; removing " .. heist, true)
        table.remove(ValidHeists, i)

      elseif AlmirCaptured and CampaignData.almir_captured[heist] then
        CrimDusk.Log(FileIdent, "Almir is captured; removing " .. heist, true)
        table.remove(ValidHeists, i)

      -- Remove early Locke heists if he has betrayed us
      elseif LockeBetrayed == true and (heist == "pbr" or heist == "pbr2" or heist == "run") then
        CrimDusk.Log(FileIdent, "Locke has betrayed us; removing " .. heist, true)
        table.remove(ValidHeists, i)

      -- Remove Border Crossing if Bain hasn't been freed yet
      elseif heist == "mex" and not Global.CrimDusk.data["bain_freed" .. permadeath] then
        CrimDusk.Log(FileIdent, "Bain hasn't been captured; removing " .. heist, true)
        table.remove(ValidHeists, i)

      -- Remove Dentist heists if Bain freed
      elseif CampaignData.no_dentist[heist] and Global.CrimDusk.data["bain_freed" .. permadeath] then
        CrimDusk.Log(FileIdent, "Bain has been freed; removing " .. heist, true)
        table.remove(ValidHeists, i)

      -- Remove out of place Locke heists if Bain has been freed
      elseif (heist == "pbr" or heist == "pbr2" or heist == "wwh" or heist == "des") and Global.CrimDusk.data["bain_freed" .. permadeath] then
        CrimDusk.Log(FileIdent, "Bain has been freed; removing " .. heist, true)
        table.remove(ValidHeists, i)

      -- Remove San Martin if no Rust
      elseif heist == "bex" and not Global.CrimDusk.data.rust_recruited then
        CrimDusk.Log(FileIdent, "Rust hasn't been recruited; removing " .. heist, true)
        table.remove(ValidHeists, i)
      end
    end

    -- Add event heists
    table.insert(ValidHeists, "haunted")
    table.insert(ValidHeists, "nail")
    table.insert(ValidHeists, "help")
    table.insert(ValidHeists, "hvh")

    -- Remove already played heists
    for _, heist in ipairs(Global.CrimDusk.data[heist_chain]) do
      for i = #ValidHeists, 1, -1 do
        if ValidHeists[i] == heist then table.remove(ValidHeists, i) break end
      end
    end

    -- White House is always last
    if not next(ValidHeists) then table.insert(ValidHeists, "vit") end

    CrimDusk.Log(FileIdent, "Heists left: " .. #ValidHeists, true)
    if Global.CrimDusk.Developer then Utils.PrintTable(ValidHeists) end

    NextJob = ValidHeists[math.random(#ValidHeists)]
    CrimDusk.Log(FileIdent, "Loading " .. managers.localization:text("heist_" .. NextJob) .. " on " .. tweak_data.difficulties[CrimDusk.DiffScale()])
  end

  return NextJob
end

function MenuCallbackHandler:CrimDusk_CreateLobby() self:create_lobby() end
function MenuCallbackHandler:CrimDusk_Safehouse() managers.menu:open_node("custom_safehouse") end

-- Playing offline
function MenuCallbackHandler:CrimDusk_PlayGame()
  MenuCallbackHandler:play_single_player()
  MenuCallbackHandler:start_single_player_job({
    difficulty = tweak_data.difficulties[CrimDusk.DiffScale()],
    one_down = CrimDusk.SettingsData.permadeath,
    job_id = SelectNextHeist()
  })
  self:start_the_game()
end

-- Weekly Holdout
function MenuCallbackHandler:CrimDusk_Holdout()
  if NetworkHelper:IsClient() then self:create_lobby() end
  local weekly_skirmish = managers.skirmish:active_weekly()
  local job_data = {
    difficulty = "overkill_145",
    weekly_skirmish = true,
    job_id = weekly_skirmish.id
  }
  self:start_job(job_data)
end

-- Mod options
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
  CrimDusk.Reset()

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
  if node.callback_handler then new_item:set_callback_handler(node.callback_handler) end

  local position = 1
  table.insert(node._items, position, new_item)

  -- Add the safehouse button
  data = { type = "CoreMenuItem.Item" }
  params = {
    name = "crimdusk_safehouse",
    text_id = "menu_cn_chill",
    help_id = "crimdusk_safehouse_desc",
    callback = "CrimDusk_Safehouse",
    font_size = 30,
    font = tweak_data.menu.pd2_large_font
  }

  new_item = node:create_item(data, params)

  new_item.dirty_callback = callback(node, node, "item_dirty")
  if node.callback_handler then new_item:set_callback_handler(node.callback_handler) end

  position = 1
  table.insert(node._items, position, new_item)

  -- Add play offline button
  data = { type = "CoreMenuItem.Item" }
  params = {
    name = "crimdusk_play_offline",
    text_id = "crimdusk_play_offline",
    help_id = "crimdusk_play_offline_desc",
    callback = "CrimDusk_PlayGame",
    font_size = 25,
    font = tweak_data.menu.pd2_large_font
  }

  new_item = node:create_item(data, params)

  new_item.dirty_callback = callback(node, node, "item_dirty")
  if node.callback_handler then new_item:set_callback_handler(node.callback_handler) end

  position = 3
  table.insert(node._items, position, new_item)

  -- Weekly Holdout
  data = { type = "CoreMenuItem.Item" }
  params = {
    name = "crimdusk_play_holdout",
    text_id = "crimdusk_play_holdout",
    help_id = "crimdusk_play_holdout_desc",
    callback = "CrimDusk_Holdout",
    font_size = 25,
    font = tweak_data.menu.pd2_large_font
  }

  new_item = node:create_item(data, params)

  new_item.dirty_callback = callback(node, node, "item_dirty")
  if node.callback_handler then new_item:set_callback_handler(node.callback_handler) end

  position = 2
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
      crimenet = true, crimenet_offline = true, story_missions = true,
      crimdusk_safehouse = true, crimdusk_play_holdout = true
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
    InjectCrimDuskButtons(lobbymenu)

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
      story_missions = true, crimenet_nj = true, crimenet_j = true,
      crimdusk_createlobby_btn = true, crimdusk_play_offline = true
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
  if NetworkHelper:IsClient() or Global.job_manager.current_job then return end

  self:start_job({
    difficulty = tweak_data.difficulties[CrimDusk.DiffScale()],
    one_down = CrimDusk.SettingsData.permadeath,
    job_id = SelectNextHeist()
  })
end)