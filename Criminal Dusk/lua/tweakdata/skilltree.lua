local function digest(value)
	return Application:digest_value(value, true)
end

Hooks:PostHook(SkillTreeTweakData, "init", "CrimDawn_SkillTreeTweakInit", function(self)
  self.tier_unlocks = { digest(0), digest(0), digest(0), digest(0) }
  self.tier_cost = { { 12, 12 }, { 12, 12 }, { 12, 12 }, { 12, 12 } }
  table.insert(self.specializations[15][5].upgrades, "player_health_decrease_2")
  table.insert(self.specializations[15][7].upgrades, "player_health_decrease_3")
end)