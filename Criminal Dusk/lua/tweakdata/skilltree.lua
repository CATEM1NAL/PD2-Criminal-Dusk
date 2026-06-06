local function digest(value)
	return Application:digest_value(value, true)
end

Hooks:PostHook(SkillTreeTweakData, "init", "CrimDawn_SkillTreeTweakInit", function(self)
  self.tier_unlocks = { digest(0), digest(0), digest(0), digest(0) }
  self.tier_cost = { { 1, 1, 1, 1, 1, 1, 1, 1 }, { 2, 2, 2, 2, 2 }, { 3, 3, 3, 3, 3 }, { 4, 4, 4, 4, 4 } }

  table.insert(self.specializations[15][5].upgrades, "player_health_decrease_2")
  table.insert(self.specializations[15][7].upgrades, "player_health_decrease_3")

  table.remove(self.skills.up_you_go, 2)

  -- Skill changes
  self.skills.prison_wife[1].upgrades = { "player_headshot_regen_health_bonus_1" }
  table.remove(self.skills.prison_wife, 2)

  -- Disable perk decks
  for i = 1, #self.specializations do
    for _, data in ipairs(self.specializations[i]) do
      if data.upgrades and next(data.upgrades) then data.upgrades = {} end
    end
  end

  -- Perk skill tree
  table.insert(self.skill_pages_order, "perks")
  self.skilltree.perks = { name_id = "st_menu_perks", desc_id = "st_menu_perks_desc" }

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
    { upgrades = { "player_dodge_replenish_armor" }, cost = self.costs.default },
    name_id = "menu_deck4_5", desc_id = "menu_deck4_5_skill", icon_xy = { 0, 0 }
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
    name_id = "menu_burglar_stealth", desc_id = "menu_burglar_stealth_desc", icon_xy = { 0, 0 }
  }

  -- Grinder
  self.skills.grinder_base = {
    { upgrades = { "player_damage_to_hot_1" }, cost = self.costs.default },
    { upgrades = { "player_damage_to_hot_2" }, cost = self.costs.default },
    { upgrades = { "player_damage_to_hot_3" }, cost = self.costs.default },
    { upgrades = { "player_damage_to_hot_4" }, cost = self.costs.default },
    name_id = "menu_deck11_7", desc_id = "menu_grinder_skill", icon_xy = { 0, 0 }
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

  -- Stoic
  self.skills.stoic_health = {
    { upgrades = { "player_armor_to_health_conversion" }, cost = self.costs.default },
    name_id = "menu_deck19_3", desc_id = "menu_deck19_3_skill", icon_xy = { 0, 0 }
  }

  -- Sicario
  self.skills.sicario_stack = {
    { upgrades = { "player_dodge_shot_gain" }, cost = self.costs.default },
    name_id = "menu_deck18_3", desc_id = "menu_sicario_stack_desc", icon_xy = { 0, 0 }
  }

  -- Hacker
  self.skills.hacker_heal = {
    { upgrades = { "player_pocket_ecm_heal_on_kill_1" }, cost = self.costs.default },
    { upgrades = { "team_pocket_ecm_heal_on_kill_1" }, cost = self.costs.default },
    name_id = "menu_deck21_5", desc_id = "menu_hacker_heal_desc", icon_xy = { 0, 0 }
  }
  self.skills.hacker_dodge = {
    { upgrades = { "player_pocket_ecm_kill_dodge_1" }, cost = self.costs.default },
    name_id = "menu_deck21_7", desc_id = "menu_hacker_dodge_desc", icon_xy = { 0, 0 }
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

  -- Copycat
  self.skills.copycat_ricochet = {
    { upgrades = { "player_dodge_ricochet_bullets" }, cost = self.costs.default },
    name_id = "menu_deck23_5", desc_id = "menu_ricochet_skill", icon_xy = { 0, 0 }
  }

  -- Dodge
  local PerkTree1 = {
    skill = "perks",
    name_id = "st_menu_perks_tree1",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "rogue_dodge" },
      { "crook_skill", "ex_pres" },
      { "hacker_dodge", "sicario_stack" },
      { "hacker_heal", "grinder_base", "yakuza_speed" }
    }
  } -- Stats
  local PerkTree2 = {
    skill = "perks",
    name_id = "st_menu_perks_tree2",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "muscle_health", "armorer_perk", "hitman_perk" },
      { "infil_melee", "infil_close" },
      { "muscle_panic", "infil_heal" },
      { "stoic_health", "maniac_base" }
    }
  } -- Consumables
  local PerkTree3 = {
    skill = "perks",
    name_id = "st_menu_perks_tree3",
    unlocked = true,
    background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
    tiers = {
      { "nine_lives" },
      { "running_from_death", "up_you_go" },
      { "perseverance", "feign_death" },
      { "messiah" }
    }
  }

  table.insert(self.trees, PerkTree1)
  table.insert(self.trees, PerkTree2)
  table.insert(self.trees, PerkTree3)

  -- Bonus skill tree
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
      { "running_from_death", "up_you_go", "feign_death", "messiah", "perseverance", "nine_lives", "combat_medic", "tea_time", "fast_learner", "tea_cookies", "medic_2x", "inspire" },
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