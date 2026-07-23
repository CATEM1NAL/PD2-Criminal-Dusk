local FileIdent = "Gameover"

Hooks:PostHook(GameOverState, "at_enter", "CrimDawn_HeistFailed", function(self)
  Global.CrimDusk.data.lives = 5

  if Global.CrimDusk.data.heists_won >= 78 then return end

  if NetworkHelper:IsHost() then
    local checkpoints = { [0] = true, [5] = true, [6] = true, [7] = true, [8] = true }

    if CrimDusk.SettingsData.permadeath then
      Global.CrimDusk.data.heists_won = 0

    elseif not checkpoints[Global.CrimDusk.data.heists_won] then
      Global.CrimDusk.data.heists_won = Global.CrimDusk.data.heists_won - 1
    end

  end
end)