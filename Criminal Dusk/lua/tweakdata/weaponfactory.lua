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

  -- Shotgun ammo types
  self.parts.wpn_fps_upg_a_custom_free.custom_stats.rays = 6 -- 000 Buckshot
  self.parts.wpn_fps_upg_a_slug.stats.damage = 25 -- Slug
  self.parts.wpn_fps_upg_a_explosive.stats.damage = 50 -- HE

  -- Dragon's Breath
  self.parts.wpn_fps_upg_a_dragons_breath.stats.damage = -15
  self.parts.wpn_fps_upg_a_dragons_breath.stats.spread = -3

  -- Tombstone
  self.parts.wpn_fps_upg_a_rip.custom_stats.rays = 1
  self.parts.wpn_fps_upg_a_rip.stats.damage = 20
  self.parts.wpn_fps_upg_a_rip.stats.spread = 2

  -- Flechette
  self.parts.wpn_fps_upg_a_piercing.custom_stats.rays = 12
  self.parts.wpn_fps_upg_a_piercing.stats.damage = -5

  -- Remove DLC buckshot
  local shotguns = { "wpn_fps_shot_saiga", "wpn_fps_shot_r870", "wpn_fps_shot_huntsman", "wpn_fps_shot_serbu", "wpn_fps_sho_ben", "wpn_fps_sho_striker",
    "wpn_fps_sho_ksg", "wpn_fps_pis_judge", "wpn_fps_sho_spas12", "wpn_fps_shot_b682", "wpn_fps_sho_aa12", "wpn_fps_sho_boot", "wpn_fps_shot_m37",
    "wpn_fps_shot_m1897", "wpn_fps_sho_m590", "wpn_fps_sho_rota", "wpn_fps_sho_basset", "wpn_fps_sho_x_basset", "wpn_fps_pis_x_judge", "wpn_fps_sho_x_rota",
    "wpn_fps_sho_coach", "wpn_fps_sho_ultima", "wpn_fps_sho_sko12", "wpn_fps_sho_x_sko12", "wpn_fps_sho_supernova" }
  for _, weapon in ipairs(shotguns) do
    for index, ammo in ipairs(self[weapon].uses_parts) do
      if ammo == "wpn_fps_upg_a_custom" then table.remove(self[weapon].uses_parts, index) break end
    end
  end
end)