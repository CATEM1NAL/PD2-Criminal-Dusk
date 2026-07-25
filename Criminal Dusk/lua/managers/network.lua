local FileIdent = "NetworkManager"

NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. Global.CrimDusk.ModVersion
NetworkMatchMakingEPIC._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. Global.CrimDusk.ModVersion

NetworkHelper:AddReceiveHook("CrimDusk_HeistCount", "CrimDusk_CheckRunWon", function(data, sender)
  local HeistsWon = tonumber(data)

  if HeistsWon < 5 then
    Hooks:Add("LocalizationManagerPostInit", "CrimDusk_PDTHNames", function(loc)
      managers.localization:load_localization_file(CrimDusk.ModPath .. "loc/pdth_difficulties.json")
    end)

  elseif HeistsWon == #Global.CrimDusk.campaign then
    CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
    DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
      CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
    end)
  end
end)

NetworkHelper:AddReceiveHook("CrimDusk_MaskedUp", "CrimDusk_ForceLoudNetwork", function()
  if Global.CrimDusk.StealthableHeists[Global.game_settings.level_id] or managers.groupai:state():is_police_called() then return end
  CrimDusk.GoLoud()
end)