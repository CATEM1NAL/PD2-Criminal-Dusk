Hooks:PostHook(PrePlanningTweakData, "init", "CrimDusk_InitPreplanTweak", function(self)
  self.types.grenade_crate.total = 0
  self.types.grenade_crate.prio = 0
end)