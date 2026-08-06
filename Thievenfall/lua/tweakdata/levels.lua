Hooks:PostHook(LevelsTweakData, "init", "CrimDusk_LevelTweakInit", function(self)
  -- Tutorial loadouts are unforced
  self.short1_stage1.force_equipment = nil
  self.short1_stage1.disable_mutators = nil

  self.short1_stage2.force_equipment = nil
  self.short1_stage2.disable_mutators = nil

  self.short2_stage1.force_equipment = nil
  self.short2_stage1.disable_mutators = nil

  for _, LevelID in ipairs(Global.CrimDusk.LoudHeists) do self[LevelID].ghost_bonus = nil end

  -- Heist specific suits
  for _, heist in ipairs(Global.CrimDusk.suits.loud) do self[heist].player_style = "slaughterhouse" end
  for _, heist in ipairs(Global.CrimDusk.suits.stealth) do self[heist].player_style = "sneak_suit" end
  for _, heist in ipairs(Global.CrimDusk.suits.suit) do self[heist].player_style = "none" end
  for heist, suit in pairs(Global.CrimDusk.suits.custom) do self[heist].player_style = suit end
end)