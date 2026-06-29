local FileIdent = "NetworkManager"

local ModVersion = BLT.Mods:GetModByName("Criminal Dusk").version
NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. ModVersion
NetworkMatchMakingEPIC._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. ModVersion

NetworkHelper:AddReceiveHook("CrimDusk_HeistCount", "CrimDusk_CheckRunWon", function(data, sender)
  local HeistsWon = tonumber(data)

  if HeistsWon < 5 then
    Hooks:Add("LocalizationManagerPostInit", "CrimDusk_PDTHNames", function(loc)
      loc:load_localization_file(CrimDusk.ModPath .. "loc/pdth_difficulties.json")
    end)
  end

  if HeistsWon == #Global.CrimDusk.campaign then
    CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
    DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
      CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
    end)
  end
end)