Hooks:PostHook(UpgradesTweakData, "init", "CrimDusk_InitUpgradeTweakData", function(self)
  -- Consumables unlock every 10 levels
  table.insert(self.level_tree[10].upgrades, "pocket_ecm_jammer") -- Pocket ECM
  table.insert(self.level_tree[20].upgrades, "smoke_screen_grenade") -- Smoke Grenade
  table.insert(self.level_tree[30].upgrades, "tag_team") -- Gas Dispenser
  table.insert(self.level_tree[50].upgrades, "copr_ability") -- Leech Ampule

  -- Event items unlock at 40
  self.level_tree[40] = {
    name_id = "weapons",
    upgrades = { "bessy", "money", "xmas_snowball", "piggy_hammer", "chico_injector" }
  }

  -- Remove skill points at 10th levels
  for i = 1, 10 do self.definitions["rep_upgrade" .. i].value = 0 end

  for level, _ in pairs(self.level_tree) do
    for i = #self.level_tree[level].upgrades, 1, -1 do
      if self.level_tree[level].upgrades[i]:match("^(.-)%d*$") == "rep_upgrade" then
        table.remove(self.level_tree[level].upgrades, i)
      end
    end
  end

  -- Skills
  self.values.player.additional_lives = { 1, 2 } -- Nine Lives
  self.values.weapon.passive_swap_speed_multiplier = { 1.8, 2.6 } -- Swap Speed
  self.values.weapon.swap_speed_multiplier = { 1.615 } -- Swap Speed 3
  self.values.weapon.clip_ammo_increase = { 0.5, 1 } -- Mag Plus
  self.values.player.flashbang_multiplier = { 0.75, 0.25 } -- Stun Resistance
  self.values.player.suppression_multiplier = { 1.25 } -- Oppressor
  self.values.temporary.overkill_damage_multiplier = { { 1.5, 5 } } -- Overkill
  self.values.player.pick_up_ammo_multiplier = { 1.25, 1.5 } -- Fully Loaded
  self.values.player.armor_multiplier = { 1.5 } -- Bulletproof
  self.values.player.melee_kill_snatch_pager_chance = { 0.25, 0.5, 0.75, 1 } -- Pager Snatch
  self.values.player.melee_sharp_damage_multiplier = { 2, 3, 4 } -- Vicious Warrior
  self.values.player.critical_hit_chance = { 0.1, 0.2 } -- Hypocritical
  self.values.player.assets_cost_multiplier = { 0.1, 0.25, 0.5 } -- Nebula Plus
  self.values.player.revive_damage_reduction = { 0.5 } -- Combat Medic 1
  self.values.temporary.revive_damage_reduction = { { 0.5, 5 } } -- Combat Medic 2
  self.values.cooldown.long_dis_revive = { { 0.5, 1 } } -- Inspire
  self.first_aid_kit.revived_damage_reduction = { {0.5, 5}, {0, 5} } -- Painkillers
  self.values.player.convert_enemies_damage_multiplier = { 1.5, 2 } -- Joker damage
  self.values.player.passive_convert_enemies_health_multiplier = { 0.5, 0.01 } -- Joker DR
  self.values.weapon.passive_reload_speed_multiplier = { 1.25, 1.5, 2 } -- Mag Funnel
  self.values.player.regain_throwable_from_ammo = { 1, 2 } -- Scrounger
  self.values.weapon.passive_damage_multiplier = { 1.1, 1.25 } -- Fast and Furious
  self.values.weapon.passive_headshot_damage_multiplier = { 1.25, 1.5 } -- Helmet Popping
  self.values.player.intimidate_range_mul = { 1.5, 2 } -- Deep Throat
  self.values.player.weapon_accuracy_increase = { 2, 4 } -- Accuracy increase
  self.values.weapon.fire_rate_multiplier = { 1.5, 2 } -- Illegal Parts
  self.values.weapon.knock_down = { 1.1, 1.2 } -- Heavy Impact
  self.values.weapon.armor_piercing_chance = { 0.5 } -- Black Tip
  self.close_combat_distance = 1000 -- Distance for Close Combat/panic on kill
  self.killshot_close_panic_range = 1000 -- Distance that panic on kill spreads
  self.values.player.tier_armor_multiplier = { 1.05, 1.1, 1.2, 1.3, 1.4, 1.4 } -- Armour increase
  self.values.player.camouflage_bonus = { 0.667, 0.5 } -- Optical Illusions

  -- More Blood to Bleed
  self.values.player.down_time_bonus = { 5, 10, 15, 20 } -- More Blood to Bleed
  self.definitions.player_bleedout_timer_1 = {
    category = "feature",
    upgrade = {
      category = "player",
      upgrade = "down_time_bonus",
      value = 1
    }
  }

  -- Repair System
  self.values.player.drill_autorepair_1 = { 0.5 }
  self.values.player.drill_autorepair_2 = { 0.5 }

  -- Shell Dimension
  local Level1, Level2 = 0.1, 0.25
  self.values.shotgun.consume_no_ammo_chance = { Level1, Level2 }

  self.values.pistol.consume_no_ammo_chance = { Level1, Level2 }
  self.definitions.pistol_consume_no_ammo_chance_1 = deep_clone(self.definitions.shotgun_consume_no_ammo_chance_1)
  self.definitions.pistol_consume_no_ammo_chance_1.upgrade.category = "pistol"

  self.values.assault_rifle.consume_no_ammo_chance = { Level1, Level2 }
  self.definitions.assault_rifle_consume_no_ammo_chance_1 = deep_clone(self.definitions.shotgun_consume_no_ammo_chance_1)
  self.definitions.assault_rifle_consume_no_ammo_chance_1.upgrade.category = "assault_rifle"

  self.values.snp.consume_no_ammo_chance = { Level1, Level2 }
  self.definitions.snp_consume_no_ammo_chance_1 = deep_clone(self.definitions.shotgun_consume_no_ammo_chance_1)
  self.definitions.snp_consume_no_ammo_chance_1.upgrade.category = "snp"

  self.values.smg.consume_no_ammo_chance = { Level1, Level2 }
  self.definitions.smg_consume_no_ammo_chance_1 = deep_clone(self.definitions.shotgun_consume_no_ammo_chance_1)
  self.definitions.smg_consume_no_ammo_chance_1.upgrade.category = "smg"

  self.values.lmg.consume_no_ammo_chance = { Level1, Level2 }
  self.definitions.lmg_consume_no_ammo_chance_1 = deep_clone(self.definitions.shotgun_consume_no_ammo_chance_1)
  self.definitions.lmg_consume_no_ammo_chance_1.upgrade.category = "lmg"

  self.values.minigun.consume_no_ammo_chance = { Level1, Level2 }
  self.definitions.minigun_consume_no_ammo_chance_1 = deep_clone(self.definitions.shotgun_consume_no_ammo_chance_1)
  self.definitions.minigun_consume_no_ammo_chance_1.upgrade.category = "minigun"


  -- Trip mine radius
  self.values.trip_mine.explosion_size_multiplier_1 = { 1.5 }
  self.values.trip_mine.explosion_size_multiplier_2 = { 1.5 }

  -- Graze
  self.values.snp.graze_damage = {
    { radius = 100, damage_factor = 0, damage_factor_headshot = 0.5 },
    { radius = 50, damage_factor = 0, damage_factor_headshot = 1 }
  }

  -- Transfusion
  self.revive_health_multiplier = { 1.5, 2 }
  self.values.player.revive_health_boost = { 1, 2 }

  -- Loud And Proud
  self.values.player.detection_risk_damage_multiplier = {
    { 0.03, 7, "above", 40 },
    { 0.05, 7, "above", 40 }
  }

  -- From The Hip
  local WeaponClasses = { "shotgun", "pistol", "assault_rifle", "smg", "saw", "lmg", "snp" }
  for _, class in ipairs(WeaponClasses) do
    self.values[class].hip_fire_spread_multiplier = { 0.5 }
  end

  -- Rise Above
  self.values.player.health_decrease = { 2.5, 5, 7.5 }
  self.values.player.armor_increase = { 2, 4, 6 }

  -- Hysteria stacks
  self.cocaine_stacks_dmg_absorption_value = 0.05
  self.cocaine_stacks_tick_rounding = 2
  self.cocaine_stacks_tick_t = 0.1
  self.max_cocaine_stacks_per_tick = 480
  self.max_total_cocaine_stacks = self.max_cocaine_stacks_per_tick
  self.cocaine_stacks_decay_t = self.cocaine_stacks_tick_rounding
  self.cocaine_stacks_decay_amount_per_tick = 0
  self.cocaine_stacks_decay_percentage_per_tick = 1
  self.cocaine_stacks_convert_levels = { 30, 20 }

  -- Gambler
  self.loose_ammo_restore_health_values = {
    { 0, 1 }, { 0, 2 }, { 0, 3 },
    base = 0, cd = 0,
    multiplier = 0.2
  }
  self.values.temporary.loose_ammo_restore_health = {
    { { 0, 1 }, 0 },
    { { 0, 2 }, 0 },
    { { 0, 3 }, 0 }
  }
  self.values.temporary.loose_ammo_give_team = { { true, 0 } }
  self.loose_ammo_give_team_ratio = 1

  -- Infiltrator/Sociopath
  self.values.melee.stacking_hit_damage_multiplier = { 0.1, 0.5, 1 }
  self.definitions.melee_stacking_hit_damage_multiplier_3 = deep_clone(self.definitions.melee_stacking_hit_damage_multiplier_2)
  self.definitions.melee_stacking_hit_damage_multiplier_3.upgrade.value = 3

  self.values.melee.stacking_hit_expire_t = { 3, 1 }

  -- Tag Team
  self.values.player.tag_team_base[1].kill_health_gain = 0.2
  self.values.player.tag_team_base[1].kill_extension = 1
  self.values.player.tag_team_damage_absorption = { { kill_gain = 0.04, max = 1.2 } }
  self.values.player.tag_team_cooldown_drain = { { owner = 0, tagged = 0 }, { owner = 1, tagged = 1 } }

  -- Stoic
  self.values.player.damage_control_passive[1] = { 100, 3.4 }
  self.values.player.damage_control_auto_shrug = { 1.5 }
  self.values.player.damage_control_cooldown_drain = { { 0, 0 }, { 100, 1 } }

  -- Leech
  self.values.player.copr_activate_bonus_health_ratio = { 0.01, 0.4 }
  self.definitions.player_copr_activate_bonus_health_ratio_1.upgrade.value = 2

  -- Kingpin
  self.values.temporary.chico_injector = {
    { 0.25, 6 },
    { 0.5, 6 },
    { 0.75, 6 }
  }

  -- Health mult to flat
  self.values.player.health_multiplier = { 1 }
  self.values.team.health.passive_multiplier = { 1 }
  self.values.player.passive_health_multiplier = { 1, 2, 4, 8, 10 }
  self.values.player.mrwi_health_multiplier = { 2, 4, 6, 8 }
  self.values.player.minion_master_health_multiplier = { 3 }

  -- Health regen
  self.values.player.passive_health_regen = { 0.1 }
  self.values.player.hostage_health_regen_addend = { 0.2, 0.5 }

  -- Armour
  self.values.player.body_armor.armor = { 0, 2, 3, 4, 6, 8, 10 }
  self.values.player.body_armor.dodge = { 0.25, 0, -0.10, -0.15, -0.25, -0.5, -1 }

  -- Weapon speed penalties
  self.weapon_movement_penalty.lmg = 0.75
  self.weapon_movement_penalty.minigun = 0.5

  -- Deployables
  self.doctor_bag_base = 1
  self.values.doctor_bag.amount_increase = { 1, 2, 3 }
  self.values.doctor_bag.quantity = { 1, 2 }

  self.ammo_bag_base = 1.5
  self.values.ammo_bag.ammo_increase = { 1.5, 3, 4.5 }
  self.values.ammo_bag.quantity = { 1, 2 }

  self.values.first_aid_kit.quantity[1] = 3
  self.values.first_aid_kit.downs_restore_chance = { 0.5, 1 }

  self.values.shape_charge.quantity = { 4, 8, 12 }
  self.definitions.shape_charge_quantity_increase_3 = deep_clone(self.definitions.shape_charge_quantity_increase_2)
  self.definitions.shape_charge_quantity_increase_3.upgrade.value = 3

  -- New upgrade definitions
  NewUpgrades = {
    doctor_bag_quantity = 2, ammo_bag_quantity = 2, first_aid_kit_downs_restore_chance = 2, melee_stacking_hit_expire_t = 2,
    player_detection_risk_damage_multiplier = 2, player_intimidate_range_mul = 2, player_revive_health_boost = 2,
    weapon_passive_headshot_damage_multiplier = 2, weapon_passive_damage_multiplier = 2, player_regain_throwable_from_ammo = 2,
    player_weapon_accuracy_increase = 2, weapon_fire_rate_multiplier = 2, pistol_consume_no_ammo_chance = 2,
    assault_rifle_consume_no_ammo_chance = 2, snp_consume_no_ammo_chance = 2, smg_consume_no_ammo_chance = 2,
    lmg_consume_no_ammo_chance = 2, minigun_consume_no_ammo_chance = 2,

    player_health_decrease = 3, player_melee_sharp_damage_multiplier = 3, player_assets_cost_multiplier = 3,
    doctor_bag_amount_increase = 3, ammo_bag_ammo_increase = 3, weapon_passive_reload_speed_multiplier = 3,
    temporary_chico_injector = 3,

    player_melee_kill_snatch_pager_chance = 4, player_bleedout_timer = 4
  }

  for upgrade, count in pairs(NewUpgrades) do
    for i = 2, count do
      local BaseUpgrade
      if self.definitions[upgrade] then BaseUpgrade = self.definitions[upgrade]
      elseif self.definitions[upgrade .. "_" .. 1] then BaseUpgrade = self.definitions[upgrade .. "_" .. 1]
      elseif self.definitions[upgrade .. 1] then BaseUpgrade = self.definitions[upgrade .. 1] end

      assert(BaseUpgrade, "no base upgrade found for upgrade " .. upgrade)

      self.definitions[upgrade .. "_" .. i] = deep_clone(BaseUpgrade)
      self.definitions[upgrade .. "_" .. i].upgrade.value = i
    end
  end
end)