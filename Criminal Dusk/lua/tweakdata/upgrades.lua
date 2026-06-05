-- Defines values for custom upgrade levels
Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "CrimDawn_InitPD2UpgradeTweakData", function(self)
  self.values.player.additional_lives = { 1, 2, 3, 4, 5, 6, 7, 8 }
  self.values.player.drill_speed_multiplier = { 0.85, 0.7, 0.55, 0.4, 0.25, 0.1 }
  self.values.player.drill_autorepair_1 = { 0.5 }
  self.values.player.drill_autorepair_2 = { 0.5 }

  -- Rise Above
  self.values.player.health_decrease = { 5, 7.5, 10 }
  self.values.player.armor_increase = { 1, 2, 3 }

  -- Health mult to flat
  self.values.player.health_multiplier = { 1 }
  self.values.team.health.passive_multiplier = { 1 }
  self.values.player.passive_health_multiplier = { 1, 2, 4, 8, 10 }
  self.values.player.mrwi_health_multiplier = { 2, 4, 6, 8 }
  self.values.player.minion_master_health_multiplier = { 3 }

  -- Armour
  self.values.player.body_armor.armor = { 0, 3, 4, 5.5, 8, 10, 13}
  self.values.player.body_armor.dodge = { 0.25, 0, -0.10, -0.15, -0.25, -0.5, -1 }

  -- Deployables
  self.doctor_bag_base = 3
  self.values.doctor_bag.amount_increase[1] = 1

  self.values.first_aid_kit.quantity[1] = 3
  self.values.first_aid_kit.downs_restore_chance[1] = 0.5

  table.insert(self.values.doctor_bag.quantity, 3)
  table.insert(self.values.ammo_bag.quantity, 3)
end)

-- Creates definitions for custom upgrade levels
Hooks:PostHook(UpgradesTweakData, "_player_definitions", "CrimDawn_PlayerUpgradeDefinitions", function(self)
  for i = 3, 8 do -- Nine Lives
    self.definitions["player_additional_lives_" .. i] = deep_clone(self.definitions.player_additional_lives_2)
    self.definitions["player_additional_lives_" .. i].upgrade.value = i
  end

  for i = 2, 3 do -- Rise Above
    self.definitions["player_health_decrease_" .. i] = deep_clone(self.definitions.player_health_decrease_1)
    self.definitions["player_health_decrease_" .. i].upgrade.value = i
  end
end)