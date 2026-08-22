Hooks:PostHook(SkirmishManager, "activate_weekly_skirmish", "CrimDusk_InitHoldoutManager", function()
  managers.localization:add_localized_strings({
    ["crimdusk_play_holdout_desc"] = managers.localization:text("crimdusk_holdout_desc", { DAYS = math.floor(math.max(Global.skirmish_manager.active_weekly.end_timestamp - os.time(), 0) / 86400) })
  })
end)