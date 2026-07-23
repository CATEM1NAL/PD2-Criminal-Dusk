local FileIdent = "GroupAIBesiege"

Hooks:OverrideFunction(GroupAIStateBesiege, "_check_phalanx_damage_reduction_increase", function() return end)
Hooks:OverrideFunction(GroupAIStateBesiege, "set_phalanx_damage_reduction_buff", function() return end)
Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_enable", function() managers.hud:set_buff_enabled("vip", true) end)
Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_disable", function() managers.hud:set_buff_enabled("vip", false) end)

Hooks:OverrideFunction(GroupAIStateBesiege, "_check_spawn_phalanx", function(self)
  self._phalanx_current_spawn_chance = self._phalanx_current_spawn_chance or tweak_data.group_ai.phalanx.spawn_chance.start
  local now = TimerManager:game():time()

  -- Should we should try spawning Winters?
  local AssaultBegun = self._task_data and self._task_data.assault.active and self._task_data.assault.phase == "build"
  local IsWintersValid = self._phalanx_center_pos and not self._phalanx_spawn_group and not self._phalanx_despawn_time
  local SpawnConditionsMet = not self._phalanx_spawn_attempted and self._phalanx_current_spawn_chance > 0

  local WintersCanSpawn = AssaultBegun and IsWintersValid and SpawnConditionsMet
  if not WintersCanSpawn then return

  -- Winters has already been given the go-ahead. Is now the time?
  elseif self._phalanx_spawn_timer and now >= self._phalanx_spawn_timer then self:_spawn_phalanx() return end

  -- Winters is allowed to spawn but hasn't spawned yet
  self._phalanx_spawn_attempted = true
  CrimDusk.Log(FileIdent, "Winters spawn chance: " .. self._phalanx_current_spawn_chance * 100 .. "%")
  if math.random() > self._phalanx_current_spawn_chance then return end

  -- Spawn successful! Give the go-ahead and start a timer
  CrimDusk.Log(FileIdent, "Winters is spawning!")
  local BuildDuration = tweak_data.group_ai.besiege.assault.build_duration
  self._phalanx_spawn_timer = now + math.random(20, BuildDuration)
end)

Hooks:PreHook(GroupAIStateBesiege, "_end_regroup_task", "CrimDusk_GroupAIAssaultEnd", function(self)
  -- Increase Winters spawn chance on assault end
  if not self._phalanx_center_pos or self._phalanx_despawn_time or self._phalanx_current_spawn_chance == 1 then return end

  local WintersChance = tweak_data.group_ai.phalanx.spawn_chance.start
  local WintersChanceIncrease = tweak_data.group_ai.phalanx.spawn_chance.increase
  local WintersChanceMax = tweak_data.group_ai.phalanx.spawn_chance.max

  self._phalanx_current_spawn_chance = math.min((self._phalanx_current_spawn_chance or WintersChance) + WintersChanceIncrease, WintersChanceMax)
  self._phalanx_spawn_attempted = false -- Reset to attempt spawn on next assault
  CrimDusk.Log(FileIdent, "Increasing Winters spawn chance! Now " .. self._phalanx_current_spawn_chance * 100 .. "%")
end)

Hooks:PreHook(GroupAIStateBesiege, "_spawn_phalanx", "CrimDusk_GroupAISpawnPhalanx", function(self) self._phalanx_spawn_timer = false end)