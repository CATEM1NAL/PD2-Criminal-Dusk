local FileIdent = "Victory"

Hooks:PostHook(VictoryState, "at_enter", "CrimDawn_HeistWon", function(self)
  Global.CrimDawn.data.x.lives = math.min(math.max(Global.CrimDawn.data.x.lives + 1, 1), 5)

  -- Heist completion
  if managers.job:on_last_stage() then
    Global.CrimDawn.data.game.heists_won = Global.CrimDawn.data.game.heists_won + 1
    CrimDawn.Log(FileIdent, "Heists won: " .. Global.CrimDawn.data.game.heists_won)

    if Global.CrimDawn.data.heists_won == #Global.CrimDawn.campaign then
      CrimDawn:WriteSave(FileIdent, "run completed")
      CrimDawn.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
      DelayedCalls:Add("CrimDawn_VictoryTease", 3, function()
        CrimDawn.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
      end)
    end

  end

  NetworkHelper:SendToPeers("CrimDawn_HeistCount", Global.CrimDawn.data.heists_won)
end)