local FileIdent = "Gameover"

Hooks:PostHook(GameOverState, "at_enter", "CrimDawn_HeistFailed", function(self)
  if NetworkHelper:IsHost() and CrimDusk.SettingsData.permadeath then CrimDusk:Reset() return end

  Global.CrimDusk.data.lives = 4
  if NetworkHelper:IsClient() or (Global.CrimDusk.data.heists_won >= 78) then return end

  local checkpoints = { [0] = true, [5] = true, [6] = true, [7] = true, [8] = true }
  if not checkpoints[Global.CrimDusk.data.heists_won] then
    Global.CrimDusk.data.heists_won = Global.CrimDusk.data.heists_won - 1
  end
end)