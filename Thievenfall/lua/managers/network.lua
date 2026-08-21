local FileIdent = "NetworkManager"
NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "thievenfall_v" .. Global.CrimDusk.ModVersion

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
  NetworkHelper:AddReceiveHook("CrimDusk_CampaignEnded", "CrimDusk_SyncCampaignEnding", function(data, sender)
    Global.CrimDusk.data.lives = 30 + managers.player:upgrade_value("player", "additional_lives", 0)
    local EndingValue, HeistsPlayed = data:match("([^;]+);(.*)")

    local EndingBits = {}
    for i = 1, 6 do EndingBits[i] = bit.band(bit.rshift(tonumber(EndingValue), i - 1), 1) == 1 end
    -- convert ending number into bits so we can reconstruct the campaign summary locally

    local CampaignLength = HeistsPlayed >= 25 and loc:text("crimdusk_chat_campaign_long") or loc:text("crimdusk_chat_campaign_short")
    local CampaignWon = EndingBits[1] and loc:text("crimdusk_chat_success") or loc:text("crimdusk_chat_failure")
    local BainState = EndingBits[2] and loc:text("crimdusk_chat_bain_alive") or loc:text("crimdusk_chat_bain_dead")
    local VladState = EndingBits[3] and loc:text("crimdusk_chat_vlad_alive") or loc:text("crimdusk_chat_vlad_dead")
    local AlmirState = EndingBits[4] and loc:text("crimdusk_chat_almir_alive") or loc:text("crimdusk_chat_almir_dead")

    local HoxtonState, HectorState
    if EndingBits[5] then
      HoxtonState = loc:text("crimdusk_chat_hoxton_free")
      HectorState = EndingBits[6] and loc:text("crimdusk_chat_hector_dead") or loc:text("crimdusk_chat_hector_alive_free")

    else HoxtonState = loc:text("crimdusk_chat_hoxton_prison")
      HectorState = loc:text("crimdusk_chat_hector_alive_prison")
    end

    local ending = loc:text("crimdusk_chat_campaign_conclusion", {
      LENGTH = CampaignLength, SUCCESS = CampaignWon,
      BAIN = BainState, VLAD = VladState, ALMIR = AlmirState,
      HOXTON = HoxtonState, HECTOR = HectorState,
      HEISTS = HeistsPlayed
    })

    CrimDusk.ChatNotify(ending)
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
  CrimDusk.GoLoud()
end)