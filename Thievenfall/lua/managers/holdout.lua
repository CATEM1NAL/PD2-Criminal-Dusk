local FileIdent = "HoldoutManager"

-- Set tooltip for menu button
if not Global.skirmish_manager or not Global.skirmish_manager.active_weekly then
  Hooks:PostHook(SkirmishManager, "activate_weekly_skirmish", "CrimDusk_InitHoldoutManager", function()
    local days = math.floor(math.max(Global.skirmish_manager.active_weekly.end_timestamp - os.time(), 0) / 86400)
    managers.localization:add_localized_strings({
      ["crimdusk_play_holdout_desc"] = managers.localization:text("crimdusk_holdout_desc", { DAYS = days })
    })
  end)
end

Hooks:OverrideFunction(SkirmishManager, "on_start_assault", function(self)
  local wave_number = managers.groupai:state():get_assault_number()

  Global.game_settings.difficulty = Global.CrimDusk.holdout_difficulty[wave_number]
  tweak_data:set_difficulty()
  CrimDusk.Log(FileIdent, "Difficulty changed to: " .. Global.CrimDusk.holdout_difficulty[wave_number], true)

  self:update_matchmake_attributes()
end)