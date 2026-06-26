local FileIdent = "Victory"

Hooks:PostHook(VictoryState, "at_enter", "CrimDusk_HeistWon", function(self)
  if NetworkHelper:IsClient() then return end

  -- Heist completion
  if managers.job:on_last_stage() then
    Global.CrimDusk.data.heists_won = Global.CrimDusk.data.heists_won + 1
    CrimDusk.Log(FileIdent, "Heists won: " .. Global.CrimDusk.data.heists_won)
    CrimDusk:WriteSave(FileIdent, "heist completed")

    if Global.CrimDusk.data.heists_won == #Global.CrimDusk.campaign then
      CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
      DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
        CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
      end)
    end

  end

  NetworkHelper:SendToPeers("CrimDusk_HeistCount", Global.CrimDusk.data.heists_won)
end)