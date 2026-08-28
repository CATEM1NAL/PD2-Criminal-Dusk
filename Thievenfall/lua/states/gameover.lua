if Global.game_settings and Global.game_settings.level_id == "chill_combat" then return end
local FileIdent = "Gameover"

Hooks:PostHook(GameOverState, "at_enter", "CrimDusk_HeistFailed", function(self)
  if managers.skirmish:is_skirmish() then -- Weekly Holdout
    Global.CrimDusk.data.weekly_holdout = Global.skirmish_manager.active_weekly
    CrimDusk:WriteSave(FileIdent, "holdout failed")
  return end

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

  elseif Global.CrimDusk.data.heists_won >= #Global.CrimDusk.campaign then
    Global.CrimDusk.data.heist_chain = Global.CrimDusk.data.heist_chain or {}
    Global.CrimDusk.data.heists_skipped = Global.CrimDusk.data.heists_skipped or {}

    local CurrentHeists = Global.CrimDusk.data.next_heists
    for i = 1, #CurrentHeists do
      if CurrentHeists[i] == Global.CrimDusk.job_to_wrapper[managers.job:current_job_id()] or managers.job:current_job_id() then
        table.insert(Global.CrimDusk.data.heist_chain, (Global.CrimDusk.job_to_wrapper[CurrentHeists[i]] or CurrentHeists[i]))

      else table.insert(Global.CrimDusk.data.heists_skipped, (Global.CrimDusk.job_to_wrapper[CurrentHeists[i]] or CurrentHeists[i])) end
    end
    Global.CrimDusk.data.next_heists = {}

  elseif not checkpoints[Global.CrimDusk.data.heists_won] then
    Global.CrimDusk.data.heists_won = Global.CrimDusk.data.heists_won - 1
  end

  CrimDusk:WriteSave(FileIdent, "heist failed")
end)