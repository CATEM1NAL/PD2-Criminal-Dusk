Hooks:PostHook(BlackMarketTweakData, "_init_deployables", "CrimDusk_InitBMTweak", function(self)
  self.deployables.grenade_crate = nil
  self.deployables.sentry_gun_silent = nil
  self.deployables.armor_kit = nil
end)