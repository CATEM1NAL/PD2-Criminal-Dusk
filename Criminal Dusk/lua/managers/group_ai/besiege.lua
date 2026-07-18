Hooks:OverrideFunction(GroupAIStateBesiege, "_check_phalanx_damage_reduction_increase", function() return end)
Hooks:OverrideFunction(GroupAIStateBesiege, "set_phalanx_damage_reduction_buff", function() return end)
Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_enable", function() managers.hud:set_buff_enabled("vip", true) end)
Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_disable", function() managers.hud:set_buff_enabled("vip", false) end)

Hooks:OverrideFunction(GroupAIStateBesiege, "_check_spawn_phalanx", function(self)
  local WintersCanSpawn = self._phalanx_center_pos and self._task_data and self._task_data.assault.active and not self._phalanx_spawn_group and self._task_data.assault.phase == "build"
  if not WintersCanSpawn or self._phalanx_despawn_time then return end

	local now = TimerManager:game():time()

	self._phalanx_current_spawn_chance = self._phalanx_current_spawn_chance or tweak_data.group_ai.phalanx.spawn_chance.start
	self._phalanx_last_spawn_check = self._phalanx_last_spawn_check or now

	if self._phalanx_current_spawn_chance > 0 then
		local SpawnInterval = tweak_data.group_ai.phalanx.check_spawn_intervall

		if now >= self._phalanx_last_spawn_check + SpawnInterval then
			self._phalanx_last_spawn_check = now

			if math.random() <= self._phalanx_current_spawn_chance then self:_spawn_phalanx() end
		end
	end
end)

Hooks:PreHook(GroupAIStateBesiege, "_end_regroup_task", "CrimDusk_GroupAIAssaultEnd", function(self)
  if self._phalanx_despawn_time or self._phalanx_current_spawn_chance == 1 then return end

  local WintersChance = tweak_data.group_ai.phalanx.spawn_chance.start
  local WintersChanceIncrease = tweak_data.group_ai.phalanx.spawn_chance.increase
  local WintersChanceMax = tweak_data.group_ai.phalanx.spawn_chance.max

  self._phalanx_current_spawn_chance = math.min((self._phalanx_current_spawn_chance or WintersChance) + WintersChanceIncrease, WintersChanceMax)
end)