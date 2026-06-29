Hooks:PostHook(UpgradesTweakData, "init", "CrimDusk_InitUpgradeTweakData", function(self)
  self.level_tree[40] = {
    name_id = "weapons",
    upgrades = { "bessy", "money", "xmas_snowball", "piggy_hammer" }
  }
  self.values.shape_charge.quantity = { 4, 8, 12 }
end)

-- Defines values for custom upgrade levels
Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "CrimDusk_InitPD2UpgradeTweakData", function(self)
  self.values.rep_upgrades.values = { 0 }
  self.values.player.additional_lives = { 1, 2 }
  self.values.player.drill_autorepair_1 = { 0.5 }
  self.values.player.drill_autorepair_2 = { 0.5 }
  self.values.weapon.passive_swap_speed_multiplier = { 1.8, 2.6 }
  self.values.player.flashbang_multiplier = { 0.75, 0.25 }
  self.values.player.suppression_multiplier = { 1.25 }
  self.values.snp.graze_damage = {
    { radius = 100, damage_factor = 0, damage_factor_headshot = 0.5 },
    { radius = 50, damage_factor = 0, damage_factor_headshot = 1 }
  }

  local WeaponClasses = { "shotgun", "pistol", "assault_rifle", "smg", "saw", "lmg", "snp" }
  for _, class in ipairs(WeaponClasses) do
    self.values[class].hip_fire_spread_multiplier = { 0.5 }
  end

  -- Rise Above
  self.values.player.health_decrease = { 2.5, 5, 7.5 }
  self.values.player.armor_increase = { 2, 4, 6 }

  -- Hysteria stacks
  self.cocaine_stacks_tick_rounding = 2
  self.cocaine_stacks_tick_t = 0.1
  self.cocaine_stacks_decay_t = self.cocaine_stacks_tick_rounding
  self.cocaine_stacks_decay_amount_per_tick = 0
  self.cocaine_stacks_decay_percentage_per_tick = 1

  -- Tag Team
  self.values.player.tag_team_base[1].kill_health_gain = 0.2
  self.values.player.tag_team_base[1].kill_extension = 1
  self.values.player.tag_team_damage_absorption[1].kill_gain = 0.1

  -- Stoic
  self.values.player.damage_control_passive[1] = { 100, 3.4 }
  self.values.player.damage_control_auto_shrug = { 1.5 }

  -- Leech
  self.values.player.copr_activate_bonus_health_ratio = { 0.01, 0.4 }

  -- Health mult to flat
  self.values.player.health_multiplier = { 1 }
  self.values.team.health.passive_multiplier = { 1 }
  self.values.player.passive_health_multiplier = { 1, 2, 4, 8, 10 }
  self.values.player.mrwi_health_multiplier = { 2, 4, 6, 8 }
  self.values.player.minion_master_health_multiplier = { 3 }

  -- Health regen
  self.values.player.passive_health_regen = { 0.3 }
  self.values.player.hostage_health_regen_addend = { 0.2, 0.5 }

  -- Armour
  self.values.player.body_armor.armor = { 0, 3, 4, 5.5, 8, 10, 13}
  self.values.player.body_armor.dodge = { 0.25, 0, -0.10, -0.15, -0.25, -0.5, -1 }

  -- Deployables
  self.doctor_bag_base = 4
  self.values.doctor_bag.amount_increase = { -3, -2, -1 }

  self.ammo_bag_base = 6
  self.values.ammo_bag.ammo_increase = { -4.5, -3, -1.5 }

  self.values.first_aid_kit.quantity[1] = 3
  self.values.first_aid_kit.downs_restore_chance[1] = 0.5
end)

Hooks:PostHook(UpgradesTweakData, "_init_values", "CrimDusk_InitUpgradeTweakData", function(self)
  self.values.weapon.swap_speed_multiplier = { 1.615 }
end)

-- Create definitions for custom upgrade levels
Hooks:PostHook(UpgradesTweakData, "_player_definitions", "CrimDusk_PlayerUpgradeDefinitions", function(self)
  for i = 2, 3 do -- Rise Above
    self.definitions["player_health_decrease_" .. i] = deep_clone(self.definitions.player_health_decrease_1)
    self.definitions["player_health_decrease_" .. i].upgrade.value = i
  end
  self.definitions.player_copr_activate_bonus_health_ratio_1.upgrade.value = 2
end)

Hooks:PostHook(UpgradesTweakData, "_trip_mine_definitions", "CrimDusk_TripMineUpgradeDefinitions", function(self)
  self.definitions.shape_charge_quantity_increase_3 = deep_clone(self.definitions.shape_charge_quantity_increase_2)
  self.definitions.shape_charge_quantity_increase_3.upgrade.value = 3
end)