Global.CrimDawn.tables.upgrades = {

  permaperks = {

    { -- [1] Blending In: +1 Concealment
      "player_passive_suspicion_bonus"
    },
    { -- [2] Second Skin: 15% reduced armor speed penalty
      "player_passive_armor_movement_penalty_multiplier"
    },
    { -- [3] Whole Bullet: 5% damage bonus
      "weapon_passive_damage_multiplier"
    },
    { -- [4] Walk-in Closet Lv1: Ammo pickup increased by 35%
      "player_pick_up_ammo_multiplier"
    },
    { -- [5] Helmet Popping: 25% headshot damage bonus
      "weapon_passive_headshot_damage_multiplier"
    },
    { -- [6] Triage: 20% faster doctor bag interactions
      "passive_doctor_bag_interaction_speed_multiplier"
    },
    { -- [7] Walk-in Closet Lv2: Ammo pickup increased by 75%
      "player_pick_up_ammo_multiplier_2"
    },
  },

  permaskills = {

    { -- [1] Cat Burglar: Falls inflict armor damage
      "player_fall_health_damage_multiplier"
    },
    { -- [2] Cleaner: Can bag bodies
      "player_corpse_dispose",
      "player_corpse_dispose_amount_1"
    },
    { -- [3] Dominator: Can intimidate non-special enemies
      "player_intimidate_enemies"
    },
    { -- [4] Drop Cloth: Enemy death alert range reduced by 95%
      "player_silent_kill"
    },
    { -- [5] Toolkit: Repair drills and saws 25% faster
      "player_drill_fix_interaction_speed_multiplier"
    },
    { -- [6] Die Hard: 50% damage reduction while interacting
      "player_interacting_damage_multiplier"
    },
    { -- [7] Jack of all Trades: 100% faster deployable interactions, two deployables
      "deploy_interact_faster_1",
      "second_deployable_1"
    },
  },

  skills = {

    -- Default Upgrades
    harmless_melee = {
      dlc_owned = true, upg_type = "common",
      "player_civ_harmless_melee"
    },
    downed_primary = {
      dlc_owned = true, upg_type = "common",
      "player_primary_weapon_when_downed",
      "player_steelsight_when_downed"
    },

    -- Mastermind Skills
    revive_damage_reduction = { -- Combat Medic
      dlc_owned = true, upg_type = "uncommon",
      "player_revive_damage_reduction_1",
      "temporary_revive_damage_reduction_1"
    },
    inspire_shout = {
      dlc_owned = true, upg_type = "rare",
      "cooldown_long_dis_revive",
      "player_morale_boost"
    },
    hostage_absorption = {
      dlc_owned = true, upg_type = "uncommon",
      count_req = "permaskills:3",
      "team_damage_hostage_absorption"
    },
    intimidate_sounds = {
      dlc_owned = true, upg_type = "common",
      "player_civ_calming_alerts",
      "player_intimidate_aura"
    },
    stockholm_syndrome = {
      dlc_owned = true, upg_type = "uncommon",
      "player_super_syndrome_1"
    },
    hostage_taker = {
      dlc_owned = true, upg_type = "rare",
      "player_hostage_health_regen_addend_2"
    },
    headshot_faster_reload = {
      dlc_owned = true, upg_type = "common",
      "temporary_single_shot_fast_reload_1"
    },
    headshot_ammo_return = {
      dlc_owned = true, upg_type = "common",
      "head_shot_ammo_return_2"
    },
    graze = {
      dlc_owned = true, upg_type = "uncommon",
      "snp_graze_damage_2"
    },
    joker_1 = {
      dlc_owned = true, upg_type = "rare",
      count_req = "permaskills:3",
      "player_convert_enemies",
      "player_convert_enemies_max_minions_1",
      "player_convert_enemies_damage_multiplier_1",
      "player_passive_convert_enemies_health_multiplier_1"
    },
    joker_2 = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "skills-joker_1",
      "player_convert_enemies_max_minions_2",
      "player_convert_enemies_damage_multiplier_2",
      "player_passive_convert_enemies_health_multiplier_2"
    },
    joker_stats = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "skills-joker_1",
      "player_minion_master_speed_multiplier",
      "player_minion_master_health_multiplier"
    },

    -- Enforcer Skills
    underdog = {
      dlc_owned = true, upg_type = "common",
      "player_damage_multiplier_outnumbered",
      "player_damage_dampener_outnumbered"
    },
    shotgun_sprint_shoot = {
      dlc_owned = true, upg_type = "common",
      "shotgun_hip_run_and_shoot_1"
    },
    overkill = {
      dlc_owned = true, upg_type = "common",
      "player_overkill_all_weapons",
      "player_overkill_damage_multiplier"
    },
    bag_penalty_armour_reduction = {
      dlc_owned = true, upg_type = "common",
      "player_armor_carry_bonus_1"
    },
    shield_knock = {
      dlc_owned = true, upg_type = "common",
      "player_shield_knock"
    },
    bullseye = {
      dlc_owned = true, upg_type = "uncommon",
      "player_headshot_regen_armor_bonus_2"
    },
    saw_ap = {
      dlc_owned = true, upg_type = "rare",
      count_req = "saws:1",
      "saw_ignore_shields_1",
      "saw_armor_piercing_chance"
    },
    saw_panic = {
      dlc_owned = true, upg_type = "rare",
      count_req = "saws:1",
      "saw_panic_when_kill_1"
    },
    throwable_pickup = {
      dlc_owned = true, upg_type = "rare",
      "player_regain_throwable_from_ammo_1",
      "player_double_drop_1"
    },

    -- Technician Skills
    silent_drill = {
      dlc_owned = true, upg_type = "common",
      "player_drill_alert",
      "player_silent_drill"
    },
    drill_autorepair = {
      dlc_owned = true, upg_type = "common",
      "player_drill_autorepair_1",
      "player_drill_autorepair_2"
    },
    drill_melee_repair = {
      dlc_owned = true, upg_type = "uncommon",
      "player_drill_melee_hit_restart_chance_1"
    },
    weapon_knock_down = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_knock_down_2"
    },
    sprint_shoot = {
      dlc_owned = true, upg_type = "common",
      "player_run_and_shoot_1"
    },
    lock_n_load = {
      dlc_owned = true, upg_type = "common",
      "player_automatic_faster_reload_1"
    },
    ap_bullets_full = {
      dlc_owned = true, upg_type = "common",
      "player_ap_bullets_1"
    },
    body_expertise_1 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "body_expertise_2",
      "weapon_automatic_head_shot_add_1"
    },
    body_expertise_2 = {
      dlc_owned = true, upg_type = "rare",
      disable = "body_expertise_1",
      "weapon_automatic_head_shot_add_2"
    },

    -- Ghost Skills
    mark_unmasked = {
      dlc_owned = true, upg_type = "common",
      "player_sec_camera_highlight_mask_off",
      "player_special_enemy_highlight_mask_off"
    },
    unmasked_pickup = {
      dlc_owned = true, upg_type = "common",
      "player_mask_off_pickup"
    },
    sixth_sense = {
      dlc_owned = true, upg_type = "common",
      "player_standstill_omniscience"
    },
    additional_assets = {
      dlc_owned = true, upg_type = "common",
      "player_additional_assets",
      "player_buy_bodybags_asset",
      "player_buy_spotter_asset"
    },
    cam_loop = {
      dlc_owned = true, upg_type = "common",
      "player_tape_loop_duration_1",
      "player_tape_loop_duration_2"
    },
    pick_safes = {
      dlc_owned = true, upg_type = "common",
      "player_pick_lock_hard"
    },
    strafe_sprint = {
      dlc_owned = true, upg_type = "common",
      "player_can_strafe_run"
    },
    free_sprint = {
      dlc_owned = true, upg_type = "rare",
      "player_can_free_run"
    },
    sprint_reload = {
      dlc_owned = true, upg_type = "uncommon",
      "player_run_and_reload"
    },
    armor_broken_stagger = {
      dlc_owned = true, upg_type = "rare",
      "player_armor_depleted_stagger_shot_2"
    },
    shockproof_1 = {
      dlc_owned = true, upg_type = "uncommon",
      "player_taser_malfunction",
      "player_resist_firing_tased"
    },
    shockproof_2 = {
      dlc_owned = true, upg_type = "rare",
      "player_taser_self_shock",
      "player_escape_taser_1" 
    },
    sneaky_bastard = {
      dlc_owned = true, upg_type = "uncommon",
      "player_detection_risk_add_dodge_chance_2"
    },
    second_wind = {
      dlc_owned = true, upg_type = "common",
      "temporary_damage_speed_multiplier"
    },
    low_blow = {
      dlc_owned = true, upg_type = "uncommon",
      "player_detection_risk_add_crit_chance_2"
    },
    hvt_1 = {
      dlc_owned = true, upg_type = "common",
      "weapon_steelsight_highlight_specials",
      "player_marked_enemy_extra_damage"
    },
    hvt_2 = {
      dlc_owned = true, upg_type = "common",
      "player_marked_inc_dmg_distance_1"
    },
    unseen_strike = {
      dlc_owned = true, upg_type = "uncommon",
      "player_unseen_increased_crit_chance_2",
      "player_unseen_temp_increased_crit_chance_2",
    },

    -- Fugitive Skills
    pistol_acc_stack = {
      dlc_owned = true, upg_type = "common",
      "pistol_stacked_accuracy_bonus_1"
    },
    pistol_damage_on_hit = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_stacking_hit_damage_multiplier_1",
      "pistol_stacking_hit_damage_multiplier_2"
    },
    revive_swap_reload_speed = {
      dlc_owned = true, upg_type = "common",
      "player_temp_swap_weapon_faster_1",
      "player_temp_reload_weapon_faster_1"
    },
    revive_dr_movement = {
      dlc_owned = true, upg_type = "common",
      "player_temp_increased_movement_speed_1",
      "player_revived_damage_resist_1"
    },
    swan_song = {
      dlc_owned = true, upg_type = "uncommon",
      "temporary_berserker_damage_multiplier_2"
    },
    swan_song_inf = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "skills-swan_song",
      "player_berserker_no_ammo_cost"
    },
    messiah = {
      dlc_owned = true, upg_type = "uncommon",
      "player_messiah_revive_from_bleed_out_1",
      "player_recharge_messiah_1"
    },
    feign_death = {
      dlc_owned = true, upg_type = "rare",
      "player_cheat_death_chance_2"
    },
    melee_dmg_stack = {
      dlc_owned = true, upg_type = "uncommon",
      "player_melee_damage_stacking_1"
    },
    melee_reload_speed = {
      dlc_owned = true, upg_type = "common",
      "player_temp_melee_kill_increase_reload_speed_1"
    },
    drop_soap = {
      dlc_owned = true, upg_type = "uncommon",
      "player_counter_strike_melee",
      "player_counter_strike_spooc"
    },
    berserker_1 = {
      dlc_owned = true, upg_type = "common",
      "player_melee_damage_health_ratio_multiplier"
    },
    berserker_2 = {
      dlc_owned = true, upg_type = "uncommon",
      "player_damage_health_ratio_multiplier"
    },
    frenzy = {
      dlc_owned = true, upg_type = "rare",
      "player_max_health_reduction_1",
      "player_healing_reduction_2",
      "player_health_damage_reduction_2"
    },

    -- Removed
    old_stockholm = {
      dlc_owned = true, upg_type = "uncommon",
      "player_civilian_reviver",
      "player_civilian_gives_ammo"
    },

    -- Unused
    harmless_bullets = {
      dlc_owned = true, upg_type = "rare",
      "player_civ_harmless_bullets"
    },
    loud_and_proud = {
      dlc_owned = true, upg_type = "uncommon",
      "player_detection_risk_damage_multiplier"
    },
    pager_snatch = {
      dlc_owned = true, upg_type = "rare",
      "player_melee_kill_snatch_pager_chance"
    },
    hostage_boost = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "skills-hostage_taker,perks-chief_hostage_1,perks-chief_hostage_2,",
      "player_close_to_hostage_boost"
    },
    shotgun_no_consume = {
      dlc_owned = true, upg_type = "common",
      "shotgun_consume_no_ammo_chance_2"
    },
    no_bag_penalty = {
      dlc_owned = true, upg_type = "rare",
      disable = "bag_penalty_armour_reduction",
      "carry_movement_penalty_nullifier"
    },
  },

  perks = {

    -- Crew Chief
    chief_dr = {
      dlc_owned = true, upg_type = "uncommon",
      "team_damage_reduction_1",
      "player_passive_damage_reduction_1"
    },
    chief_shout_distance = {
      dlc_owned = true, upg_type = "common",
      "player_passive_intimidate_range_mul"
    },
    chief_health = {
      dlc_owned = true, upg_type = "uncommon",
      "team_passive_health_multiplier"
    },
    chief_armour = {
      dlc_owned = true, upg_type = "uncommon",
      "team_passive_armor_multiplier"
    },
    chief_hostage_1 = {
      dlc_owned = true, upg_type = "rare",
      count_req = "permaskills:3",
      "team_hostage_health_multiplier"
    },
    chief_hostage_2 = {
      dlc_owned = true, upg_type = "rare",
      count_req = "permaskills:3",
      "team_hostage_damage_dampener_multiplier"
    },

    -- Muscle
    muscle_health_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "muscle_health_2,muscle_health_3,muscle_health_4,muscle_health_5",
      "player_passive_health_multiplier_1"
    },
    muscle_health_2 = {
      dlc_owned = true, upg_type = "common",
      disable = "muscle_health_1,muscle_health_3,muscle_health_4,muscle_health_5",
      "player_passive_health_multiplier_2"
    },
    muscle_health_3 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "muscle_health_1,muscle_health_2,muscle_health_4,muscle_health_5",
      "player_passive_health_multiplier_3"
    },
    muscle_health_4 = {
      dlc_owned = true, upg_type = "rare",
      disable = "muscle_health_1,muscle_health_2,muscle_health_3,muscle_health_5",
      "player_passive_health_multiplier_4"
    },
    muscle_health_5 = {
      dlc_owned = true, upg_type = "rare",
      disable = "muscle_health_1,muscle_health_2,muscle_health_3,muscle_health_4",
      "player_passive_health_multiplier_5"
    },
    muscle_prio = {
      dlc_owned = true, upg_type = "rare",
      "player_uncover_multiplier"
    },
    muscle_panic = {
      dlc_owned = true, upg_type = "rare",
      "player_panic_suppression"
    },
    muscle_regen = {
      dlc_owned = true, upg_type = "rare",
      "player_passive_health_regen"
    },

    -- Armorer
    armorer_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "armorer_2,armorer_3,armorer_4,armorer_6",
      "player_tier_armor_multiplier_1"
    },
    armorer_2 = {
      dlc_owned = true, upg_type = "common",
      disable = "armorer_1,armorer_3,armorer_4,armorer_6",
      "player_tier_armor_multiplier_2"
    },
    armorer_3 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "armorer_1,armorer_2,armorer_4,armorer_6",
      "player_tier_armor_multiplier_3"
    },
    armorer_4 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "armorer_1,armorer_2,armorer_3,armorer_6",
      "player_tier_armor_multiplier_4"
    },
    armorer_6 = {
      dlc_owned = true, upg_type = "rare",
      disable = "armorer_1,armorer_2,armorer_3,armorer_4",
      "player_tier_armor_multiplier_6"
    },
    armorer_recovery = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "anarch_recovery,stoic_armor_convert",
      "player_armor_regen_timer_multiplier_passive"
    },
    armorer_immunity = {
      dlc_owned = true, upg_type = "rare",
      "temporary_armor_break_invulnerable_1"
    },
    armorer_team_recovery = {
      dlc_owned = true, upg_type = "uncommon",
      "team_passive_armor_regen_time_multiplier"
    },

    -- Rogue
    rogue_dodge_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "rogue_dodge_2,rogue_dodge_3",
      "player_passive_dodge_chance_1"
    },
    rogue_dodge_2 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "rogue_dodge_1,rogue_dodge_3",
      "player_passive_dodge_chance_2"
    },
    rogue_dodge_3 = {
      dlc_owned = true, upg_type = "rare",
      disable = "rogue_dodge_1,rogue_dodge_2",
      "player_passive_dodge_chance_3"
    },
    rogue_prio = {
      dlc_owned = true, upg_type = "uncommon",
      "player_camouflage_multiplier"
    },
    rogue_ap = {
      dlc_owned = true, upg_type = "common",
      "weapon_passive_armor_piercing_chance"
    },
    rogue_swap_speed = {
      dlc_owned = true, upg_type = "common",
      "weapon_passive_swap_speed_multiplier_1"
    },

    -- Hitman
    hitman_recovery_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "hitman_recovery_2,hitman_recovery_3,hitman_recovery_4,hitman_recovery_5,anarch_recovery,stoic_armor_convert",
      "player_perk_armor_regen_timer_multiplier_1"
    },
    hitman_recovery_2 = {
      dlc_owned = true, upg_type = "common",
      disable = "hitman_recovery_1,hitman_recovery_3,hitman_recovery_4,hitman_recovery_5,anarch_recovery,stoic_armor_convert",
      "player_perk_armor_regen_timer_multiplier_2"
    },
    hitman_recovery_3 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "hitman_recovery_1,hitman_recovery_2,hitman_recovery_4,hitman_recovery_5,anarch_recovery,stoic_armor_convert",
      "player_perk_armor_regen_timer_multiplier_3"
    },
    hitman_recovery_4 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "hitman_recovery_1,hitman_recovery_2,hitman_recovery_3,hitman_recovery_5,anarch_recovery,stoic_armor_convert",
      "player_perk_armor_regen_timer_multiplier_4"
    },
    hitman_recovery_5 = {
      dlc_owned = true, upg_type = "rare",
      disable = "hitman_recovery_1,hitman_recovery_2,hitman_recovery_3,hitman_recovery_4,anarch_recovery,stoic_armor_convert",
      "player_perk_armor_regen_timer_multiplier_5"
    },
    hitman_recovery_6 = {
      dlc_owned = true, upg_type = "rare",
      disable = "anarch_recovery,stoic_armor_convert",
      "player_passive_always_regen_armor_1"
    },

    -- Crook
    crook_lbv_dodge_1 = {
      dlc_owned = true, upg_type = "common", item_req = "body_armor1",
      disable = "crook_lbv_dodge_2,crook_lbv_dodge_3",
      "player_level_2_dodge_addend_1"
    },
    crook_lbv_dodge_2 = {
      dlc_owned = true, upg_type = "uncommon", item_req = "body_armor1",
      disable = "crook_lbv_dodge_1,crook_lbv_dodge_3",
      "player_level_2_dodge_addend_1",
      "player_level_2_dodge_addend_2"
    },
    crook_lbv_dodge_3 = {
      dlc_owned = true, 
      upg_type = "rare", item_req = "body_armor1",
      disable = "crook_lbv_dodge_1,crook_lbv_dodge_2",
      "player_level_2_dodge_addend_1",
      "player_level_2_dodge_addend_2",
      "player_level_2_dodge_addend_3"
    },
    crook_lbv_armour_1 = {
      dlc_owned = true, upg_type = "common", item_req = "body_armor1",
      disable = "crook_lbv_armour_2,crook_lbv_armour_3",
      "player_level_2_armor_multiplier_1"
    },
    crook_lbv_armour_2 = {
      dlc_owned = true, 
      upg_type = "uncommon", item_req = "body_armor1",
      disable = "crook_lbv_armour_1,crook_lbv_armour_3",
      "player_level_2_armor_multiplier_1",
      "player_level_2_armor_multiplier_2"
    },
    crook_lbv_armour_3 = {
      dlc_owned = true, upg_type = "rare", item_req = "body_armor1",
      disable = "crook_lbv_armour_1,crook_lbv_armour_2",
      "player_level_2_armor_multiplier_1",
      "player_level_2_armor_multiplier_2",
      "player_level_2_armor_multiplier_3"
    },
    crook_vest_dodge_1 = {
      dlc_owned = true, upg_type = "common", item_req = "body_armor2",
      disable = "crook_vest_dodge_2,crook_vest_dodge_3",
      "player_level_3_dodge_addend_1"
    },
    crook_vest_dodge_2 = {
      dlc_owned = true, 
      upg_type = "uncommon", item_req = "body_armor2",
      disable = "crook_vest_dodge_1,crook_vest_dodge_3",
      "player_level_3_dodge_addend_1",
      "player_level_3_dodge_addend_2"
    },
    crook_vest_dodge_3 = {
      dlc_owned = true, upg_type = "rare", item_req = "body_armor2",
      disable = "crook_vest_dodge_1,crook_vest_dodge_2",
      "player_level_3_dodge_addend_1",
      "player_level_3_dodge_addend_2",
      "player_level_3_dodge_addend_3"
    },
    crook_vest_armour_1 = {
      dlc_owned = true, upg_type = "common", item_req = "body_armor2",
      disable = "crook_vest_armour_2,crook_vest_armour_2",
      "player_level_3_armor_multiplier_1"
    },
    crook_vest_armour_2 = {
      dlc_owned = true, upg_type = "uncommon", item_req = "body_armor2",
      disable = "crook_vest_armour_1,crook_vest_armour_3",
      "player_level_3_armor_multiplier_1",
      "player_level_3_armor_multiplier_2"
    },
    crook_vest_armour_3 = {
      dlc_owned = true, upg_type = "rare", item_req = "body_armor2",
      disable = "crook_vest_armour_1,crook_vest_armour_2",
      "player_level_3_armor_multiplier_1",
      "player_level_3_armor_multiplier_2",
      "player_level_3_armor_multiplier_3"
    },
    crook_hbv_dodge_1 = {
      dlc_owned = true, upg_type = "common", item_req = "body_armor3",
      disable = "crook_hbv_dodge_2,crook_hbv_dodge_3",
      "player_level_4_dodge_addend_1"
    },
    crook_hbv_dodge_2 = {
      dlc_owned = true, upg_type = "uncommon", item_req = "body_armor3",
      disable = "crook_hbv_dodge_1,crook_hbv_dodge_3",
      "player_level_4_dodge_addend_1",
      "player_level_4_dodge_addend_2"
    },
    crook_hbv_dodge_3 = {
      dlc_owned = true, upg_type = "rare", item_req = "body_armor3",
      disable = "crook_hbv_dodge_1,crook_hbv_dodge_2",
      "player_level_4_dodge_addend_1",
      "player_level_4_dodge_addend_2",
      "player_level_4_dodge_addend_3"
    },
    crook_hbv_armour_1 = {
      dlc_owned = true, upg_type = "common", item_req = "body_armor3",
      disable = "crook_hbv_armour_2,crook_hbv_armour_3",
      "player_level_4_armor_multiplier_1"
    },
    crook_hbv_armour_2 = {
      dlc_owned = true, upg_type = "uncommon", item_req = "body_armor3",
      disable = "crook_hbv_armour_1,crook_hbv_armour_3",
      "player_level_4_armor_multiplier_1",
      "player_level_4_armor_multiplier_2"
    },
    crook_hbv_armour_3 = {
      dlc_owned = true, upg_type = "rare", item_req = "body_armor3",
      disable = "crook_hbv_armour_1,crook_hbv_armour_2",
      "player_level_4_armor_multiplier_1",
      "player_level_4_armor_multiplier_2",
      "player_level_4_armor_multiplier_3"
    },
    crook_recovery = {
      dlc_owned = true, upg_type = "common",
      disable = "anarch_recovery,stoic_armor_convert",
      "player_armor_regen_timer_multiplier_tier"
    },

    -- Burglar
    burglar_dodge_1 = {
      dlc_owned = false, upg_type = "common",
      disable = "burglar_dodge_2,burglar_dodge_3",
      "player_tier_dodge_chance_1"
    },
    burglar_dodge_2 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "burglar_dodge_1,burglar_dodge_3",
      "player_tier_dodge_chance_2"
    },
    burglar_dodge_3 = {
      dlc_owned = false, upg_type = "rare",
      disable = "burglar_dodge_1,burglar_dodge_2",
      "player_tier_dodge_chance_3"
    },
    burglar_prio_1 = {
      dlc_owned = false, upg_type = "common",
      disable = "burglar_prio_2,burglar_prio_3",
      "player_stand_still_crouch_camouflage_bonus_1"
    },
    burglar_prio_2 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "burglar_prio_1,burglar_prio_3",
      "player_stand_still_crouch_camouflage_bonus_2"
    },
    burglar_prio_3 = {
      dlc_owned = false, upg_type = "rare",
      disable = "burglar_prio_1,burglar_prio_2",
      "player_stand_still_crouch_camouflage_bonus_3"
    },
    burglar_bag_speed = {
      dlc_owned = false, upg_type = "common",
      "player_corpse_dispose_speed_multiplier"
    },
    burglar_lockpick_speed = {
      dlc_owned = false, upg_type = "common",
      "player_pick_lock_speed_multiplier"
    },
    burglar_pager_speed = {
      dlc_owned = false, upg_type = "common",
      "player_alarm_pager_speed_multiplier"
    },
    burglar_recovery = {
      dlc_owned = false, upg_type = "common",
      disable = "anarch_recovery,stoic_armor_convert",
      "player_armor_regen_timer_stand_still_multiplier"
    },

    -- Infiltrator
    infil_overdog = {
      dlc_owned = false, upg_type = "common",
      "player_damage_dampener_outnumbered_strong"
    },
    infil_single_dog_1 = {
      dlc_owned = false, upg_type = "common",
      disable = "infil_single_dog_2,infil_single_dog_3",
      "player_damage_dampener_close_contact_1"
    },
    infil_single_dog_2 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "infil_single_dog_1,infil_single_dog_3",
      "player_damage_dampener_close_contact_2"
    },
    infil_single_dog_3 = {
      dlc_owned = false, upg_type = "rare",
      disable = "infil_single_dog_1,infil_single_dog_2",
      "player_damage_dampener_close_contact_3"
    },
    infil_melee_boost = {
      dlc_owned = false, upg_type = "uncommon",
      "melee_stacking_hit_damage_multiplier_1"
    },
    infil_melee_timer = {
      dlc_owned = false, upg_type = "uncommon",
      upg_req = "perks-infil_melee_boost",
      "melee_stacking_hit_expire_t"
    },
    infil_melee_heal = {
      dlc_owned = false, upg_type = "rare",
      "player_melee_life_leech"
    },

    -- Sociopath
    socio_armor_1 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "stoic_armor_convert",
      "player_killshot_regen_armor_bonus"
    },
    socio_heal = {
      dlc_owned = false, upg_type = "uncommon",
      "player_melee_kill_life_leech"
    },
    socio_armor_2 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "stoic_armor_convert",
      "player_killshot_close_regen_armor_bonus"
    },
    socio_panic = {
      dlc_owned = false, upg_type = "rare",
      "player_killshot_close_panic_chance"
    },

    -- Gambler
    gambler_heal_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "gambler_heal_2,gambler_heal_3", 
      "temporary_loose_ammo_restore_health_1",
      "player_loose_ammo_restore_health_give_team"
    },
    gambler_heal_2 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "gambler_heal_1,gambler_heal_3", 
      "temporary_loose_ammo_restore_health_2",
      "player_loose_ammo_restore_health_give_team"
    },
    gambler_heal_3 = {
      dlc_owned = true, upg_type = "rare",
      disable = "gambler_heal_1,gambler_heal_2", 
      "temporary_loose_ammo_restore_health_3",
      "player_loose_ammo_restore_health_give_team"
    },
    gambler_mag_throw = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-gambler_heal_1,perks-gambler_heal_2,perks-gambler_heal_3",
      "temporary_loose_ammo_give_team"
    },

    -- Grinder
    grind_hot_1 = {
      dlc_owned = false, upg_type = "common",
      disable = "grind_hot_2,grind_hot_3,grind_hot_4",
      "player_damage_to_hot_1"
    },
    grind_hot_2 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "grind_hot_1,grind_hot_3,grind_hot_4",
      "player_damage_to_hot_2"
    },
    grind_hot_3 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "grind_hot_1,grind_hot_2,grind_hot_4",
      "player_damage_to_hot_3"
    },
    grind_hot_4 = {
      dlc_owned = false, upg_type = "rare",
      disable = "grind_hot_1,grind_hot_2,grind_hot_3",
      "player_damage_to_hot_4"
    },
    grind_ap = {
      dlc_owned = false, upg_type = "common",
      "player_armor_piercing_chance_2"
    },
    grind_hot_duration = {
      dlc_owned = false, upg_type = "uncommon",
      upg_req = "perks-grind_hot_1,perks-grind_hot_2,perks-grind_hot_3,perks-grind_hot_4",
      "player_damage_to_hot_extra_ticks"
    },

    -- Yakuza
    yakuza_recovery_1 = {
      dlc_owned = false, upg_type = "common",
      disable = "yakuza_recovery_2,yakuza_recovery_3,anarch_recovery,stoic_armor_convert",
      "player_armor_regen_damage_health_ratio_multiplier_1"
    },
    yakuza_recovery_2 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "yakuza_recovery_1,yakuza_recovery_3,anarch_recovery,stoic_armor_convert",
      "player_armor_regen_damage_health_ratio_multiplier_2"
    },
    yakuza_recovery_3 = {
      dlc_owned = false, upg_type = "rare",
      disable = "yakuza_recovery_1,yakuza_recovery_2,anarch_recovery,stoic_armor_convert",
      "player_armor_regen_damage_health_ratio_multiplier_3"
    },
    yakuza_speed = {
      dlc_owned = false, upg_type = "common",
      "player_movement_speed_damage_health_ratio_multiplier"
    },
    yakuza_threshold = {
      dlc_owned = false, upg_type = "uncommon",
      upg_req = "perks-yakuza_recovery_1,perks-yakuza_recovery_2,perks-yakuza_recovery_3,perks-yakuza_speed",
      "player_armor_regen_damage_health_ratio_threshold_multiplier",
      "player_movement_speed_damage_health_ratio_threshold_multiplier"
    },

    -- Ex-Pres
    expres_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "expres_2,expres_3,stoic_armor_convert",
      "player_armor_health_store_amount_1"
    },
    expres_2 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "expres_1,expres_3,stoic_armor_convert",
      "player_armor_health_store_amount_2"
    },
    expres_3 = {
      dlc_owned = true, upg_type = "rare",
      disable = "expres_1,expres_2,stoic_armor_convert",
      "player_armor_health_store_amount_3"
    },
    expres_cap = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-expres_1,perks-expres_2,perks-expres_3",
      "player_armor_max_health_store_multiplier"
    },
    expres_recovery = {
      dlc_owned = true, upg_type = "rare",
      disable = "anarch_recovery,stoic_armor_convert",
      "player_kill_change_regenerate_speed"
    },

    -- Maniac
    maniac_base = {
      dlc_owned = true, upg_type = "rare",
      "player_cocaine_stacking_1",
      "player_sync_cocaine_stacks"
    },
    maniac_decay = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-maniac_base",
      "player_cocaine_stacks_decay_multiplier_1"
    },
    maniac_cap = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-maniac_base",
      "player_sync_cocaine_upgrade_level_1"
    },
    maniac_boost = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-maniac_base",
      "player_cocaine_stack_absorption_multiplier_1"
    },
    
    -- Anarchist
    anarch_recovery = {
      dlc_owned = false, upg_type = "rare",
      disable = "stoic_armor_convert,armorer_recovery,expres_recovery,yakuza_recovery_1,yakuza_recovery_2," ..
                "yakuza_recovery_3,burglar_recovery,crook_recovery,hitman_recovery_1,hitman_recovery_2," ..
                "hitman_recovery_3,hitman_recovery_4,hitman_recovery_5,hitman_recovery_6,armorer_recovery",
      "player_armor_grinding_1"
    },
    anarch_armour_1 = {
      dlc_owned = false, upg_type = "common",
      disable = "anarch_armour_2,anarch_armour_3",
      "player_armor_increase_1",
      "player_health_decrease_1"
    },
    anarch_armour_2 = {
      dlc_owned = false, upg_type = "uncommon",
      disable = "anarch_armour_1,anarch_armour_3",
      "player_armor_increase_2",
      "player_health_decrease_2"
    },
    anarch_armour_3 = {
      dlc_owned = false, upg_type = "rare",
      disable = "anarch_armour_1,anarch_armour_2",
      "player_armor_increase_3",
      "player_health_decrease_3"
    },
    anarch_bullseye = {
      dlc_owned = false, upg_type = "rare",
      disable = "stoic_armor_convert",
      "player_damage_to_armor_1"
    },

    -- Biker
    biker_base = {
      dlc_owned = false, upg_type = "uncommon",
      "player_wild_health_amount_1",
      "player_wild_armor_amount_1"
    },
    biker_armour_plus = {
      dlc_owned = false, upg_type = "common",
      upg_req = "perks-biker_base",
      disable = "stoic_armor_convert",
      "player_less_health_wild_armor_1"
    },
    biker_health_cd = {
      dlc_owned = false, upg_type = "common",
      upg_req = "perks-biker_base",
      "player_less_health_wild_cooldown_1"
    },
    biker_health_plus = {
      dlc_owned = false, upg_type = "common",
      upg_req = "perks-biker_base",
      "player_less_armor_wild_health_1"
    },
    biker_armour_cd = {
      dlc_owned = false, upg_type = "common",
      upg_req = "perks-biker_base",
      "player_less_armor_wild_cooldown_1"
    },

    -- Kingpin
    kingpin_base = {
      dlc_owned = false, upg_type = "common",
      disable = "sicario_base,stoic_base,h3h3_base,hacker_base,leech_base",
      "chico_injector", "temporary_chico_injector_1"
    },
    kingpin_prio = {
      dlc_owned = false, upg_type = "uncommon",
      upg_req = "perks-kingpin_base",
      "player_chico_preferred_target"
    },
    kingpin_immunity = {
      dlc_owned = false, upg_type = "uncommon",
      upg_req = "perks-kingpin_base",
      "player_chico_injector_low_health_multiplier"
    },
    kingpin_cd = {
      dlc_owned = false, upg_type = "common",
      upg_req = "perks-kingpin_base",
      "player_chico_injector_health_to_speed"
    },

    -- Sicario
    sicario_base = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "kingpin_base,stoic_base,h3h3_base,hacker_base,leech_base",
      "smoke_screen_grenade"
    },
    sicario_dodge_stack = {
      dlc_owned = true, upg_type = "uncommon",
      "player_dodge_shot_gain"
    },
    sicario_recovery = {
      dlc_owned = true, upg_type = "rare",
      disable = "stoic_armor_convert",
      "player_dodge_replenish_armor"
    },
    sicario_boost = {
      dlc_owned = true, upg_type = "common", upg_req = "perks-sicario_base",
      "player_sicario_multiplier"
    },

    -- Stoic
    stoic_base = {
      dlc_owned = true, upg_type = "common",
      disable = "sicario_base,kingpin_base,h3h3_base,hacker_base,leech_base",
      "damage_control",
      "player_damage_control_passive",
      "player_damage_control_cooldown_drain_1"
    },
    stoic_cd = {
      dlc_owned = true, upg_type = "common",
      upg_req = "perks-stoic_base",
      "player_damage_control_cooldown_drain_2"
    },
    stoic_armor_convert = {
      dlc_owned = true, upg_type = "common", count = "armor:1",
      upg_req = "perks-stoic_base,perks-grind_hot_1,perks-grind_hot_2,perks-grind_hot_3,perks-grind_hot_4," ..
                "perks-gambler_heal_1,perks-gambler_heal_2,perks-gambler_heal_3,perks-muscle_regen,perks-biker_base," ..
                "perks-h3h3_base,perks-socio_heal,perks-infil_melee_heal,perks-kingpin_immunity,perks-hacker_heal," ..
                "perks-leech_base,perks-copycat_bullseye,skills-hostage_taker",
                -- source of healing required or this is unusable
      disable = "anarch_recovery,armorer_recovery,expres_recovery,yakuza_recovery_1,yakuza_recovery_2," ..
                "yakuza_recovery_3,burglar_recovery,crook_recovery,hitman_recovery_1,hitman_recovery_2," ..
                "hitman_recovery_3,hitman_recovery_4,hitman_recovery_5,hitman_recovery_6,armorer_recovery," ..
                "anarch_bullseye,biker_armour_plus,sicario_recovery,expres_1,expres_2,expres_3,socio_armor_1,socio_armor_2",
                -- armour regen perks don't do anything
      "player_armor_to_health_conversion"
    },
    stoic_negate = {
      dlc_owned = true, upg_type = "common",
      upg_req = "perks-stoic_base",
      "player_damage_control_auto_shrug"
    },
    stoic_heal = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-stoic_base",
      "player_damage_control_healing"
    },

    -- Tag Team
    h3h3_base = {
      dlc_owned = false, upg_type = "common",
      disable = "sicario_base,stoic_base,kingpin_base,hacker_base,leech_base",
      "tag_team",
      "player_tag_team_base",
      "player_tag_team_cooldown_drain_1"
    },
    h3h3_cd = {
      dlc_owned = false, upg_type = "common",
      upg_req = "perks-h3h3_base",
      "player_tag_team_cooldown_drain_2"
    },
    h3h3_absorption = {
      dlc_owned = false, upg_type = "rare",
      upg_req = "perks-h3h3_base",
      "player_tag_team_damage_absorption"
    },

    -- Hacker
    hacker_base = {
      dlc_owned = true, upg_type = "common",
      disable = "sicario_base,stoic_base,h3h3_base,kingpin_base,leech_base",
      "pocket_ecm_jammer",
      "player_pocket_ecm_jammer_base"
    },
    hacker_heal = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-hacker_base",
      "player_pocket_ecm_heal_on_kill_1"
    },
    hacker_dodge = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-hacker_base",
      "player_pocket_ecm_kill_dodge_1"
    },
    hacker_team_heal = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-hacker_base",
      "team_pocket_ecm_heal_on_kill_1"
    },

    -- Leech
    leech_base = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "sicario_base,stoic_base,h3h3_base,hacker_base,kingpin_base",
      "copr_ability",
      "temporary_copr_ability_1",
      "player_copr_static_damage_ratio_1",
      "player_copr_kill_life_leech_1",
      "player_copr_activate_bonus_health_ratio_1",
      "player_copr_teammate_heal_1"
    },
    leech_duration = {
      dlc_owned = true, upg_type = "uncommon",
      upg_req = "perks-leech_base",
      "temporary_copr_ability_2"
    },
    leech_segments = {
      dlc_owned = true, upg_type = "common",
      upg_req = "perks-leech_base",
      "player_copr_static_damage_ratio_2",
      "player_copr_kill_life_leech_2"
    },
    leech_swan_song = {
      dlc_owned = true, upg_type = "rare",
      upg_req = "perks-leech_base",
      "player_copr_out_of_health_move_slow_1"
    },
    leech_cd = {
      dlc_owned = true, upg_type = "common",
      upg_req = "perks-leech_base",
      "player_copr_speed_up_on_kill_1"
    },
    leech_revive = {
      dlc_owned = true, upg_type = "rare",
      upg_req = "perks-leech_base",
      "player_activate_ability_downed"
    },

    -- Copycat
    copycat_health = {
      dlc_owned = true, upg_type = "rare",
      "mrwi_health_multiplier_1",
      "mrwi_health_multiplier_2",
      "mrwi_health_multiplier_3",
      "mrwi_health_multiplier_4"
    },
    copycat_armour = {
      dlc_owned = true, upg_type = "uncommon",
      "mrwi_armor_multiplier_1",
      "mrwi_armor_multiplier_2",
      "mrwi_armor_multiplier_3",
      "mrwi_armor_multiplier_4"
    },
    copycat_dodge = {
      dlc_owned = true, upg_type = "common",
      "mrwi_dodge_chance_1",
      "mrwi_dodge_chance_2",
      "mrwi_dodge_chance_3",
      "mrwi_dodge_chance_4"
    },
    copycat_crouch = {
      dlc_owned = true, upg_type = "uncommon",
      "mrwi_crouch_speed_multiplier_1",
      "mrwi_crouch_speed_multiplier_2",
      "mrwi_crouch_speed_multiplier_3",
      "mrwi_crouch_speed_multiplier_4"
    },
    copycat_bag = {
      dlc_owned = true, upg_type = "uncommon",
      "mrwi_carry_speed_multiplier_1",
      "mrwi_carry_speed_multiplier_2",
      "mrwi_carry_speed_multiplier_3",
      "mrwi_carry_speed_multiplier_4"
    },
    copycat_tactical_reload = {
      dlc_owned = true, upg_type = "common",
      "player_primary_reload_secondary_1",
      "player_secondary_reload_primary_1"
    },
    copycat_reload_switch = {
      dlc_owned = true, upg_type = "common",
      upg_req = "perks-copycat_tactical_reload",
      "weapon_mrwi_swap_speed_multiplier_1"
    },
    copycat_bullseye = {
      dlc_owned = true, upg_type = "rare",
      "player_headshot_regen_health_bonus_1"
    },
    copycat_ricochet = {
      dlc_owned = true, upg_type = "uncommon",
      "player_dodge_ricochet_bullets"
    },
    copycat_immunity = {
      dlc_owned = true, upg_type = "uncommon",
      "temporary_mrwi_health_invulnerable_1"
    }
  },

  stats = {

    -- Default Upgrades
    shinobi_speed = {
      dlc_owned = true, upg_type = "common",
      "player_walk_speed_multiplier",
      "player_crouch_speed_multiplier"
    },
    fast_hands_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "fast_hands_2",
      "carry_interact_speed_multiplier_1"
    },
    fast_hands_2 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "fast_hands_1",
      "carry_interact_speed_multiplier_2"
    },
    bag_penalty_reduction = {
      dlc_owned = true, upg_type = "common",
      "carry_movement_speed_multiplier"
    },
    fall_damage_reduction = {
      dlc_owned = true, upg_type = "uncommon",
      "player_fall_damage_multiplier"
    },
    body_bag_capacity = {
      dlc_owned = true, upg_type = "uncommon",
      count_req = "permaskills:2",
      "player_corpse_dispose_amount_2"
    },
    body_bag_max_capacity = {
      dlc_owned = true, upg_type = "uncommon",
      count_req = "permaskills:2",
      "player_extra_corpse_dispose_amount"
    },
    striker_reload_speed = {
      dlc_owned = true, upg_type = "uncommon",
      "striker_reload_speed_default"
    },
    akimbo_recoil_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "akimbo_recoil_2,akimbo_recoil_3,akimbo_recoil_4",
      "akimbo_recoil_index_addend_1"
    },
    akimbo_recoil_2 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "akimbo_recoil_1,akimbo_recoil_3,akimbo_recoil_4",
      "akimbo_recoil_index_addend_2"
    },
    akimbo_recoil_3 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "akimbo_recoil_1,akimbo_recoil_2,akimbo_recoil_4",
      "akimbo_recoil_index_addend_3"
    },
    akimbo_recoil_4 = {
      dlc_owned = true, upg_type = "rare",
      disable = "akimbo_recoil_1,akimbo_recoil_2,akimbo_recoil_3",
      "akimbo_recoil_index_addend_4"
    },

    -- Mastermind Skills
    revive_speed = {
      dlc_owned = true, upg_type = "rare",
      "player_revive_interaction_speed_multiplier"
    },
    start_cable_ties_1 = {
      dlc_owned = true, upg_type = "common",
      "cable_tie_quantity"
    },
    cable_tie_speed = {
      dlc_owned = true, upg_type = "common",
      "cable_tie_interact_speed_multiplier"
    },
    shout_distance = {
      dlc_owned = true, upg_type = "common",
      "player_intimidate_range_mul"
    },
    civ_intimidation_time = {
      dlc_owned = true, upg_type = "common",
      "player_civ_intimidation_mul"
    },
    stability_bonus_1 = {
      dlc_owned = true, upg_type = "uncommon",
      "player_stability_increase_bonus_1"
    },
    static_accuracy_bonus = {
      dlc_owned = true, upg_type = "common",
      "player_not_moving_accuracy_increase_bonus_1"
    },
    ads_speed = {
      dlc_owned = true, upg_type = "common",
      "weapon_enter_steelsight_speed_multiplier",
      "shotgun_enter_steelsight_speed_multiplier"
    },
    ads_movement_speed = {
      dlc_owned = true, upg_type = "common",
      "player_steelsight_normal_movement_speed"
    },
    ads_zoom = {
      dlc_owned = true, upg_type = "common",
      "lmg_zoom_increase",
      "assault_rifle_zoom_increase",
      "snp_zoom_increase",
      "smg_zoom_increase",
      "pistol_zoom_increase"
    },
    moving_accuracy_bonus = {
      dlc_owned = true, upg_type = "uncommon",
      "assault_rifle_move_spread_index_addend",
      "snp_move_spread_index_addend",
      "smg_move_spread_index_addend"
    },
    single_shot_flat_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_single_spread_index_addend"
    },
    single_shot_percent_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "single_shot_accuracy_inc_1"
    },
    kilmer = {
      dlc_owned = true, upg_type = "uncommon",
      "assault_rifle_reload_speed_multiplier",
      "smg_reload_speed_multiplier",
      "snp_reload_speed_multiplier"
    },

    -- Enforcer Skills
    shotgun_reload_1 = {
      dlc_owned = true, upg_type = "common",
      disable = "shotgun_reload_2",
      "shotgun_reload_speed_multiplier_1"
    },
    shotgun_reload_2 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "shotgun_reload_1",
      "shotgun_reload_speed_multiplier_2"
    },
    shotgun_stability = {
      dlc_owned = true, upg_type = "uncommon",
      "shotgun_recoil_index_addend"
    },
    shotgun_dmg = {
      dlc_owned = true, upg_type = "uncommon",
      "shotgun_damage_multiplier_2"
    },
    shotgun_ads_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "shotgun_steelsight_accuracy_inc_1"
    },
    shotgun_range_bonus = {
      dlc_owned = true, upg_type = "common",
      "shotgun_steelsight_range_inc_1"
    },
    shotgun_hip_rof = {
      dlc_owned = true, upg_type = "uncommon",
      "shotgun_hip_rate_of_fire_1"
    },
    shotgun_mag_capacity = {
      dlc_owned = true, upg_type = "uncommon",
      "shotgun_magazine_capacity_inc_1"
    },
    weapon_switch_speed = {
      dlc_owned = true, upg_type = "common",
      "weapon_swap_speed_multiplier"
    },
    recovery_1 = {
      dlc_owned = true, upg_type = "uncommon",
      "player_armor_regen_time_mul_1"
    },
    team_recovery = {
      dlc_owned = true, upg_type = "rare",
      "team_armor_regen_time_multiplier"
    },
    lbv_boost = {
      dlc_owned = true, upg_type = "uncommon",
      item_req = "body_armor1",
      "player_level_2_armor_addend"
    },
    vest_boost = {
      dlc_owned = true, upg_type = "uncommon",
      item_req = "body_armor2",
      "player_level_3_armor_addend"
    },
    hbv_boost = {
      dlc_owned = true, upg_type = "uncommon",
      item_req = "body_armor3",
      "player_level_4_armor_addend"
    },
    bag_throw_distance = {
      dlc_owned = true, upg_type = "common",
      "carry_throw_distance_multiplier"
    },
    bulletproof = {
      dlc_owned = true, upg_type = "rare",
      "player_armor_multiplier"
    },
    ammo_range = {
      dlc_owned = true, upg_type = "common",
      "player_increased_pickup_area_1"
    },
    saw_capacity = {
      dlc_owned = true, upg_type = "rare", count_req = "saws:1",
      "saw_extra_ammo_multiplier"
    },
    saw_speed = {
      dlc_owned = true, upg_type = "rare", count_req = "saws:1",
      "player_saw_speed_multiplier_2"
    },
    saw_lock_dmg = {
      dlc_owned = true, upg_type = "rare", count_req = "saws:1",
      "saw_lock_damage_multiplier_2"
    },
    saw_efficiency = {
      dlc_owned = true, upg_type = "uncommon", count_req = "saws:1",
      "saw_enemy_slicer"
    },
    ammo_capacity = {
      dlc_owned = true, upg_type = "rare",
      "extra_ammo_multiplier1"
    },

    -- Technician Skills
    accuracy_bonus = {
      dlc_owned = true, upg_type = "uncommon",
      "player_weapon_accuracy_increase_1"
    },
    stability_bonus_2 = {
      dlc_owned = true, upg_type = "uncommon",
      "player_stability_increase_bonus_2"
    },
    accuracy_hip_bonus = {
      dlc_owned = true, upg_type = "rare",
      "player_hip_fire_accuracy_inc_1"
    },
    stability_movement_penalty = {
      dlc_owned = true, upg_type = "uncommon",
      "player_weapon_movement_stability_1"
    },
    mag_capacity = {
      dlc_owned = true, upg_type = "uncommon",
      "player_automatic_mag_increase_1"
    },

    -- Ghost Skills
    not_sus = {
      dlc_owned = true, upg_type = "common",
      "player_suspicion_bonus"
    },
    lockpick_speed = {
      dlc_owned = true, upg_type = "common",
      "player_pick_lock_easy_speed_multiplier"
    },
    sprinter = {
      dlc_owned = true, upg_type = "common",
      "player_run_speed_multiplier",
      "player_run_dodge_chance"
    },
    move_speed = {
      dlc_owned = true, upg_type = "common",
      "player_movement_speed_multiplier"
    },
    climb_speed = {
      dlc_owned = true, upg_type = "common",
      "player_climb_speed_multiplier_2"
    },
    melee_conceal = {
      dlc_owned = true, upg_type = "common",
      "player_melee_concealment_modifier"
    },
    vest_conceal = {
      dlc_owned = true, upg_type = "common",
      item_req = "body_armor1,body_armor2,body_armor3",
      "player_ballistic_vest_concealment_1"
    },
    reduced_prio = {
      dlc_owned = true, upg_type = "uncommon",
      "player_camouflage_bonus_1",
      "player_camouflage_bonus_2"
    },
    silencer_conceal = {
      dlc_owned = true, upg_type = "common",
      "player_silencer_concealment_penalty_decrease_1",
      "player_silencer_concealment_increase_1"
    },
    silencer_stability = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_silencer_recoil_index_addend"
    },
    silencer_ads_speed = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_silencer_enter_steelsight_speed_multiplier"
    },
    silencer_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_silencer_spread_index_addend"
    },
    mark_duration = {
      dlc_owned = true, upg_type = "common",
      "player_mark_enemy_time_multiplier"
    },

    -- Fugitive Skills
    pistol_swap_speed = {
      dlc_owned = true, upg_type = "common",
      "pistol_swap_speed_multiplier"
    },
    pistol_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_spread_index_addend"
    },
    pistol_capacity = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_magazine_capacity_inc_1"
    },
    pistol_rof = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_fire_rate_multiplier"
    },
    akimbo_capacity_1 = {
      dlc_owned = true, upg_type = "uncommon",
      disable = "akimbo_capacity_2",
      "akimbo_extra_ammo_multiplier_1"
    },
    akimbo_capacity_2 = {
      dlc_owned = true, upg_type = "rare",
      disable = "akimbo_capacity_1",
      "akimbo_extra_ammo_multiplier_2"
    },
    pistol_dmg = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_damage_addend_2"
    },
    pistol_reload_speed = {
      dlc_owned = true, upg_type = "common",
      "pistol_reload_speed_multiplier"
    },
    bleedout_health = {
      dlc_owned = true, upg_type = "common",
      "player_bleed_out_health_multiplier"
    },
    incoming_melee_reduction = {
      dlc_owned = true, upg_type = "common",
      "player_melee_damage_dampener"
    },
    melee_knockdown = {
      dlc_owned = true, upg_type = "common",
      "player_melee_knockdown_mul"
    },
    melee_dmg = {
      dlc_owned = true, upg_type = "common",
      "player_non_special_melee_multiplier",
      "player_melee_damage_multiplier"
    },

    -- Removed Skills
    cam_shake = {
      dlc_owned = true, upg_type = "common",
      "player_damage_shake_multiplier"
    },
    shotgun_hip_accuracy = {
      dlc_owned = true, upg_type = "common",
      "shotgun_hip_fire_spread_index_addend"
    },
    hip_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_hip_fire_spread_index_addend"
    },
    mag_plus = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_clip_ammo_increase_2"
    },
    smg_rof = {
      dlc_owned = true, upg_type = "rare",
      "smg_fire_rate_multiplier"
    },
    custody_time = {
      dlc_owned = true, upg_type = "rare",
      "player_respawn_time_multiplier"
    },
    zipline_dodge = {
      dlc_owned = true, upg_type = "common",
      "player_on_zipline_dodge_chance"
    },
    crouch_dodge = {
      dlc_owned = true, upg_type = "uncommon",
      "player_crouch_dodge_chance_2"
    },
    silencer_ap = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_silencer_armor_piercing_chance_2"
    },

    -- Unused Skills
    crit_chance = {
      dlc_owned = true, upg_type = "rare",
      "player_critical_hit_chance_1"
    },
    health_bonus = {
      dlc_owned = true, upg_type = "rare",
      "player_health_multiplier"
    },
    armour_bonus = {
      dlc_owned = true, upg_type = "uncommon",
      "player_passive_armor_multiplier_2"
    },
    recovery_2 = {
      dlc_owned = true, upg_type = "rare",
      "player_armor_regen_timer_multiplier"
    },
    concealment = {
      dlc_owned = true, upg_type = "common",
      "player_concealment_bonus_1"
    },
    sharp_melee_dmg = {
      dlc_owned = true, upg_type = "uncommon",
      "player_melee_sharp_damage_multiplier"
    },
    threat_big = {
      dlc_owned = true, upg_type = "common",
      "player_suppression_bonus", "player_passive_suppression_bonus_2"
    },
    damage_reduction = {
      dlc_owned = true, upg_type = "uncommon",
      "player_damage_dampener"
    },
    nebula_plus = {
      dlc_owned = true, upg_type = "rare",
      "player_assets_cost_multiplier", "player_assets_cost_multiplier_b", "passive_player_assets_cost_multiplier"
    },
    cam_loop_distance = {
      dlc_owned = true, upg_type = "common",
      upg_req = "skills-cam_loop",
      "player_tape_loop_interact_distance_mul_1"
    },
    start_cable_ties_2 = {
      dlc_owned = true, upg_type = "uncommon",
      "cable_tie_quantity_2"
    },
    saw_rof = {
      dlc_owned = true, upg_type = "uncommon", count_req = "saws:1",
      "saw_fire_rate_multiplier_2"
    },
    saw_swap_speed = {
      dlc_owned = true, upg_type = "common", count_req = "saws:1",
      "saw_swap_speed_multiplier"
    },
    saw_reload_speed = {
      dlc_owned = true, upg_type = "common", count_req = "saws:1",
      "saw_reload_speed_multiplier"
    },
    ar_stability = {
      dlc_owned = true, upg_type = "uncommon",
      "assault_rifle_recoil_index_addend"
    },
    lmg_stability = {
      dlc_owned = true, upg_type = "uncommon",
      "lmg_recoil_index_addend"
    },
    snp_stability = {
      dlc_owned = true, upg_type = "uncommon",
      "snp_recoil_index_addend"
    },
    modded_bonus = {
      dlc_owned = true, upg_type = "rare",
      "weapon_modded_damage_multiplier", "weapon_modded_spread_multiplier", "weapon_modded_recoil_multiplier"
    },
    single_shot_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_single_spread_multiplier"
    }, 
    silencer_accuracy_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_silencer_spread_multiplier"
    },
    silencer_stability_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_silencer_recoil_multiplier"
    },
    reload_speed = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_passive_reload_speed_multiplier"
    },
    stability_bonus_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_passive_recoil_multiplier_2"
    },
    accuracy_bonus_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "weapon_spread_multiplier"
    },
    rof_bonus = {
      dlc_owned = true, upg_type = "rare",
      "weapon_fire_rate_multiplier"
    },
    pistol_damage = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_damage_multiplier"
    },
    pistol_accuracy_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_spread_multiplier"
    },
    pistol_sprint_end = {
      dlc_owned = true, upg_type = "common",
      "pistol_exit_run_speed_multiplier"
    },
    pistol_hip_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "pistol_hip_fire_spread_multiplier"
    },
    ar_stability_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "assault_rifle_recoil_multiplier"
    },
    ar_accuracy_moving = {
      dlc_owned = true, upg_type = "uncommon",
      "assault_rifle_move_spread_multiplier"
    },
    ar_hip_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "assault_rifle_hip_fire_spread_multiplier"
    },
    lmg_stability_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "lmg_recoil_multiplier"
    },
    lmg_reload = {
      dlc_owned = true, upg_type = "rare",
      "lmg_reload_speed_multiplier"
    },
    lmg_accuracy_moving = {
      dlc_owned = true, upg_type = "uncommon",
      "lmg_move_spread_multiplier"
    },
    lmg_hip_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "lmg_hip_fire_spread_multiplier"
    },
    snp_accuracy_moving = {
      dlc_owned = true, upg_type = "uncommon",
      "snp_move_spread_multiplier"
    },
    snp_hip_accuracy = {
      dlc_owned = true, upg_type = "common",
      "snp_hip_fire_spread_multiplier"
    },
    smg_hip_accuracy = {
      dlc_owned = true, upg_type = "uncommon",
      "smg_hip_fire_spread_multiplier"
    },
    shotgun_stability_percent = {
      dlc_owned = true, upg_type = "uncommon",
      "shotgun_recoil_multiplier"
    },
    shotgun_hip_accuracy_percent = {
      dlc_owned = true, upg_type = "common",
      "shotgun_hip_fire_spread_multiplier"
    },
    akimbo_dmg = {
      dlc_owned = true, upg_type = "rare",
      "akimbo_damage_multiplier_1" 
    }
  },

  deployable = {

    doctor_bag_capacity_1 = {
      dlc_owned = true, item_req = "doctor_bag",
      disable = "doctor_bag_capacity_2",
      "doctor_bag_quantity"
    },
    doctor_bag_capacity_2 = {
      dlc_owned = true, item_req = "doctor_bag",
      disable = "doctor_bag_capacity_1",
      "doctor_bag_quantity",
      "doctor_bag_quantity_2"
    },
    doctor_bag_charges = {
      dlc_owned = true, item_req = "doctor_bag",
      "doctor_bag_amount_increase1"
    },
    health_deployable_buff = {
      dlc_owned = true, item_req = "doctor_bag,first_aid_kit",
      "first_aid_kit_damage_reduction_upgrade",
      "first_aid_kit_deploy_time_multiplier"
    },
    fak_capacity_1 = {
      dlc_owned = true, item_req = "first_aid_kit",
      disable = "fak_capacity_2",
      "first_aid_kit_quantity_increase_1"
    },
    fak_capacity_2 = {
      dlc_owned = true, item_req = "first_aid_kit",
      disable = "fak_capacity_1",
      "first_aid_kit_quantity_increase_1",
      "first_aid_kit_quantity_increase_2"
    },
    fak_restore_down = {
      dlc_owned = true, item_req = "first_aid_kit",
      "first_aid_kit_downs_restore_chance"
    },
    fak_autoheal = {
      dlc_owned = true, item_req = "first_aid_kit",
      "first_aid_kit_auto_recovery_1"
    },
    ammo_bag_capacity_1 = {
      dlc_owned = true, item_req = "ammo_bag",
      disable = "ammo_bag_capacity_2",
      "ammo_bag_quantity"
    },
    ammo_bag_capacity_2 = {
      dlc_owned = true, item_req = "ammo_bag",
      disable = "ammo_bag_capacity_1",
      "ammo_bag_quantity",
      "ammo_bag_quantity_2"
    },
    ammo_bag_charges = {
      dlc_owned = true, item_req = "ammo_bag",
      "ammo_bag_ammo_increase1"
    },
    ammo_bag_inf = {
      dlc_owned = true, item_req = "ammo_bag",
      "temporary_no_ammo_cost_2"
    },
    sentry_capacity_1 = {
      dlc_owned = true, item_req = "sentry_gun,sentry_gun_silent",
      disable = "sentry_capacity_2",
      "sentry_gun_quantity_1"
    },
    sentry_capacity_2 = {
      dlc_owned = true, item_req = "sentry_gun,sentry_gun_silent",
      disable = "sentry_capacity_1",
      "sentry_gun_quantity_2"
    },
    sentry_cost = {
      dlc_owned = true, item_req = "sentry_gun,sentry_gun_silent",
      "sentry_gun_cost_reduction_1",
      "sentry_gun_cost_reduction_2",
      "player_sentry_gun_deploy_time_multiplier"
    },
    sentry_accuracy = {
      dlc_owned = true, item_req = "sentry_gun,sentry_gun_silent",
      "sentry_gun_spread_multiplier",
      "sentry_gun_rot_speed_multiplier",
      "sentry_gun_extra_ammo_multiplier_1"
    },
    sentry_health = {
      dlc_owned = true, item_req = "sentry_gun,sentry_gun_silent",
      "sentry_gun_shield",
      "sentry_gun_armor_multiplier"
    },
    sentry_ap = {
      dlc_owned = true, item_req = "sentry_gun,sentry_gun_silent",
      "sentry_gun_ap_bullets",
      "sentry_gun_fire_rate_reduction_1",
      "sentry_gun_damage_multiplier"
    },
    charge_capacity_1 = {
      dlc_owned = true, item_req = "trip_mine",
      disable = "charge_capacity_2",
      "shape_charge_quantity_increase_1",
      "shape_charge_quantity_increase_2"
    },
    charge_capacity_2 = {
      dlc_owned = true, item_req = "trip_mine",
      disable = "charge_capacity_1",
      "shape_charge_quantity_increase_1",
      "shape_charge_quantity_increase_2",
      "shape_charge_quantity_increase_3",
    },
    trip_capacity_1 = {
      dlc_owned = true, item_req = "trip_mine",
      disable = "trip_capacity_2",
      "trip_mine_quantity_increase_1"
    },
    trip_capacity_2 = {
      dlc_owned = true, item_req = "trip_mine",
      disable = "trip_capacity_1",
      "trip_mine_quantity_increase_2"
    },
    trip_radius_1 = {
      dlc_owned = true, item_req = "trip_mine",
      "trip_mine_explosion_size_multiplier_1",
      "player_trip_mine_deploy_time_multiplier_2"
    },
    trip_radius_2 = {
      dlc_owned = true, item_req = "trip_mine",
      "trip_mine_explosion_size_multiplier_2",
      "trip_mine_damage_multiplier_1"
    },
    trip_fire = {
      dlc_owned = true, item_req = "trip_mine",
      "trip_mine_fire_trap_1",
      "trip_mine_fire_trap_2"
    },
    trip_sensor = {
      dlc_owned = true, item_req = "trip_mine",
      "trip_mine_sensor_toggle",
      "trip_mine_sensor_highlight",
    },
    ecm_capacity_1 = {
      dlc_owned = true, item_req = "ecm_jammer",
      disable = "ecm_capacity_2",
      "ecm_jammer_quantity_increase_1"
    },
    ecm_capacity_2 = {
      dlc_owned = true, item_req = "ecm_jammer",
      disable = "ecm_capacity_1",
      "ecm_jammer_quantity_increase_2"
    },
    ecm_jam_duration_1 = {
      dlc_owned = true, item_req = "ecm_jammer",
      disable = "ecm_jam_duration_2",
      "ecm_jammer_duration_multiplier"
    },
    ecm_jam_duration_2 = {
      dlc_owned = true, item_req = "ecm_jammer",
      disable = "ecm_jam_duration_1",
      "ecm_jammer_duration_multiplier_2",
      "ecm_jammer_duration_multiplier"
    },
    ecm_feedback_duration_1 = {
      dlc_owned = true, item_req = "ecm_jammer",
      upg_req = "deployable-ecm_feedback",
      disable = "ecm_feedback_duration_2",
      "ecm_jammer_feedback_duration_boost"
    },
    ecm_feedback_duration_2 = {
      dlc_owned = true, item_req = "ecm_jammer",
      upg_req = "deployable-ecm_feedback",
      disable = "ecm_feedback_duration_1",
      "ecm_jammer_feedback_duration_boost_2",
      "ecm_jammer_feedback_duration_boost"
    },
    ecm_doors = {
      dlc_owned = true, item_req = "ecm_jammer",
      "ecm_jammer_can_open_sec_doors"
    },
    ecm_pagers = {
      dlc_owned = true, item_req = "ecm_jammer",
      "ecm_jammer_affects_pagers",
      "ecm_jammer_affects_cameras"
    },
    ecm_feedback = {
      dlc_owned = true, item_req = "ecm_jammer",
      "ecm_jammer_can_activate_feedback",
      "ecm_jammer_can_retrigger",
      "ecm_jammer_interaction_speed_multiplier"
    },
    bodybag_capacity = {
      dlc_owned = true, item_req = "bodybags_bag",
      "bodybags_bag_quantity"
    }
  }
}

-- UNTESTED:
-- team_pistol_recoil_index_addend team_pistol_suppression_recoil_index_addend team_weapon_recoil_index_addend
-- team_weapon_suppression_recoil_index_addend player_damage_shake_addend player_suppressed_bonus
-- player_uncover_progress_mul player_uncover_progress_decay_mul 

-- MULTIPLAYER:
-- player_revive_health_boost player_revive_damage_reduction_level_1 player_revive_damage_reduction_level_2