local FileIdent = "MenuManager"

function MenuCallbackHandler:CrimDusk_CreateLobby() self:create_lobby() end
function MenuCallbackHandler:CrimDusk_Safehouse() managers.menu:open_node("custom_safehouse") end

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
  if node.callback_handler then
    new_item:set_callback_handler(node.callback_handler)
  end

  local position = 2
  table.insert(node._items, position, new_item)

  -- Add the safehouse button
  local data = {
    type = "CoreMenuItem.Item",
  }
  local params = {
    name = "crimdusk_safehouse",
    text_id = "menu_cn_chill",
    help_id = "crimdusk_safehouse_desc",
    callback = "CrimDusk_Safehouse",
    font_size = 35,
    font = tweak_data.menu.pd2_large_font
  }

  local new_item = node:create_item(data, params)

  new_item.dirty_callback = callback(node, node, "item_dirty")
  if node.callback_handler then
    new_item:set_callback_handler(node.callback_handler)
  end

  local position = 3
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
      crimenet = true, crimenet_offline = true, story_missions = true, crimdusk_safehouse = true
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
      story_missions = true, crimdusk_createlobby_btn = true, crimenet_nj = true, crimenet_j = true
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

  -- Select next heist in campaign...
  local permadeath = CrimDusk.IsPermadeath()
  local NextJob = Global.CrimDusk.campaign[Global.CrimDusk.data["heists_won" .. permadeath] + 1]

  -- ...or random heist if campaign is completed!
  if not NextJob then

    -- If all heists have been played, start a new cycle
    local heist_chain = "heist_chain" .. permadeath
    local HeistsPlayed = #Global.CrimDusk.data["heist_chain" .. permadeath]
    if Global.CrimDusk.data[heist_chain][HeistsPlayed] == "vit" then CrimDusk.SoftReset() end

    math.randomseed(os.time() + (os.clock() * 1000))
    local ValidHeists = deep_clone(Global.CrimDusk.custom_campaign_base)

    -- Add mini-campaigns into pool
    for campaign, _ in pairs(Global.CrimDusk.mini_campaigns) do
      table.insert(ValidHeists, Global.CrimDusk.mini_campaigns[campaign][Global.CrimDusk.data[campaign .. permadeath]])
    end

    -- Add Cook Off if Hector dead
    if Global.CrimDusk.data["hector_dead" .. permadeath] then table.insert(ValidHeists, "rat") end

    -- Are friends captured?
    local BainCaptured = false
    if not Global.CrimDusk.data["bain_freed" .. permadeath] then
      for _, heist in ipairs(Global.CrimDusk.data["heist_chain" .. permadeath]) do
        if heist == "cd_reservoir" then BainCaptured = true end
      end
    end

    local VladCaptured = false
    if not Global.CrimDusk.data["vlad_freed" .. permadeath] then
      for _, heist in ipairs(Global.CrimDusk.data["heist_chain" .. permadeath]) do
        if heist == "chas" then VladCaptured = true end
      end
    end

    local AlmirCaptured = false
    if not Global.CrimDusk.data["almir_freed" .. permadeath] then
      for _, heist in ipairs(Global.CrimDusk.data["heist_chain" .. permadeath]) do
        if heist == "bex" then AlmirCaptured = true end
      end
    end

    -- Set up heist list
    local CampaignData = Global.CrimDusk.mini_campaign_data
    for i = #ValidHeists, 1, -1 do
      local heist = ValidHeists[i]

      -- Remove Hector heists if he's dead
      if Global.CrimDusk.data["hector_dead" .. permadeath] then
        if CampaignData.hector_dead[heist] then table.remove(ValidHeists, i) end

     -- Remove friend heists if captured
      elseif BainCaptured and not CampaignData.bain_captured[heist] then
        table.remove(ValidHeists, i)

      elseif VladCaptured and CampaignData.vlad_captured[heist] then
        table.remove(ValidHeists, i)

      elseif AlmirCaptured and CampaignData.almir_captured[heist] then
        table.remove(ValidHeists, i)

      -- Remove Border Crossing if Bain hasn't been freed yet
      elseif heist == "mex" and not Global.CrimDusk.data["bain_freed" .. permadeath] then
        table.remove(ValidHeists, i)

      -- Remove Dentist heists if Bain freed
      elseif CampaignData.no_dentist[heist] and Global.CrimDusk.data["bain_freed" .. permadeath] then
        table.remove(ValidHeists, i)

      -- Remove Point Break & Alaskan Deal if Bain has been freed
      elseif (heist == "pbr" or heist == "pbr2" or heist == "wwh") and Global.CrimDusk.data["bain_freed" .. permadeath] then
        table.remove(ValidHeists, i)

      -- Remove San Martin if no Rust
      elseif heist == "bex" and not Global.CrimDusk.data.rust_recruited then
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

    CrimDusk.Log(FileIdent, "Heists left: " .. #ValidHeists)
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