Hooks:PostHook(DLCTweakData, "init", "CrimDusk_InitDLCTweakData", function(self)
  self.wild_char = deep_clone(self.wild)
  self.wild_char.dlc = "has_wild_char"
  self.wild_char.content.loot_global_value = "wild_char"
  self.wild_char.content.loot_drops = nil

  self.freed_old_hoxton.content.loot_global_value = "freed_old_hoxton"
  self.freed_old_hoxton.achievement_id = nil
end)