Hooks:PreHook(FireTweakData, "_process_dot_entries", "CrimDawn_FireTweakProcess", function(self)
  local FireWeapons = {
    weapon_kacchainsaw_flamethrower = 0.5, weapon_money = 0.5, ammo_dragons_breath = 1, melee_spoon_gold = 0.2,
    ammo_system_low = 0.25, weapon_system = 0.5, ammo_system_high = 0.75,
    ammo_flamethrower_mk2_rare = 0.25, weapon_flamethrower_mk2 = 0.5, ammo_flamethrower_mk2_welldone = 0.75,
    proj_molotov = 1, proj_launcher_incendiary = 0.9, proj_launcher_incendiary_arbiter = 1.7, proj_fire_com = 1.2,
    proj_molotov_groundfire = 1, proj_launcher_incendiary_groundfire = 1, proj_launcher_incendiary_arbiter_groundfire = 1,
    equipment_tripmine_groundfire = 1, enemy_triad_boss_groundfire = 1, enemy_mutator_cloaker_groundfire = 1
  }

  for weapon, dmg in pairs(FireWeapons) do self.dot_entries.fire[weapon].dot_damage = dmg end
end)