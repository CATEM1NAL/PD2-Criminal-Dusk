local FileIdent = "PlayerDamage"

-- Setup new values
Hooks:PostHook(PlayerDamage, "init", "CrimDawn_InitPlayerDamage", function(self)
  self._dodge_stack = 0
  self._entropy = 0
  self._entropy_mult = 1
  self._armor_broken = false
  self._armor_break_t = managers.player:player_timer():time() + 3
end)

-- Regen time varies with armour
Hooks:OverrideFunction(PlayerDamage, "set_regenerate_timer_to_max", function(self)
  local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
  local armour = tonumber(managers.blackmarket:equipped_armor(true, true):sub(-1))
  self._regenerate_timer = Global.CrimDawn.tables.etc.regen_time[armour] * mul
  self._regenerate_timer = self._regenerate_timer * managers.player:upgrade_value("player", "armor_regen_time_mul", 1)
  self._regenerate_speed = self._regenerate_speed or 1
  self._current_state = self._update_regenerate_timer
end)

-- Suppression changes
Hooks:OverrideFunction(PlayerDamage, "build_suppression", function(self, amount)
  local armour = tonumber(managers.blackmarket:equipped_armor(true, true):sub(-1))
  if armour > 4 then return end -- Flak/CTV/ICTV are unaffected

	amount = amount * managers.player:upgrade_value("player", "suppressed_multiplier", 1)
	amount = amount * tweak_data.player.suppression.receive_mul

  local data = self._supperssion_data
	data.value = math.min(tweak_data.player.suppression.max_value, (data.value or 0) + amount * tweak_data.player.suppression.receive_mul)
	data.decay_start_t = managers.player:player_timer():time() + tweak_data.player.suppression.decay_start_delay
end)

-- Regenerating armour resets armour break flag
Hooks:PostHook(PlayerDamage, "_regenerate_armor", "CrimDawn_PlayerRegenerateArmour", function(self)
  self._armor_broken = false
end)

-- Tooth & Claw regens at twice the speed, instead of fixed 1.5s
Hooks:OverrideFunction(PlayerDamage, "_start_regen_on_the_side", function(self, time)
  local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
  local armour = tonumber(managers.blackmarket:equipped_armor(true, true):sub(7))
  if self._regen_on_the_side_timer <= 0 and time > 0 then
    self._regen_on_the_side_timer = Global.CrimDawn.tables.etc.regen_time[armour] * math.max(mul / 2, 1.5)
    self._regen_on_the_side = true
  end
end)

-- Gaining lives and health
Hooks:OverrideFunction(PlayerDamage, "_regenerated", function(self, no_messiah)
  self:set_health(self:_max_health())
  self:_send_set_health()
  self:_set_health_effect()
  self._said_hurt = false

  if not no_messiah then
    self._messiah_charges = managers.player:upgrade_value("player", "pistol_revive_from_bleed_out", 0)
  end

  -- Initial lives (start of heist)
  local MaxLives = self._lives_init + managers.player:upgrade_value("player", "additional_lives", 0)
  if Application:digest_value(self._revives, false) == 0 and not CrimDawn.lives then
    self._revives = Application:digest_value(MaxLives, true)
    managers.environment_controller:set_last_life(false)

  -- Traded from custody
  elseif CrimDawn.lives == -1 then
    self._revives = Application:digest_value(1, true)
    managers.environment_controller:set_last_life(true)

  -- Doctor bag
  else local NewDowns = Application:digest_value(self._revives, false) + 1
    self._revives = Application:digest_value(math.min(NewDowns, MaxLives), true)
    managers.environment_controller:set_last_life(false)
  end

  self:_send_set_revives()
  self._revive_health_i = 1
  self._down_time = tweak_data.player.damage.DOWNED_TIME
end)

