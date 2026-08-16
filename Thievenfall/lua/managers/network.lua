local FileIdent = "NetworkManager"
NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "thievenfall_v" .. Global.CrimDusk.ModVersion

-- General hooks
NetworkHelper:AddReceiveHook("CrimDusk_HUDUpdateDownCounter", "CrimDusk_ReceiveDownCounterUpdate", function(revives, sender)
  if not tonumber(revives) or not Utils:IsInGameState() then return end
  local character_data = managers.criminals:character_data_by_peer_id(sender)
  if character_data and character_data.panel_id then managers.hud:set_teammate_revives(character_data.panel_id, tonumber(revives)) end
end)

-- Client hooks
if NetworkHelper:IsClient() then
  -- Receive heist count from host
  NetworkHelper:AddReceiveHook("CrimDusk_HeistCount", "CrimDusk_CheckRunWon", function(data, sender)
    local HeistsWon = tonumber(data) or 0

    if HeistsWon < 5 then
      Hooks:Add("LocalizationManagerPostInit", "CrimDusk_PDTHNames", function(loc)
        loc:add_localized_strings({
          ["menu_difficulty_normal"] = loc:text("crimdusk_pdth_normal"),
          ["menu_asset_risklevel_0"] = loc:text("crimdusk_pdth_normal"),
          ["menu_difficulty_hard"] = loc:text("crimdusk_pdth_hard"),
          ["menu_asset_risklevel_1"] = loc:text("crimdusk_pdth_hard"),
          ["menu_difficulty_very_hard"] = loc:text("crimdusk_pdth_very_hard"),
          ["menu_asset_risklevel_2"] = loc:text("crimdusk_pdth_very_hard"),
          ["menu_difficulty_easy_wish"] = loc:text("crimdusk_pdth_mayhem"),
          ["menu_asset_risklevel_4"] = loc:text("crimdusk_pdth_mayhem")
        })
      end)
    end
  end)

  -- Sync campaign victory
  NetworkHelper:AddReceiveHook("CrimDusk_CampaignWon", "CrimDusk_SyncCampaignVictory", function(data, sender)
    Global.CrimDusk.data.lives = 30 + managers.player:upgrade_value("player", "additional_lives", 0)
    CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_victory"))
    DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
      CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_victory2"))
    end)
  end)

  -- Sync campaign victory
  NetworkHelper:AddReceiveHook("CrimDusk_CampaignFailed", "CrimDusk_SyncCampaignFailure", function(data, sender)
    Global.CrimDusk.data.lives = 30 + managers.player:upgrade_value("player", "additional_lives", 0)
    CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_failure"))
    DelayedCalls:Add("CrimDusk_FailureTease", 3, function()
      CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_failure2"))
    end)
  end)
return end

-- Host hooks
-- Heist count requested from client
NetworkHelper:AddReceiveHook("CrimDusk_RequestHeistCount", "CrimDusk_HostHeistCountRequest", function(_, sender)
  local heists = Global.CrimDusk.data.heists_won or 0
  if CrimDusk.SettingsData.permadeath then heists = #Global.CrimDusk.campaign + 1 end
  NetworkHelper:SendToPeer(sender, "CrimDusk_HeistCount", heists)
end)

-- Force maskup
NetworkHelper:AddReceiveHook("CrimDusk_MaskedUp", "CrimDusk_ForceLoudNetwork", function()
  if Global.CrimDusk.heists[Global.game_settings.level_id].stealthable or managers.groupai:state():is_police_called() then return end
  CrimDusk.GoLoud()
end)