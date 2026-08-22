if Global.game_settings and (Global.game_settings.level_id == "chill_combat" or Global.CrimDusk.holdouts[Global.game_settings.level_id]) then return end
local FileIdent = "Gameover"

Hooks:PostHook(GameOverState, "at_enter", "CrimDawn_HeistFailed", function(self)
  if NetworkHelper:IsHost() and CrimDusk.SettingsData.permadeath then
    CrimDusk:SoftReset()
    Global.CrimDusk.data.heists_won_perma = 0
    CrimDusk.EndingText(false)
  return end

  local checkpoints = { [5] = true, [6] = true, [7] = true, [8] = true }
  Global.CrimDusk.data.lives = 30 + managers.player:upgrade_value("player", "additional_lives", 0)

  if NetworkHelper:IsClient() then CrimDusk:WriteSave(FileIdent, "heist failed") return
  elseif managers.job:current_job_id() == "vit" then 
    CrimDusk.SoftReset()
    CrimDusk.EndingText(false)

  elseif Global.CrimDusk.data.heists_won < 5 then Global.CrimDusk.data.heists_won = 5

  elseif Global.CrimDusk.data.heists_won >= 78 then
    Global.CrimDusk.data.heist_chain = Global.CrimDusk.data.heist_chain or {}
    table.insert(Global.CrimDusk.data.heist_chain, (Global.CrimDusk.job_to_wrapper[managers.job:current_job_id()] or managers.job:current_job_id()))

  elseif not checkpoints[Global.CrimDusk.data.heists_won] then
    Global.CrimDusk.data.heists_won = Global.CrimDusk.data.heists_won - 1
  end

  CrimDusk:WriteSave(FileIdent, "heist failed")
end)