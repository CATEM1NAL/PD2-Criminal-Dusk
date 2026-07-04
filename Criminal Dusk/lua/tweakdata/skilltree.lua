local function digest(value)
  return Application:digest_value(value, true)
end

Hooks:PostHook(SkillTreeTweakData, "init", "CrimDusk_SkillTreeTweakInit", function(self)
  self.tier_unlocks = { digest(0), digest(0), digest(0), digest(0) }
  self.tier_cost = { { 1, 1, 1, 1, 1, 1 }, { 2, 2, 2, 2, 2 }, { 3, 3, 3, 3, 3 }, { 4, 4, 4, 4, 4 } }

  -- Default upgrades
  self.default_upgrades = {
    "player_fall_health_damage_multiplier",
    "player_special_enemy_highlight",
    "player_hostage_trade",
    "player_sec_camera_highlight",
    "player_corpse_dispose",
    "player_corpse_dispose_amount_1",
    "carry_interact_speed_multiplier_1",
    "carry_interact_speed_multiplier_2",
    "carry_movement_speed_multiplier",
    "trip_mine_can_switch_on_off",
    "striker_reload_speed_default",
    "temporary_first_aid_damage_reduction",
    "temporary_passive_revive_damage_reduction_2",
    "akimbo_recoil_index_addend_1",
    "cable_tie",
    "ammo_bag_ammo_increase1",
    "doctor_bag_amount_increase1",
    -- REMOVE WHEN SKILLS ARE ADDED:
    "doctor_bag",
    "ammo_bag",
    "trip_mine",
    "ecm_jammer",
    "first_aid_kit",
    "sentry_gun",
    "bodybags_bag",
    "saw",
    "cable_tie",
    "jowi",
    "x_1911",
    "x_b92fs",
    "x_deagle",
    "x_g22c",
    "x_g17",
    "x_usp",
    "x_sr2",
    "x_mp5",
    "x_akmsu",
    "x_packrat",
    "x_p226",
    "x_m45",
    "x_mp7",
    "x_ppk"
  }
  table.insert(self.default_upgrades, "chico_injector")
  table.insert(self.default_upgrades, "temporary_chico_injector_1")
  table.insert(self.default_upgrades, "smoke_screen_grenade")
  table.insert(self.default_upgrades, "tag_team")
  table.insert(self.default_upgrades, "player_tag_team_base")
  table.insert(self.default_upgrades, "player_tag_team_cooldown_drain_1")
  table.insert(self.default_upgrades, "pocket_ecm_jammer")
  table.insert(self.default_upgrades, "player_pocket_ecm_jammer_base")
  table.insert(self.default_upgrades, "copr_ability")
  table.insert(self.default_upgrades, "temporary_copr_ability_1")
  table.insert(self.default_upgrades, "player_copr_static_damage_ratio_1")
  table.insert(self.default_upgrades, "player_copr_kill_life_leech_1")

  -- Disable perk decks
  for i = 1, #self.specializations do
    for _, data in ipairs(self.specializations[i]) do
      if data.upgrades and next(data.upgrades) then data.upgrades = {} end
    end
  end

  self.skills.temp_skill = {
    { upgrades = { "temp_upgrade" }, cost = self.costs.default },
    name_id = "temp_skill_name", desc_id = "temp_desc", icon_xy = { 0, 0 }
  }

  -- MASTERMIND --

  self.trees[1].tiers = {
    { "combat_medic" },
    { "tea_time", "fast_learner" },
    { "tea_cookies", "medic_2x" },
    { "inspire" }
  }
  self.trees[2].tiers = {
    { "triathlete" },
    { "cable_guy", "joker" },
    { "stockholm_syndrome", "control_freak" },
    { "black_marketeer" }
    
  }
  self.trees[3].tiers = {
    { "stable_shot" },
    { "rifleman", "sharpshooter" },
    { "spotter_teamwork", "speedy_reload" },
    { "single_shot_ammo_return" }
  }

  -- ENFORCER --
  self.skills.underdog = {
    { upgrades = { "player_damage_multiplier_outnumbered" }, cost = self.costs.default },
    name_id = "menu_underdog_beta", desc_id = "menu_underdog_beta_desc", icon_xy = { 2, 1 }
  }
  self.skills.overdog = {
    { upgrades = { "player_damage_dampener_outnumbered" }, cost = self.costs.default },
    name_id = "menu_overdog", desc_id = "menu_overdog_desc", icon_xy = { 6, 6 }
  }
  self.skills.shotgun_impact = {
    { upgrades = { "shotgun_damage_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "shotgun_damage_multiplier_2" }, cost = self.costs.default },
    name_id = "menu_shotgun_impact_beta", desc_id = "menu_shotgun_impact_beta_desc", icon_xy = { 4, 1 }
  }
  self.skills.shotgun_stability = {
    { upgrades = { "shotgun_recoil_index_addend" }, cost = self.costs.default },
    name_id = "temp_skill_name", desc_id = "menu_shotgun_stability_desc", icon_xy = { 4, 1 }
  }
  self.skills.shotgun_reload = {
    { upgrades = { "shotgun_reload_speed_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "shotgun_reload_speed_multiplier_2" }, cost = self.costs.default },
    name_id = "menu_shotgun_cqb_beta", desc_id = "menu_shotgun_cqb_beta_desc", icon_xy = { 5, 1 }
  }
  self.skills.shotgun_ads_speed = {
    { upgrades = { "shotgun_enter_steelsight_speed_multiplier" }, cost = self.costs.default },
    name_id = "temp_skill_name", desc_id = "menu_shotgun_ads_speed_desc", icon_xy = { 8, 5 }
  }
  self.skills.shotgun_hipfire = {
    { upgrades = { "shotgun_hip_run_and_shoot_1" }, cost = self.costs.default },
    name_id = "menu_close_by_beta", desc_id = "menu_close_by_beta_desc", icon_xy = { 8, 6 }
  }
  self.skills.shotgun_rof = {
    { upgrades = { "shotgun_hip_rate_of_fire_1" }, cost = self.costs.default },
    name_id = "menu_shotgun_rof", desc_id = "menu_shotgun_rof_desc", icon_xy = { 8, 6 }
  }
  self.skills.shotgun_accuracy = {
    { upgrades = { "shotgun_steelsight_accuracy_inc_1" }, cost = self.costs.default },
    name_id = "temp_skill_name", desc_id = "menu_shotgun_accuracy_desc", icon_xy = { 8, 5 }
  }
  self.skills.shotgun_range = {
    { upgrades = { "shotgun_steelsight_range_inc_1" }, cost = self.costs.default },
    name_id = "menu_far_away_beta", desc_id = "menu_far_away_beta_desc", icon_xy = { 8, 5 }
  }
  self.skills.overkill = {
    { upgrades = { "player_overkill_damage_multiplier" }, cost = self.costs.default },
    { upgrades = { "player_overkill_all_weapons" }, cost = self.costs.default },
    name_id = "menu_overkill_beta", desc_id = "menu_overkill_beta_desc", icon_xy = { 3, 2 }
  }
  self.skills.crew_recovery = {
    { upgrades = { "team_armor_regen_time_multiplier" }, cost = self.costs.default },
    name_id = "menu_team_armor_regen", desc_id = "menu_team_armor_regen_desc", icon_xy = { 8, 10 }
  }
  self.skills.shock_awe = {
    { upgrades = { "player_shield_knock" }, cost = self.costs.default },
    name_id = "menu_iron_man_beta", desc_id = "menu_iron_man_beta_desc", icon_xy = { 8, 10 }
  }
  self.skills.nerves_of_steel = {
    { upgrades = { "player_interacting_damage_multiplier" }, cost = self.costs.default },
    name_id = "menu_nerves_of_steel_name", desc_id = "menu_nerves_of_steel_desc", icon_xy = { 8, 9 }
  }
  self.skills.thick_skin = {
    { upgrades = { "player_level_2_armor_addend", "player_level_3_armor_addend", "player_level_4_armor_addend" }, cost = self.costs.default },
    name_id = "menu_thick_skin", desc_id = "menu_show_of_force_beta_desc", icon_xy = { 2, 12 }
  }
  self.skills.transporter = {
    { upgrades = { "carry_throw_distance_multiplier" }, cost = self.costs.default },
    name_id = "menu_pack_mule_beta", desc_id = "menu_pack_mule_beta_desc", icon_xy = { 8, 8 }
  }
  self.skills.armor_bag_reduction = {
    { upgrades = { "player_armor_carry_bonus_1" }, cost = self.costs.default },
    name_id = "menu_armor_bag_reduction", desc_id = "menu_armor_bag_reduction_desc", icon_xy = { 6, 0 }
  }
  self.skills.enforcer_recovery = {
    { upgrades = { "player_armor_regen_time_mul_1" }, cost = self.costs.default },
    name_id = "menu_oppressor_beta", desc_id = "menu_oppressor_beta_desc", icon_xy = { 2, 12 }
  }
  self.skills.stun_resistance = {
    { upgrades = { "player_flashbang_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "player_flashbang_multiplier_2" }, cost = self.costs.default },
    name_id = "menu_stun_resistance", desc_id = "menu_stun_resistance_desc", icon_xy = { 6, 1 }
  }
  self.skills.juggernaut = {
    { upgrades = { "body_armor6" }, cost = self.costs.default },
    name_id = "menu_juggernaut_beta", desc_id = "menu_juggernaut_beta_desc", icon_xy = { 3, 1 }
  }
  self.skills.bulletproof = {
    { upgrades = { "player_armor_multiplier" }, cost = self.costs.default },
    name_id = "menu_bulletproof_name", desc_id = "menu_bulletproof_desc", icon_xy = { 6, 4 }
  }
  self.skills.extra_ammo_box = {
    { upgrades = { "player_double_drop_1" }, cost = self.costs.default },
    name_id = "temp_skill_name", desc_id = "menu_extra_ammo_box_desc", icon_xy = { 8, 11 }
  }
  self.skills.scavenger = {
    { upgrades = { "player_increased_pickup_area_1" }, cost = self.costs.default },
    name_id = "menu_scavenging_beta", desc_id = "menu_scavenger_desc", icon_xy = { 8, 11 }
  }
  self.skills.portable_saw = {
    { upgrades = { "saw_secondary" }, cost = self.costs.default },
    name_id = "menu_portable_saw_beta", desc_id = "menu_portable_saw_desc", icon_xy = { 0, 1 }
  }
  self.skills.carbon_blade = {
    { upgrades = { "player_saw_speed_multiplier_2", "saw_lock_damage_multiplier_2" }, cost = self.costs.default },
    { upgrades = { "saw_enemy_slicer", "saw_armor_piercing_chance" }, cost = self.costs.default },
    { upgrades = { "saw_ignore_shields_1", "saw_panic_when_kill_1" }, cost = self.costs.default },
    name_id = "menu_carbon_blade", desc_id = "menu_carbon_blade_desc", icon_xy = { 0, 2 }
  }
  self.skills.ammobag_quantity = {
    { upgrades = { "ammo_bag_quantity" }, cost = self.costs.default },
    name_id = "menu_stockpile_name", desc_id = "menu_stockpile_desc", icon_xy = { 7, 1 }
  }
  self.skills.ammobag_capacity = {
    { upgrades = { "ammo_bag_ammo_increase2" }, cost = self.costs.default },
    { upgrades = { "ammo_bag_ammo_increase3" }, cost = self.costs.default },
    name_id = "temp_skill_name", desc_id = "menu_ammobag_capacity_desc", icon_xy = { 1, 0 }
  }
  self.skills.fully_loaded = {
    { upgrades = { "player_pick_up_ammo_multiplier" }, cost = self.costs.default },
    { upgrades = { "player_pick_up_ammo_multiplier_2" }, cost = self.costs.default },
    name_id = "menu_bandoliers_beta", desc_id = "menu_fully_loaded_desc", icon_xy = { 3, 0 }
  }
  self.skills.scrounger = {
    { upgrades = { "player_regain_throwable_from_ammo_1" }, cost = self.costs.default },
    name_id = "menu_scrounger_name", desc_id = "menu_scrounger_desc", icon_xy = { 3, 0 }
  }
  self.skills.max_ammo_increase = {
    { upgrades = { "extra_ammo_multiplier1" }, cost = self.costs.default },
    name_id = "temp_skill_name", desc_id = "menu_max_ammo_inc_desc", icon_xy = { 3, 0 }
  }

  self.trees[4].tiers = {
    { "underdog", "shotgun_ads_speed", "overdog", },
    { "shotgun_stability", "shotgun_accuracy", "shotgun_reload" },
    { "shotgun_impact", "shotgun_range", "shotgun_rof",  },
    { "shotgun_hipfire", "overkill" }
  }
  self.trees[5].tiers = {
    { "transporter", "stun_resistance" },
    { "thick_skin", "enforcer_recovery", "armor_bag_reduction" },
    { "crew_recovery", "nerves_of_steel", "shock_awe" },
    { "bulletproof", "juggernaut" }
    
  }
  self.trees[6].tiers = {
    { "scavenger", "extra_ammo_box", "portable_saw" },
    { "ammobag_capacity", "max_ammo_increase", "carbon_blade" },
    { "ammobag_quantity", "ammo_reservoir" },
    { "fully_loaded", "scrounger" }
  }

  -- TECHNICIAN --
  
  self.trees[7].tiers = {
    { "defense_up" },
    { "sentry_targeting_package", "eco_sentry" },
    { "engineering", "jack_of_all_trades" },
    { "tower_defense" }
  }
  self.trees[8].tiers = {
    { "hardware_expert" },
    { "combat_engineering", "drill_expert" },
    { "more_fire_power", "kick_starter" },
    { "fire_trap" }
    
  }
  self.trees[9].tiers = {
    { "steady_grip" },
    { "heavy_impact", "fire_control" },
    { "shock_and_awe", "fast_fire" },
    { "body_expertise" }
  }

  -- GHOST --
  self.skills.second_wind = {
    { upgrades = { "temporary_damage_speed_multiplier" }, cost = self.costs.default },
    { upgrades = { "player_team_damage_speed_multiplier_send" }, cost = self.costs.default },
    name_id = "menu_scavenger_beta", desc_id = "menu_scavenger_beta_desc", icon_xy = { 10, 9 }
  }

  self.trees[10].tiers = {
    { "jail_workout" },
    { "cleaner", "chameleon" },
    { "second_chances", "ecm_booster" },
    { "ecm_2x" }
  }
  self.trees[11].tiers = {
    { "sprinter" },
    { "awareness", "thick_skin" },
    { "dire_need", "insulation" },
    { "jail_diet" }
    
  }
  self.trees[12].tiers = {
    { "second_wind" },
    { "optic_illusions", "silence_expert" },
    { "backstab", "hitman" },
    { "unseen_strike" }
  }

  -- FUGITIVE --
  
  self.trees[13].tiers = {
    { "equilibrium" },
    { "dance_instructor", "akimbo" },
    { "gun_fighter", "expert_handling" },
    { "trigger_happy" }
  }
  self.trees[14].tiers = {
    { "nine_lives" },
    { "running_from_death", "up_you_go" },
    { "perseverance", "feign_death" },
    { "messiah" }
    
  }
  self.trees[15].tiers = {
    { "martial_arts" },
    { "bloodthirst", "steroids" },
    { "drop_soap", "wolverine" },
    { "frenzy" }
  }

  -- Perk skill tree
  table.insert(self.skill_pages_order, "perks")
  self.skilltree.perks = { name_id = "st_menu_perks", desc_id = "st_menu_perks_desc" }

  -- Global perks
  self.skills.perk_dmg = {
    { upgrades = { "weapon_passive_damage_multiplier" }, cost = self.costs.default },
    { upgrades = { "weapon_passive_headshot_damage_multiplier" }, cost = self.costs.default },
    name_id = "menu_deckall_2", desc_id = "menu_perk_dmg", icon_xy = { 0, 0 }
  }

  -- Crew Chief

  -- Muscle
  self.skills.muscle_health = {
    { upgrades = { "player_passive_health_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_2" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_3" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_4" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_5" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_regen" }, cost = self.costs.default },
    name_id = "menu_deck2_1", desc_id = "menu_deck2_1_skill", icon_xy = { 0, 0 }
  }
  self.skills.muscle_panic = {
    { upgrades = { "player_panic_suppression", "player_uncover_multiplier" }, cost = self.costs.default },
    name_id = "menu_deck2_7", desc_id = "menu_deck2_7_skill", icon_xy = { 0, 0 }
  }

  -- Armorer
  self.skills.armorer_perk = {
    { upgrades = { "player_tier_armor_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "player_tier_armor_multiplier_2" }, cost = self.costs.default },
    { upgrades = { "player_tier_armor_multiplier_3" }, cost = self.costs.default },
    { upgrades = { "player_tier_armor_multiplier_4" }, cost = self.costs.default },
    { upgrades = { "player_tier_armor_multiplier_6", "mrwi_armor_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "player_armor_grinding_1" }, cost = self.costs.default },
    name_id = "menu_armorer_skill", desc_id = "menu_armorer_skill_desc", icon_xy = { 0, 0 }
  }

  -- Rogue
  self.skills.rogue_dodge = {
    { upgrades = { "player_passive_dodge_chance_1" }, cost = self.costs.default },
    { upgrades = { "player_passive_dodge_chance_2" }, cost = self.costs.default },
    { upgrades = { "player_passive_dodge_chance_3" }, cost = self.costs.default },
    { upgrades = { "mrwi_dodge_chance_1", "mrwi_dodge_chance_2", "mrwi_dodge_chance_3" }, cost = self.costs.default },
    { upgrades = { "player_tier_dodge_chance_1",}, cost = self.costs.default },
    { upgrades = { "player_dodge_ricochet_bullets" }, cost = self.costs.default },
    name_id = "menu_deck4_5", desc_id = "menu_deck4_5_skill", icon_xy = { 0, 0 }
  }
  self.skills.rogue_switch = {
    { upgrades = { "weapon_passive_swap_speed_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "weapon_passive_swap_speed_multiplier_2" }, cost = self.costs.default },
    { upgrades = { "weapon_swap_speed_multiplier" }, cost = self.costs.default },
    name_id = "menu_deck4_9", desc_id = "menu_rogue_switch", icon_xy = { 0, 0 }
  }

  -- Crook
  self.skills.crook_skill = {
    { upgrades = { "player_level_2_dodge_addend_1", "player_level_2_armor_multiplier_1",
                   "player_level_3_dodge_addend_1", "player_level_3_armor_multiplier_1",
                   "player_level_4_dodge_addend_1", "player_level_4_armor_multiplier_1" },
      cost = self.costs.default
    },
    { upgrades = { "player_level_2_dodge_addend_2", "player_level_2_armor_multiplier_2",
                   "player_level_3_dodge_addend_2", "player_level_3_armor_multiplier_2",
                   "player_level_4_dodge_addend_2", "player_level_4_armor_multiplier_2" },
      cost = self.costs.default
    },
    { upgrades = { "player_level_2_dodge_addend_3", "player_level_2_armor_multiplier_3",
                   "player_level_3_dodge_addend_3", "player_level_3_armor_multiplier_3",
                   "player_level_4_dodge_addend_3", "player_level_4_armor_multiplier_3" },
      cost = self.costs.default
    },
    name_id = "menu_crook_skill", desc_id = "menu_crook_skill_desc", icon_xy = { 0, 0 }
  }

  -- Hitman
  self.skills.hitman_perk = {
    { upgrades = { "player_perk_armor_regen_timer_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "player_perk_armor_regen_timer_multiplier_2" }, cost = self.costs.default },
    { upgrades = { "player_perk_armor_regen_timer_multiplier_3" }, cost = self.costs.default },
    { upgrades = { "player_perk_armor_regen_timer_multiplier_4" }, cost = self.costs.default },
    { upgrades = { "player_perk_armor_regen_timer_multiplier_5" }, cost = self.costs.default },
    { upgrades = { "player_passive_always_regen_armor_1" }, cost = self.costs.default },
    name_id = "menu_deck5_9", desc_id = "menu_hitman_skill_desc", icon_xy = { 0, 0 }
  }

  -- Burglar
  self.skills.burglar_stealth = {
    { upgrades = { "player_corpse_dispose_speed_multiplier" }, cost = self.costs.default },
    { upgrades = { "player_alarm_pager_speed_multiplier" }, cost = self.costs.default },
    { upgrades = { "player_pick_lock_speed_multiplier" }, cost = self.costs.default },
    name_id = "menu_deck7_3", desc_id = "menu_burglar_stealth", icon_xy = { 0, 0 }
  }

  -- Ex-Pres
  self.skills.ex_pres = {
    { upgrades = { "player_armor_health_store_amount_1" }, cost = self.costs.default },
    { upgrades = { "player_armor_health_store_amount_2" }, cost = self.costs.default },
    { upgrades = { "player_armor_health_store_amount_3" }, cost = self.costs.default },
    name_id = "menu_deck13_1", desc_id = "menu_break_skill", icon_xy = { 0, 0 }
  }

  -- Yakuza
  self.skills.yakuza_speed = {
    { upgrades = { "player_armor_regen_damage_health_ratio_multiplier_3", "player_armor_regen_damage_health_ratio_threshold_multiplier" },
      cost = self.costs.default
    },
    { upgrades = { "player_movement_speed_damage_health_ratio_multiplier", "player_movement_speed_damage_health_ratio_threshold_multiplier" },
      cost = self.costs.default
    },
    name_id = "menu_yakuza_speed", desc_id = "menu_yakuza_speed_desc", icon_xy = { 0, 0 }
  }

  -- Maniac
  self.skills.maniac_base = {
    { upgrades = { "player_cocaine_stacking_1", "player_sync_cocaine_stacks" }, cost = self.costs.default },
    { upgrades = { "player_sync_cocaine_upgrade_level_1" }, cost = self.costs.default },
    { upgrades = { "player_cocaine_stack_absorption_multiplier_1" }, cost = self.costs.default },
    name_id = "menu_deck14_9", desc_id = "menu_deck14_1_skill", icon_xy = { 0, 0 }
  }

  -- Kingpin
  self.skills.kingpin_prio = {
    { upgrades = { "player_chico_preferred_target" }, cost = self.costs.default },
    name_id = "menu_deck17_5", desc_id = "menu_kingpin_priority", icon_xy = { 0, 0 }
  }
  self.skills.kingpin_healing = {
    { upgrades = { "player_chico_injector_low_health_multiplier" }, cost = self.costs.default },
    name_id = "menu_deck17_7", desc_id = "menu_kingpin_healing", icon_xy = { 0, 0 }
  }
  self.skills.kingpin_cooldown = {
    { upgrades = { "player_chico_injector_health_to_speed" }, cost = self.costs.default },
    name_id = "menu_deck17_9", desc_id = "menu_kingpin_cooldown", icon_xy = { 0, 0 }
  }

  -- Stoic
  self.skills.stoic_base = {
    { upgrades = { "damage_control", "player_damage_control_passive", "player_damage_control_cooldown_drain_1" }, cost = self.costs.default },
    { upgrades = { "player_damage_control_cooldown_drain_2" }, cost = self.costs.default },
    name_id = "menu_deck19_1", desc_id = "menu_stoic_skill", icon_xy = { 0, 0 }
  }
  self.skills.stoic_negation = {
    { upgrades = { "player_damage_control_auto_shrug" }, cost = self.costs.default },
    name_id = "menu_deck19_5", desc_id = "menu_stoic_negation", icon_xy = { 0, 0 }
  }
  self.skills.stoic_regen = {
    { upgrades = { "player_armor_to_health_conversion" }, cost = self.costs.default },
    { upgrades = { "player_damage_control_healing" }, cost = self.costs.default },
    name_id = "menu_deck19_9", desc_id = "menu_stoic_regen", icon_xy = { 0, 0 }
  }

  -- Sicario
  self.skills.sicario_stack = {
    { upgrades = { "player_dodge_shot_gain" }, cost = self.costs.default },
    name_id = "menu_deck18_3", desc_id = "menu_sicario_stack_desc", icon_xy = { 0, 0 }
  }

  -- Infiltrator
  self.skills.infil_melee = {
    { upgrades = { "melee_stacking_hit_damage_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "melee_stacking_hit_expire_t" }, cost = self.costs.default },
    name_id = "menu_infil_melee", desc_id = "menu_infil_melee_desc", icon_xy = { 0, 0 }
  }
  self.skills.infil_close = {
    { upgrades = { "player_damage_dampener_close_contact_1" }, cost = self.costs.default },
    { upgrades = { "player_damage_dampener_close_contact_2" }, cost = self.costs.default },
    { upgrades = { "player_damage_dampener_close_contact_3" }, cost = self.costs.default },
    name_id = "menu_infil_close", desc_id = "menu_infil_close_desc", icon_xy = { 0, 0 }
  }
  self.skills.infil_heal = {
    { upgrades = { "player_melee_life_leech" }, cost = self.costs.default },
    { upgrades = { "player_melee_kill_life_leech" }, cost = self.costs.default },
    name_id = "menu_deck8_9", desc_id = "menu_infil_heal_desc", icon_xy = { 0, 0 }
  }

  -- Gambler
  self.skills.gambler_heal = {
    { upgrades = { "temporary_loose_ammo_restore_health_1", "player_loose_ammo_restore_health_give_team" }, cost = self.costs.default },
    { upgrades = { "temporary_loose_ammo_restore_health_2" }, cost = self.costs.default },
    { upgrades = { "temporary_loose_ammo_restore_health_3" }, cost = self.costs.default },
    name_id = "menu_deck10_1", desc_id = "menu_gambler_heal", icon_xy = { 0, 0 }
  }
  self.skills.gambler_mag_throw = {
    { upgrades = { "temporary_loose_ammo_give_team" }, cost = self.costs.default },
    name_id = "menu_mag_throw", desc_id = "menu_mag_throw_desc", icon_xy = { 0, 0 }
  }

  -- Biker
  self.skills.biker_perk = {
    { upgrades = { "player_wild_health_amount_1" }, cost = self.costs.default },
    { upgrades = { "player_less_health_wild_cooldown_1" }, cost = self.costs.default },
    { upgrades = { "player_less_armor_wild_health_1" }, cost = self.costs.default },
    { upgrades = { "player_less_armor_wild_cooldown_1" }, cost = self.costs.default },
    name_id = "menu_deck16_1", desc_id = "menu_biker_perk", icon_xy = { 0, 0 }
  }

  -- Anarchist
  self.skills.anarch_rise = {
    { upgrades = { "player_armor_increase_1", "player_health_decrease_1" }, cost = self.costs.default },
    { upgrades = { "player_armor_increase_2", "player_health_decrease_2" }, cost = self.costs.default },
    { upgrades = { "player_armor_increase_3", "player_health_decrease_3" }, cost = self.costs.default },
    name_id = "menu_deck15_7", desc_id = "menu_anarch_rise", icon_xy = { 0, 0 }
  }

  -- Tag Team
  self.skills.h3h3_cooldown = {
    { upgrades = { "player_tag_team_cooldown_drain_2" }, cost = self.costs.default },
    name_id = "menu_deck20_9", desc_id = "menu_h3h3_cooldown", icon_xy = { 0, 0 }
  }
  self.skills.h3h3_absorb = {
    { upgrades = { "player_tag_team_damage_absorption" }, cost = self.costs.default },
    name_id = "menu_deck20_5", desc_id = "menu_h3h3_absorb", icon_xy = { 0, 0 }
  }

  -- Leech
  self.skills.leech_swan = {
    { upgrades = { "player_copr_out_of_health_move_slow_1" }, cost = self.costs.default },
    { upgrades = { "player_activate_ability_downed" }, cost = self.costs.default },
    name_id = "menu_deck22_1", desc_id = "menu_leech_swan", icon_xy = { 0, 0 }
  }
  self.skills.leech_duration = {
    { upgrades = { "player_copr_speed_up_on_kill_1" }, cost = self.costs.default },
    { upgrades = { "temporary_copr_ability_2" }, cost = self.costs.default },
    name_id = "menu_deck22_5", desc_id = "menu_leech_duration", icon_xy = { 0, 0 }
  }
  self.skills.leech_healing = {
    { upgrades = { "player_copr_teammate_heal_2" }, cost = self.costs.default },
    { upgrades = { "player_copr_activate_bonus_health_ratio_1" }, cost = self.costs.default },
    name_id = "menu_deck22_3", desc_id = "menu_leech_healing", icon_xy = { 0, 0 }
  }
  self.skills.leech_segments = {
    { upgrades = { "player_copr_static_damage_ratio_2", "player_copr_kill_life_leech_2" }, cost = self.costs.default },
    name_id = "menu_deck22_9", desc_id = "menu_leech_segments", icon_xy = { 0, 0 }
  }

  -- Copycat
  self.skills.copycat_ricochet = {
    { upgrades = { "player_dodge_ricochet_bullets" }, cost = self.costs.default },
    name_id = "menu_ricochet", desc_id = "menu_ricochet_skill", icon_xy = { 0, 0 }
  }
  self.skills.copycat_reload = {
    { upgrades = { "player_primary_reload_secondary_1", "player_secondary_reload_primary_1" }, cost = self.costs.default },
    { upgrades = { "weapon_mrwi_swap_speed_multiplier_1" }, cost = self.costs.default },
    name_id = "menu_tac_reload", desc_id = "menu_tac_reload_desc", icon_xy = { 0, 0 }
  }

  -- Dodge
  local PerkTree1 = {
    skill = "perks",
    name_id = "st_menu_perks_tree1",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "rogue_dodge", "perk_dmg", "rogue_switch" },
      { "crook_skill", "burglar_stealth", "copycat_reload" },
      { "ex_pres", "anarch_rise" },
      { "yakuza_speed" }
    }
  } -- Stats
  local PerkTree2 = {
    skill = "perks",
    name_id = "st_menu_perks_tree2",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "muscle_health", "armorer_perk", "hitman_perk" },
      { "infil_close", "gambler_mag_throw", "infil_melee" },
      { "muscle_panic", "gambler_heal", "infil_heal" },
      { "maniac_base" }
    }
  } -- Consumables
  local PerkTree3 = {
    skill = "perks",
    name_id = "st_menu_perks_tree3",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "kingpin_cooldown", "h3h3_cooldown", "leech_duration" },
      { "stoic_base", "leech_healing" },
      { "stoic_negation", "kingpin_prio", "leech_segments" },
      { "stoic_regen", "kingpin_healing", "h3h3_absorb", "leech_swan" }
    }
  }

  table.insert(self.trees, PerkTree1)
  table.insert(self.trees, PerkTree2)
  table.insert(self.trees, PerkTree3)

  -- Bonus skill page
  table.insert(self.skill_pages_order, "bonus")
  self.skilltree.bonus = { name_id = "st_menu_bonus", desc_id = "st_menu_bonus_desc" }

  -- Old skills
  self.skills.oldholm_syndrome = {
    { upgrades = { "player_civilian_reviver" }, cost = self.costs.default },
    { upgrades = { "player_civilian_gives_ammo" }, cost = self.costs.default },
    name_id = "menu_oldholm_syndrome", desc_id = "menu_oldholm_syndrome_desc", icon_xy = { 3, 8 }
  }
  self.skills.tough_guy = {
    { upgrades = { "player_damage_shake_multiplier" }, cost = self.costs.default },
    name_id = "menu_tough_guy", desc_id = "menu_tough_guy_desc", icon_xy = { 1, 1 }
  }
  self.skills.hip_accuracy = {
    { upgrades = { "saw_hip_fire_spread_multiplier", "pistol_hip_fire_spread_multiplier",
                   "assault_rifle_hip_fire_spread_multiplier", "lmg_hip_fire_spread_multiplier",
                   "snp_hip_fire_spread_multiplier", "smg_hip_fire_spread_multiplier",
                   "shotgun_hip_fire_spread_multiplier" }, cost = self.costs.default },
    name_id = "menu_hip_accuracy", desc_id = "menu_hip_accuracy_desc", icon_xy = { 7, 10 }
  }
  self.skills.mag_plus = {
    { upgrades = { "weapon_clip_ammo_increase_1" }, cost = self.costs.default },
    { upgrades = { "weapon_clip_ammo_increase_2" }, cost = self.costs.default },
    name_id = "menu_mag_plus", desc_id = "menu_mag_plus_desc", icon_xy = { 2, 0 }
  }
  self.skills.smg_rof = {
    { upgrades = { "smg_fire_rate_multiplier" }, cost = self.costs.default },
    name_id = "menu_smg_rof", desc_id = "menu_smg_rof_desc", icon_xy = { 3, 3 }
  }
  self.skills.custody_timer = {
    { upgrades = { "player_respawn_time_multiplier" }, cost = self.costs.default },
    name_id = "menu_custody_timer", desc_id = "menu_custody_timer_desc", icon_xy = { 4, 8 }
  }
  self.skills.crouch_dodge = {
    { upgrades = { "player_crouch_dodge_chance_1" }, cost = self.costs.default },
    { upgrades = { "player_crouch_dodge_chance_2" }, cost = self.costs.default },
    name_id = "menu_crouch_dodge", desc_id = "menu_crouch_dodge_desc", icon_xy = { 0, 11 }
  }
  self.skills.dominator = {
    { upgrades = { "player_intimidate_enemies" }, cost = self.costs.default },
    name_id = "menu_dominator", desc_id = "menu_dominator_desc", icon_xy = { 2, 8 }
  }
  self.skills.threat_inc = {
    { upgrades = { "player_passive_suppression_bonus_1" }, cost = self.costs.default },
    { upgrades = { "player_passive_suppression_bonus_2" }, cost = self.costs.default },
    { upgrades = { "player_suppression_bonus" }, cost = self.costs.default },
    name_id = "menu_oppressor_name", desc_id = "menu_oppressor_desc", icon_xy = { 7, 0 }
  }
  self.skills.daredevil = {
    { upgrades = { "player_climb_speed_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "player_climb_speed_multiplier_2" }, cost = self.costs.default },
    name_id = "menu_daredevil", desc_id = "menu_daredevil_desc", icon_xy = { 5, 10 }
  }
  self.skills.downed_ads = {
    { upgrades = { "player_primary_weapon_when_downed" }, cost = self.costs.default },
    { upgrades = { "player_steelsight_when_downed" }, cost = self.costs.default },
    name_id = "menu_downed_ads", desc_id = "menu_downed_ads_desc", icon_xy = { 1, 2 }
  }
  self.skills.drop_cloth = {
    { upgrades = { "player_silent_kill" }, cost = self.costs.default },
    name_id = "menu_drop_cloth", desc_id = "menu_drop_cloth_desc", icon_xy = { 0, 0 }
  }
  self.skills.shinobi = {
    { upgrades = { "player_walk_speed_multiplier", "player_crouch_speed_multiplier" }, cost = self.costs.default },
    name_id = "menu_shinobi", desc_id = "menu_shinobi_desc", icon_xy = { 0, 3 }
  }

  -- Removed skills
  local BonusTree1 = {
    skill = "bonus",
    name_id = "st_menu_bonus_tree1",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "tough_guy", "daredevil", "threat_inc", "downed_ads" },
      { "hip_accuracy", "crouch_dodge", "shinobi" },
      { "drop_cloth", "custody_timer", "oldholm_syndrome" },
      { "mag_plus", "dominator" }
    }
  } -- Weapon stat boosts
  self.skills.tinkerer = {
    { upgrades = { "weapon_modded_damage_multiplier", "weapon_modded_spread_multiplier", "weapon_modded_recoil_multiplier" }, cost = self.costs.default },
    { upgrades = { "weapon_fire_rate_multiplier" }, cost = self.costs.default },
    name_id = "menu_tinkerer", desc_id = "menu_tinkerer_desc", icon_xy = { 1, 7 }
  }
  self.skills.ar_stability = {
    { upgrades = { "assault_rifle_recoil_index_addend" }, cost = self.costs.default },
    name_id = "menu_ar_stability", desc_id = "menu_ar_stability_desc", icon_xy = { 0, 0 }
  }
  self.skills.lmg_stability = {
    { upgrades = { "lmg_recoil_index_addend" }, cost = self.costs.default },
    name_id = "menu_lmg_stability", desc_id = "menu_lmg_stability_desc", icon_xy = { 0, 0 }
  }
  self.skills.single_shot_accuracy = {
    { upgrades = { "weapon_single_spread_multiplier" }, cost = self.costs.default },
    name_id = "menu_single_shot_acc", desc_id = "menu_single_shot_acc_desc", icon_xy = { 0, 0 }
  }
  self.skills.reload_speed = {
    { upgrades = { "weapon_passive_reload_speed_multiplier" }, cost = self.costs.default },
    name_id = "menu_reload_speed", desc_id = "menu_reload_speed_desc", icon_xy = { 0, 0 }
  }
  self.skills.lmg_reload_speed = {
    { upgrades = { "lmg_reload_speed_multiplier" }, cost = self.costs.default },
    name_id = "menu_lmg_reload_speed", desc_id = "menu_lmg_reload_speed_desc", icon_xy = { 0, 0 }
  }
  self.skills.silencer_statboost = {
    { upgrades = { "weapon_silencer_recoil_multiplier" }, cost = self.costs.default },
    { upgrades = { "weapon_silencer_spread_multiplier" }, cost = self.costs.default },
    name_id = "menu_silencer_statboost", desc_id = "menu_silencer_statboost_desc", icon_xy = { 4, 4 }
  }

  local BonusTree2 = {
    skill = "bonus",
    name_id = "st_menu_bonus_tree2",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "lmg_stability", "single_shot_accuracy" },
      { "ar_stability", "smg_rof" },
      { "lmg_reload_speed", "reload_speed" },
      { "tinkerer", "silencer_statboost" }
    }
  } -- Misc. unused skills
  local BonusTree3 = {
    skill = "bonus",
    name_id = "st_menu_bonus_tree3",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "nine_lives" },
      { "running_from_death", "up_you_go" },
      { "perseverance", "feign_death" },
      { "messiah" }
    }
  }

  table.insert(self.trees, BonusTree1)
  table.insert(self.trees, BonusTree2)
  --table.insert(self.trees, BonusTree3)
end)