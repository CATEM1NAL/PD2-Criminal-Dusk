local ModVersion = BLT.Mods:GetModByName("Criminal Dusk").version
NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. ModVersion
NetworkMatchMakingEPIC._BUILD_SEARCH_INTEREST_KEY = "Criminal Dusk v" .. ModVersion

NetworkHelper:AddReceiveHook("CrimDawn_HeistCount", "CrimDawn_SyncHeistCount", function(data, sender)
  local HostHeistsWon = tonumber(data)

  if HostHeistsWon > Global.CrimDawn.data.game.heists_won then
    Global.CrimDawn.data.heists_won = HostHeistsWon
  else return end

  if Global.CrimDawn.data.heists_won == #Global.CrimDawn.campaign then
    CrimDawn.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
    DelayedCalls:Add("CrimDawn_VictoryTease", 3, function()
      CrimDawn.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
    end)
  end

  CrimDawn:WriteSave(FileIdent, "received heist number [" .. data .. "] from host")
end)