local FileIdent = "NetworkManager"

local ModVersion = BLT.Mods:GetModByName("Criminal Dusk").version
NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. ModVersion
NetworkMatchMakingEPIC._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. ModVersion

NetworkHelper:AddReceiveHook("CrimDusk_HeistCount", "CrimDusk_SyncHeistCount", function(data, sender)
  local HostHeistsWon = tonumber(data)

  if HostHeistsWon > Global.CrimDusk.data.heists_won then
    Global.CrimDusk.data.heists_won = HostHeistsWon
  else return end

  if Global.CrimDusk.data.heists_won == #Global.CrimDusk.campaign then
    CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
    DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
      CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
    end)
  end

  CrimDusk:WriteSave(FileIdent, "received heist number [" .. data .. "] from host")
end)