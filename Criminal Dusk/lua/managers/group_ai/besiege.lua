local FileIdent = "GroupAIBesiege"

Hooks:OverrideFunction(GroupAIStateBesiege, "_check_phalanx_damage_reduction_increase", function() return end)
Hooks:OverrideFunction(GroupAIStateBesiege, "set_phalanx_damage_reduction_buff", function() return end)
Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_enable", function() managers.hud:set_buff_enabled("vip", true) end)
Hooks:OverrideFunction(GroupAIStateBesiege, "phalanx_damage_reduction_disable", function() managers.hud:set_buff_enabled("vip", false) end)

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

    -- Success! Assign a spawn timer
    CrimDusk.Log(FileIdent, "Winters is spawning!")
    local BuildDuration = tweak_data.group_ai.besiege.assault.build_duration
    local LowerBound = math.max(BuildDuration - 15, 0)
    self._phalanx_spawn_timer = TimerManager:game():time() + math.random(LowerBound, BuildDuration)
  end
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
