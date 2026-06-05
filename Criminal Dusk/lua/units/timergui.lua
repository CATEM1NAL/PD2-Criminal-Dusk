TimerGui.upgrade_colors = {
  upgrade_color_0 = tweak_data.screen_colors.item_stage_3,
	upgrade_color_1 = Global.CrimDawn.archicolours.green_alt,
	upgrade_color_2 = Global.CrimDawn.archicolours.blue_alt,
	upgrade_color_3 = Global.CrimDawn.archicolours.pink_alt,
	upgrade_color_4 = Global.CrimDawn.archicolours.yellow_alt,
	upgrade_color_5 = Global.CrimDawn.archicolours.orange_alt,
	upgrade_color_6 = Global.CrimDawn.archicolours.red_alt
}

Hooks:PreHook(TimerGui, "_start", "CrimDawn_StartTimerGUI", function(self)
  if CrimDawn.OnFinalHeist() or managers.job:current_level_id() == "tag" then return end
  local TimerMult = 1
  self:set_timer_multiplier(TimerMult)
end)