local FileIdent = "UpgradeHandler"

Hooks:OverrideFunction(PlayerManager, "verify_equipment", function() return true end)
Hooks:OverrideFunction(PlayerManager, "health_skill_multiplier", function() return 1 end)
Hooks:OverrideFunction(PlayerManager, "carry_blocked_by_cooldown", function() return false end)

Hooks:OverrideFunction(PlayerManager, "_dodge_replenish_armor", function(self)
  self:player_unit():character_damage():restore_health(0.02)
end)

Hooks:OverrideFunction(PlayerManager, "health_skill_addend", function(self)
	local addend = 0
	addend = addend + self:upgrade_value("team", "crew_add_health", 0)
	addend = addend - self:upgrade_value("player", "health_decrease", 0)

  -- Convert health multipliers to flat amount
  addend = addend + self:upgrade_value("player", "health_multiplier", 0)
	addend = addend + self:upgrade_value("player", "passive_health_multiplier", 0)
	addend = addend + self:upgrade_value("health", "passive_multiplier", 0)
  addend = addend + self:get_hostage_bonus_multiplier("health") - 1
	addend = addend + self:upgrade_value("player", "mrwi_health_multiplier", 0)

  if self:num_local_minions() > 0 then
		addend = addend + self:upgrade_value("player", "minion_master_health_multiplier", 0)
	end

  -- Max health can't go below 1
  if PlayerDamage._HEALTH_INIT + addend <= 0 then addend = -PlayerDamage._HEALTH_INIT + 0.1 end

	return addend
end)

Hooks:OverrideFunction(PlayerManager, "body_armor_skill_addend", function(self, override_armor)
  local addend = 0
	addend = addend + self:upgrade_value("player", tostring(override_armor or managers.blackmarket:equipped_armor(true, true)) .. "_armor_addend", 0)

	if self:has_category_upgrade("player", "armor_increase") then
	  local AnarchArmour = 5 * self:upgrade_value("player", "armor_increase", 1)
		addend = addend + AnarchArmour
	end

	addend = addend + self:upgrade_value("team", "crew_add_armor", 0)
	return addend
end)