Hooks:PostHook(LevelsTweakData, "init", "CrimDusk_LevelTweakInit", function(self)
  self.short1_stage1.force_equipment = nil
  self.short1_stage1.disable_mutators = nil

  self.short1_stage2.force_equipment = nil
  self.short1_stage2.disable_mutators = nil

  self.short2_stage1.force_equipment = nil
  self.short2_stage1.disable_mutators = nil

  if Global.CrimDusk then
    for _, LevelID in ipairs(Global.CrimDusk.LoudHeists) do self[LevelID].ghost_bonus = nil end
  end

  -- Heist specific suits
  local LoudHeists = {
    "watchdogs_1", "watchdogs_1_night", "watchdogs_2", "watchdogs_2_day", "man", "welcome_to_the_jungle_2", "firestarter_1",
    "arm_cro", "arm_hcm", "arm_par", "arm_fac", "arm_for", "mia_2", "hox_1", "hox_2", "crojob3", "hox_3", "shoutout_raid",
    "jolly", "pbr", "pbr2", "chew", "friend", "spa", "des", "deep"
  }
  for _, heist in ipairs(LoudHeists) do self[heist].player_style = "slaughterhouse" end

  local StealthHeists = {
    "framing_frame_3", "short1_stage1", "short1_stage2", "firestarter_2", "election_day_2", "kosugi", "gallery", "dark", "tag", "sand"
  }
  for _, heist in ipairs(StealthHeists) do self[heist].player_style = "sneak_suit" end

  local SuitHeists = {
    "red2", "flat", "nmh", "four_stores", "mallcrasher", "branchbank", "ukrainian_job", "nightclub", "alex_1",
    "family", "roberts", "election_day_3", "big", "mia_1", "cage", "kenaz", "peta", "peta2", "born", "run", "dah", "rvd2",
    "chas", "bex", "pex", "fex", "pent", "corp"
  }
  for _, heist in ipairs(SuitHeists) do self[heist].player_style = "none" end

  local SpecificSuits = {
    mad = "winter_suit", pines = "rusbear", cane = "elfsuit", arm_und = "jumpsuit", mus = "cable_guy", crojob2 = "cable_guy",
    arena = "leatherfluff", moon = "lonorwa", fish = "tux", brb = "rusbear", mex = "bikervest", chca = "tux", ranc = "bullranch",
    trai = "raincoat"
  }
  for heist, suit in pairs(SpecificSuits) do self[heist].player_style = suit end
end)