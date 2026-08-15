local FileIdent = "Gameover"

Hooks:PostHook(GameOverState, "at_enter", "CrimDawn_HeistFailed", function(self)
  if NetworkHelper:IsHost() and CrimDusk.SettingsData.permadeath then
    CrimDusk:SoftReset()
    Global.CrimDusk.data.heists_won_perma = 0
  return end

  Global.CrimDusk.data.lives = 30 + managers.player:upgrade_value("player", "additional_lives", 0)
  if NetworkHelper:IsClient() or (Global.CrimDusk.data.heists_won >= 78) then return end
  if Global.CrimDusk.data.heists_won < 5 then Global.CrimDusk.data.heists_won = 5 return end

  local checkpoints = { [0] = true, [5] = true, [6] = true, [7] = true, [8] = true }
  if not checkpoints[Global.CrimDusk.data.heists_won] then
    Global.CrimDusk.data.heists_won = Global.CrimDusk.data.heists_won - 1
  end
end)