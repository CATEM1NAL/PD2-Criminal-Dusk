Hooks:PostHook(PrePlanningTweakData, "init", "CrimDusk_InitPreplanTweak", function(self)
  -- Disable grenade case
  self.types.grenade_crate.total = 0
  self.types.grenade_crate.prio = 0

  self.categories.insider_help.upgrade_lock = nil

  for _, asset in ipairs(Global.CrimDusk.preplan.lvl1) do self.types[asset].upgrade_lock = { category = "player", upgrade = "additional_assets" } end
  for _, asset in ipairs(Global.CrimDusk.preplan.lvl2) do self.types[asset].upgrade_lock = { category = "player", upgrade = "buy_bodybags_asset" } end
end)