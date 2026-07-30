Hooks:PostHook(BlackMarketTweakData, "_init_armors", "CrimDusk_InitArmorsBMTweak", function(self)
  self.armors.level_1 = nil
end)

Hooks:PostHook(BlackMarketTweakData, "_init_deployables", "CrimDusk_InitDeployablesBMTweak", function(self)
  self.deployables.grenade_crate = nil
  self.deployables.sentry_gun_silent = nil
  self.deployables.armor_kit = nil
end)