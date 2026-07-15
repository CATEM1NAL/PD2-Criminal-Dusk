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
end)