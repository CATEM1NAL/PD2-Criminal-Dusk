Hooks:PostHook(AssetsTweakData, "_init_assets", "CrimDusk_InitAssetTweak", function(self)
  self.grenade_crate.stages = {}
  self.safe_escape.stages = {}
  self.ammo_bag.upgrade_lock = { category = "player", upgrade = "additional_assets" }
  self.health_bag.upgrade_lock = { category = "player", upgrade = "additional_assets" }
end)