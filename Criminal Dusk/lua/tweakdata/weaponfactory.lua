Hooks:PostHook(WeaponFactoryTweakData, "init", "CrimDawn_UnlockAllMods", function(self)
  for _, data in pairs(self.parts) do data.is_a_unlockable = true end
end)