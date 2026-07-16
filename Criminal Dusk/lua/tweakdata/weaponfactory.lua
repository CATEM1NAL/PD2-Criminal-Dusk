Hooks:PostHook(WeaponFactoryTweakData, "init", "CrimDusk_InitModTweakData", function(self)
  for _, data in pairs(self.parts) do data.is_a_unlockable = true end -- All weapon mods are infinite

  -- Sting grenades
  local HighDamage = -5
  local LowDamage = -25
  local StingDamage = {
    wpn_fps_gre_m79 = HighDamage, wpn_fps_gre_slap = HighDamage, wpn_fps_ass_contraband = HighDamage, wpn_fps_ass_groza = HighDamage,
    wpn_fps_gre_m32 = LowDamage, wpn_fps_gre_china = LowDamage, wpn_fps_gre_arbiter = LowDamage, wpn_fps_gre_ms3gl = LowDamage
  }

  for weapon, damage in pairs(StingDamage) do
    if self[weapon].override.wpn_fps_upg_a_grenade_launcher_hornet then
      self[weapon].override.wpn_fps_upg_a_grenade_launcher_hornet.stats.damage = damage

    elseif self[weapon].override.wpn_fps_upg_a_underbarrel_hornet then
      self[weapon].override.wpn_fps_upg_a_underbarrel_hornet.custom_stats.damage = damage
    end
  end
end)