local FileIdent = "GroupAIBesiege"

Hooks:OverrideFunction(GroupAIStateBesiege, "_check_phalanx_damage_reduction_increase", function() return end)
Hooks:OverrideFunction(GroupAIStateBesiege, "set_phalanx_damage_reduction_buff", function() return end)
Hooks:PreHook(GroupAIStateBesiege, "_spawn_phalanx", "CrimDusk_GroupAISpawnPhalanx", function(self) self._phalanx_spawn_timer = false end)

Hooks:OverrideFunction(GroupAIStateBesiege, "_check_spawn_phalanx", function(self)
  local AssaultBegun = self._task_data and self._task_data.assault.active and self._task_data.assault.phase == "build"
  local IsPhalanxValid = self._phalanx_center_pos and not self._phalanx_spawn_group and not self._phalanx_despawn_time and not self._phalanx_spawn_attempted
  local WintersCanSpawn = AssaultBegun and IsPhalanxValid

  if not WintersCanSpawn and not self._phalanx_spawn_timer then return

  elseif self._phalanx_spawn_timer and TimerManager:game():time() >= self._phalanx_spawn_timer then self:_spawn_phalanx() return

  elseif WintersCanSpawn then
    self._phalanx_current_spawn_chance = self._phalanx_current_spawn_chance or tweak_data.group_ai.phalanx.spawn_chance.start
    if self._phalanx_current_spawn_chance <= 0 then return end

    self._phalanx_spawn_attempted = true
    CrimDusk.Log(FileIdent, "Winters spawn chance: " .. self._phalanx_current_spawn_chance * 100 .. "%")

    if math.random() > self._phalanx_current_spawn_chance then return end

    CrimDusk.Log(FileIdent, "Winters is spawning!")
    local BuildDuration = tweak_data.group_ai.besiege.assault.build_duration
    local LowerBound = math.max(BuildDuration - 15, 0)
    self._phalanx_spawn_timer = TimerManager:game():time() + math.random(LowerBound, BuildDuration)
  end
end)

Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_enable", function()
  managers.hud:set_buff_enabled("vip", true)

  -- Enemies spawn 4x faster
  for _, CooldownData in pairs(tweak_data.group_ai.ai_spawn_group_cooldowns) do
    for _, range in ipairs(CooldownData) do
      for _, cooldown in ipairs(range) do cooldown = cooldown * 0.25 end
    end
  end

  -- Special spawn caps are doubled
  for _, SpawnCap in pairs(tweak_data.group_ai.special_unit_spawn_limits) do SpawnCap = SpawnCap * 2 end
end)

Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_disable", function()
  managers.hud:set_buff_enabled("vip", false)

  -- Revert enemy spawn speed
  for _, CooldownData in pairs(tweak_data.group_ai.ai_spawn_group_cooldowns) do
    for _, range in ipairs(CooldownData) do
      for _, cooldown in ipairs(range) do cooldown = cooldown * 4 end
    end
  end

  -- Revert special spawn cap
  for _, SpawnCap in pairs(tweak_data.group_ai.special_unit_spawn_limits) do SpawnCap = SpawnCap * 0.5 end
end)

Hooks:OverrideFunction(GroupAIStateBesiege, "_begin_assault_task", function(self, assault_areas)
  local assault_task = self._task_data.assault

  assault_task.active = true
  assault_task.next_dispatch_t = nil
  assault_task.target_areas = assault_areas
  assault_task.phase = "anticipation"
  assault_task.start_t = self._t

  local anticipation_duration = self:_get_anticipation_duration(self._tweak_data.assault.anticipation_duration, assault_task.is_first)

  assault_task.is_first = nil
  assault_task.phase_end_t = self._t + anticipation_duration
  assault_task.force = math.ceil(self:_get_difficulty_dependent_value(self._tweak_data.assault.force) * self:_get_balancing_multiplier(self._tweak_data.assault.force_balance_mul))
  assault_task.use_smoke = true
  assault_task.use_smoke_timer = 0
  assault_task.use_spawn_event = true
  assault_task.force_spawned = 0

  if self._hostage_headcount > 0 then
    local hostage_delay = math.min(self:_get_difficulty_dependent_value(self._tweak_data.assault.hostage_hesitation_delay) * self._hostage_headcount, 30)

    anticipation_duration = anticipation_duration + hostage_delay
    assault_task.phase_end_t = assault_task.phase_end_t + hostage_delay
    assault_task.is_hesitating = true
    assault_task.voice_delay = self._t + (assault_task.phase_end_t - self._t) / 2
  end

  self._downs_during_assault = 0

  if self._hunt_mode then assault_task.phase_end_t = 0

  else
    managers.hud:setup_anticipation(anticipation_duration)
    managers.hud:start_anticipation()
  end

  if self._draw_drama then table.insert(self._draw_drama.assault_hist, { self._t }) end

  self._task_data.recon.tasks = {}
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