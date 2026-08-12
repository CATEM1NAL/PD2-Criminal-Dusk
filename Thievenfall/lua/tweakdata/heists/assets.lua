Hooks:PostHook(AssetsTweakData, "_init_assets", "CrimDusk_InitAssetTweak", function(self)
  -- Remove unneeded assets
  self.grenade_crate.stages = {}
  self.safe_escape.stages = {}
  self.nightclub_badmusic.stages = {}

  local LoudAssets = {
    "ammo_bag", "mallcrasher_ammo", "nightclub_ammo", 
    "health_bag", "mallcrasher_health", "nightclub_health", 
  }
  for _, asset in ipairs(LoudAssets) do self[asset].upgrade_lock = { category = "player", upgrade = "additional_assets" } end

  local StealthAssets = {
    "election_day_2_ladder", "election_day_2_keycard", 
  }
  for _, asset in ipairs(StealthAssets) do self[asset].upgrade_lock = { category = "player", upgrade = "buy_bodybags_asset" } end
end)