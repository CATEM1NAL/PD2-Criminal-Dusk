local function digest(value)
  return Application:digest_value(value, true)
end

Hooks:PostHook(SkillTreeTweakData, "init", "CrimDusk_SkillTreeTweakInit", function(self)
  self.tier_unlocks = { digest(0), digest(0), digest(0), digest(0) }
  self.tier_cost = { { 1, 1, 1, 1, 1, 1 }, { 2, 2, 2, 2, 2 }, { 3, 3, 3, 3, 3 }, { 4, 4, 4, 4, 4 } }

  -- Default upgrades
  self.default_upgrades = {
    "player_fall_health_damage_multiplier",
    "player_intimidate_enemies",
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
  table.insert(self.default_upgrades, "player_copr_activate_bonus_health_ratio_1")
  table.insert(self.default_upgrades, "player_copr_teammate_heal_1")

  -- Disable perk decks
  for i = 1, #self.specializations do
    for _, data in ipairs(self.specializations[i]) do
      if data.upgrades and next(data.upgrades) then data.upgrades = {} end
    end
  end

  -- Perk skill tree
  table.insert(self.skill_pages_order, "perks")
  self.skilltree.perks = { name_id = "st_menu_perks", desc_id = "st_menu_perks_desc" }

  -- Global perks
  self.skills.perk_dmg = {
    { upgrades = { "player_passive_health_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "weapon_passive_headshot_damage_multiplier" }, cost = self.costs.default },
    name_id = "menu_deck2_1", desc_id = "menu_deck2_1_skill", icon_xy = { 0, 0 }
  }

  -- Crew Chief

  -- Muscle
  self.skills.muscle_health = {
    { upgrades = { "player_passive_health_multiplier_1" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_2" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_3" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_4" }, cost = self.costs.default },
    { upgrades = { "player_passive_health_multiplier_5" }, cost = self.costs.default },
    { upgrades = { "player_armor_to_health_conversion" }, cost = self.costs.default },
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
      { "rogue_dodge", "rogue_switch" },
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
  local BonusTree1 = {
    skill = "bonus",
    name_id = "st_menu_bonus_tree1",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "smg_master" },
      { "running_from_death" },
      { "perseverance", "feign_death" },
      { "messiah" }
    }
  } -- Weapon stat boosts
  local BonusTree2 = {
    skill = "bonus",
    name_id = "st_menu_bonus_tree2",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "nine_lives" },
      { "running_from_death", "up_you_go" },
      { "perseverance", "feign_death" },
      { "messiah" }
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
  table.insert(self.trees, BonusTree3)
end)