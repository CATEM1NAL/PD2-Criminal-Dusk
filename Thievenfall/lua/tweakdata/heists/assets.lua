Hooks:PostHook(AssetsTweakData, "_init_assets", "CrimDusk_InitAssetTweak", function(self)
  -- Remove unneeded assets
  self.grenade_crate.stages = {}
  self.safe_escape.stages = {}
  self.nightclub_badmusic.stages = {}
  self.camera_access.stages = {}
  self.roberts_plan_a.stages = {}
  self.sah_cutter.stages = {}
  self.bodybags_bag.stages = { "welcome_to_the_jungle_2", "election_day_2", "firestarter_2", "family", "cage", "dark", "fish", "dah", "tag" }

  for _, asset in ipairs(Global.CrimDusk.assets.lvl1) do self[asset].upgrade_lock = { category = "player", upgrade = "additional_assets" } end
  for _, asset in ipairs(Global.CrimDusk.assets.lvl2) do self[asset].upgrade_lock = { category = "player", upgrade = "buy_bodybags_asset" } end
end)