-- This bad boy can fit so many changes
Hooks:OverrideFunction(PlayerDamage, "damage_bullet", function(self, attack_data)
  if not self:_chk_can_take_dmg() then return end

	local damage_info = {
		result = { variant = "bullet", type = "hurt" },
		attacker_unit = attack_data.attacker_unit,
		attack_dir = attack_data.attacker_unit and attack_data.attacker_unit:movement():m_pos() - self._unit:movement():m_pos() or Vector3(1, 0, 0),
		pos = mvector3.copy(self._unit:movement():m_head_pos())
	}

	local pm = managers.player
	local dmg_mul = pm:damage_reduction_skill_multiplier("bullet")
	attack_data.damage = attack_data.damage * dmg_mul
	attack_data.damage = managers.mutators:modify_value("PlayerDamage:TakeDamageBullet", attack_data.damage)
	attack_data.damage = managers.modifiers:modify_value("PlayerDamage:TakeDamageBullet", attack_data.damage, attack_data.attacker_unit:base()._tweak_table)

	if _G.IS_VR then
		local distance = mvector3.distance(self._unit:position(), attack_data.attacker_unit:position())

		if tweak_data.vr.long_range_damage_reduction_distance[1] < distance then
			local step = math.clamp(distance / tweak_data.vr.long_range_damage_reduction_distance[2], 0, 1)
			local mul = 1 - math.step(tweak_data.vr.long_range_damage_reduction[1], tweak_data.vr.long_range_damage_reduction[2], step)
			attack_data.damage = attack_data.damage * mul
		end
	end

	local damage_absorption = pm:damage_absorption()
	if damage_absorption > 0 then attack_data.damage = attack_data.damage - damage_absorption end
  attack_data.damage = math.max(attack_data.damage, 0.1)

	self:copr_update_attack_data(attack_data)
  --log("Armour broken: " .. tostring(self._armor_broken) .. "\nImmunity expires at: " .. self._armor_break_t .. "\nCurrent time: " .. managers.player:player_timer():time())
	if self._god_mode then
		if attack_data.damage > 0 then self:_send_damage_drama(attack_data, attack_data.damage) end
    self:_call_listeners(damage_info)
    return
	elseif self._invulnerable or self._mission_damage_blockers.invulnerable then self:_call_listeners(damage_info) return
	elseif self:incapacitated() then return
	elseif self:is_friendly_fire(attack_data.attacker_unit) then return
	elseif pm:player_timer():time() < self._armor_break_t then return
	elseif self._unit:movement():current_state().immortal then return
	elseif self._revive_miss and math.random() < self._revive_miss then self:play_whizby(attack_data.col_ray.position) return
	end

	local dodge_value = self._dodge_stack or 0
	local armor_dodge_chance = pm:body_armor_value("dodge")
	local skill_dodge_chance = pm:skill_dodge_chance(self._unit:movement():running(), self._unit:movement():crouching(), self._unit:movement():zipline_unit())
	dodge_value = dodge_value + armor_dodge_chance + skill_dodge_chance - (0.05 * self._entropy * self._entropy_mult)
	--log("base dodge: " .. dodge_value + armor_dodge_chance + skill_dodge_chance)
	--log("entropy: " .. 0.05 * self._entropy * self._entropy_mult)
	--log("final dodge: " .. dodge_value)

	if self._temporary_dodge_t and TimerManager:game():time() < self._temporary_dodge_t then
	  dodge_value = dodge_value + self._temporary_dodge
	end

	local smoke_dodge = 0
	for _, smoke_screen in ipairs(managers.player._smoke_screen_effects or {}) do
		if smoke_screen:is_in_smoke(self._unit) then
			dodge_value = math.max(dodge_value, 0) + tweak_data.projectiles.smoke_screen_grenade.dodge_chance
		break end
	end

	if dodge_value >= 1 then
	  --log(dodge_value .. " we dodged! Yippee!")
	  self._dodge_stack = dodge_value - 1
	  self._entropy = self._entropy + 1
		if attack_data.damage > 0 then self:_send_damage_drama(attack_data, 0) end

		self:_call_listeners(damage_info)
		self:play_whizby(attack_data.col_ray.position)
		self:_hit_direction(attack_data.attacker_unit:position(), attack_data.col_ray and attack_data.col_ray.ray or damage_info.attacK_dir)

		pm:send_message(Message.OnPlayerDodge, nil, attack_data)
	return end

  self._dodge_stack = dodge_value
  self._entropy = 0
  --log(dodge_value .. " dodge failed :(")

	if self:get_real_armor() > 0 then self._unit:sound():play("player_hit")
	else self._unit:sound():play("player_hit_permadamage") end

	local shake_armor_multiplier = pm:body_armor_value("damage_shake") * pm:upgrade_value("player", "damage_shake_multiplier", 1)
	local gui_shake_number = tweak_data.gui.armor_damage_shake_base / shake_armor_multiplier
	gui_shake_number = gui_shake_number + pm:upgrade_value("player", "damage_shake_addend", 0)
	shake_armor_multiplier = tweak_data.gui.armor_damage_shake_base / gui_shake_number
	local shake_multiplier = math.clamp(attack_data.damage, 0.2, 2) * shake_armor_multiplier

	self._unit:camera():play_shaker("player_bullet_damage", 1 * shake_multiplier)

	if not _G.IS_VR then managers.rumble:play("damage_bullet") end

	self:_hit_direction(attack_data.attacker_unit:position(), attack_data.col_ray and attack_data.col_ray.ray or damage_info.attacK_dir)
	pm:check_damage_carry(attack_data)

	attack_data.damage = pm:modify_value("damage_taken", attack_data.damage, attack_data)

	if self._bleed_out then self:_bleed_out_damage(attack_data) return end

	self:mutator_update_attack_data(attack_data)
	self:_check_chico_heal(attack_data)

	local armor_reduction_multiplier = 0
	if self:get_real_armor() <= 0 then armor_reduction_multiplier = 1 end

	local health_subtracted = self:_calc_armor_damage(attack_data)
	attack_data.damage = attack_data.damage * armor_reduction_multiplier
	health_subtracted = health_subtracted + self:_calc_health_damage(attack_data)

  if self:get_real_armor() <= 0 and not self._armor_broken then
    self._armor_break_t = pm:player_timer():time() + self._dmg_interval
    self._armor_broken = true
	end

	if not self._bleed_out and health_subtracted > 0 then self:_send_damage_drama(attack_data, health_subtracted)
	elseif self._bleed_out then self:chk_queue_taunt_line(attack_data) end

	pm:send_message(Message.OnPlayerDamage, nil, attack_data)
	self:_call_listeners(damage_info)
end)

-- Custody
Hooks:PreHook(PlayerDamage, "pre_destroy", "CrimDawn_DamageCustody", function(self)
  if Utils:IsInCustody() then
    CrimDawn.lives = -1
    CrimDawn.Log(FileIdent, "Taken into custody!")
  end
end)

-- Update stored lives
Hooks:PreHook(PlayerDamage, "_send_set_revives", "CrimDawn_SendSetRevives", function(self)
  CrimDawn.lives = Application:digest_value(self._revives, false) - 1
  CrimDawn.Log(FileIdent, "Lives remaining: " .. CrimDawn.lives)
end)