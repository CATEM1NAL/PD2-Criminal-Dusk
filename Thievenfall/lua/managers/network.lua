local FileIdent = "NetworkManager"

NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. Global.CrimDusk.ModVersion
NetworkMatchMakingEPIC._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. Global.CrimDusk.ModVersion

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

    elseif HeistsWon == #Global.CrimDusk.campaign then
      CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
      DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
        CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
      end)
    end
  end)
end

-- Host hooks
if not NetworkHelper:IsHost() then return end

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