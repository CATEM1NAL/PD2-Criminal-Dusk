Hooks:PostHook(BlackMarketGui, "show_stats", "CrimDawn_SetupBlackMarketGUI", function(self)
  if tweak_data.blackmarket.armors[self._slot_data.name] then
    local equipped_slot = managers.blackmarket:equipped_armor_slot()
    local equipped_item = managers.blackmarket:equipped_item(self._slot_data.category)
    local equip_base_stats, _, equip_skill_stats = self:_get_armor_stats(equipped_item)
    local base_stats, _, skill_stats = self:_get_armor_stats(self._slot_data.name)
    local value = math.max(base_stats.stamina.value + skill_stats.stamina.value, 0)

    if self._slot_data.name == equipped_slot then
      local base = base_stats.stamina.value

      if value ~= 0 and value > base then
        self._armor_stats_texts.stamina.equip:set_color(tweak_data.screen_colors.stats_negative)
      elseif value ~= 0 and value < base then
        self._armor_stats_texts.stamina.equip:set_color(tweak_data.screen_colors.stats_positive)
      else self._armor_stats_texts.stamina.equip:set_color(tweak_data.screen_colors.text) end

    else local equip = math.max(equip_base_stats.stamina.value + equip_skill_stats.stamina.value, 0)
      if value > equip then
        self._armor_stats_texts.stamina.total:set_color(tweak_data.screen_colors.stats_negative)
		  elseif value < equip then
			  self._armor_stats_texts.stamina.total:set_color(tweak_data.screen_colors.stats_positive)
		  else self._armor_stats_texts.stamina.total:set_color(tweak_data.screen_colors.text) end
    end
  end
end)

Hooks:OverrideFunction(BlackMarketGui, "_get_armor_stats", function(self, name)
	local base_stats = {}
	local mods_stats = {}
	local skill_stats = {}
	local detection_risk = managers.blackmarket:get_suspicion_offset_from_custom_data({ armors = name}, tweak_data.player.SUSPICION_OFFSET_LERP or 0.75)
	detection_risk = math.round(detection_risk * 100)
	local bm_armor_tweak = tweak_data.blackmarket.armors[name]
	local upgrade_level = bm_armor_tweak.upgrade_level

	for i, stat in ipairs(self._armor_stats_shown) do
		base_stats[stat.name] = { value = 0 }
		mods_stats[stat.name] = { value = 0 }
		skill_stats[stat.name] = { value = 0 }

		if stat.name == "armor" then
			local base = tweak_data.player.damage.ARMOR_INIT
			local mod = managers.player:body_armor_value("armor", upgrade_level)
			base_stats[stat.name] = { value = (base + mod) * tweak_data.gui.stats_present_multiplier }
			skill_stats[stat.name] = {
			  value = (base_stats[stat.name].value + managers.player:body_armor_skill_addend(name) * tweak_data.gui.stats_present_multiplier) *
			           managers.player:body_armor_skill_multiplier(name) - base_stats[stat.name].value
			}

		elseif stat.name == "health" then
			local base = tweak_data.player.damage.HEALTH_INIT
			local mod = managers.player:health_skill_addend() * tweak_data.gui.stats_present_multiplier
			base_stats[stat.name] = { value = base * tweak_data.gui.stats_present_multiplier }
			skill_stats[stat.name] = { value = base_stats[stat.name].value * managers.player:health_skill_multiplier() + mod - base_stats[stat.name].value }

		elseif stat.name == "concealment" then
			base_stats[stat.name] = { value = managers.player:body_armor_value("concealment", upgrade_level) }
			skill_stats[stat.name] = { value = managers.blackmarket:concealment_modifier("armors", upgrade_level) }

		elseif stat.name == "movement" then
			local base = tweak_data.player.movement_state.standard.movement.speed.STANDARD_MAX / 100 * tweak_data.gui.stats_present_multiplier
			local movement_penalty = managers.player:body_armor_value("movement", upgrade_level)
			local base_value = movement_penalty * base
			base_stats[stat.name] = { value = base_value }
			local skill_mod = managers.player:movement_speed_multiplier(false, false, upgrade_level, 1)
			local val = base * skill_mod
			val = Utl.round(val, 2)
			base_value = Utl.round(base_value, 2)
			local skill_value = val - base_value
			skill_stats[stat.name] = { value = skill_value, skill_in_effect = skill_value > 0 }

		elseif stat.name == "dodge" then
			local base = 0
			local mod = managers.player:body_armor_value("dodge", upgrade_level)
			base_stats[stat.name] = { value = (base + mod) * 100 }
			skill_stats[stat.name] = { value = managers.player:skill_dodge_chance(false, false, false, name, detection_risk) * 100 }

		elseif stat.name == "crit" then
			local base = 0
			local mod = managers.player:body_armor_value("crit", upgrade_level)
			base_stats[stat.name] = { value = (base + mod) * 100 }
			skill_stats[stat.name] = { value = managers.player:critical_hit_chance(detection_risk) * 100 }

		elseif stat.name == "damage_shake" then
			local base = tweak_data.gui.armor_damage_shake_base
			local mod = math.max(managers.player:body_armor_value("damage_shake", upgrade_level, nil, 1), 0.01)
			local skill = math.max(managers.player:upgrade_value("player", "damage_shake_multiplier", 1), 0.01)
			local base_value = base
			local mod_value = base / mod - base_value
			local skill_value = base / mod / skill - base_value - mod_value + managers.player:upgrade_value("player", "damage_shake_addend", 0)
			base_stats[stat.name] = { value = (base_value + mod_value) * tweak_data.gui.stats_present_multiplier }
			skill_stats[stat.name] = { value = skill_value * tweak_data.gui.stats_present_multiplier }

		elseif stat.name == "stamina" then
			local skill = managers.player:body_armor_regen_multiplier()
			local base_value = Global.CrimDawn.tables.etc.regen_time[upgrade_level]
			local skill_value = base_value * skill
			base_stats[stat.name] = { value = base_value }
			skill_stats[stat.name] = { value = skill_value - base_value }
		end

		skill_stats[stat.name].skill_in_effect = skill_stats[stat.name].skill_in_effect or skill_stats[stat.name].value ~= 0
	end

	if managers.player:has_category_upgrade("player", "armor_to_health_conversion") then
		local conversion_ratio = managers.player:upgrade_value("player", "armor_to_health_conversion") * 0.01
		local converted_armor = (base_stats.armor.value + skill_stats.armor.value) * conversion_ratio
		local skill_in_effect = converted_armor ~= 0
		skill_stats.armor.value = skill_stats.armor.value - converted_armor
		skill_stats.health.value = skill_stats.health.value + converted_armor
		skill_stats.armor.skill_in_effect = skill_in_effect
		skill_stats.health.skill_in_effect = skill_in_effect
	end

	return base_stats, mods_stats, skill_stats
end)