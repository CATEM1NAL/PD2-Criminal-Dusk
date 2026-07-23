Hooks:PostHook(GroupAITweakData, "_init_task_data", "CrimDusk_InitGroupAITaskData", function(self, difficulty)
  -- Flashbang adjustments
  local FlashbangTimer = { 5, 4.5, 4, 3.5, 3, 2.5, 2 }
  local FlashbangRange = { 1000, 950, 900, 850, 800, 750, 700 }
  self.flash_grenade.timer = FlashbangTimer[difficulty - 1]
  self.flash_grenade.range = FlashbangRange[difficulty - 1]

  -- Assault parameters
  self.besiege.assault.sustain_duration_min = { 30, 90, 120 }
  self.besiege.assault.sustain_duration_max = { 60, 120, 180 }
  self.besiege.assault.sustain_duration_balance_mul = { 1, 1.2, 1.4, 1.6 }

  self.besiege.assault.force = { 10, 12, 14 }
  self.besiege.assault.force_pool = { 50, 100, 100 }
  self.besiege.assault.delay = { 60, 60, 30 }
  self.besiege.assault.hostage_hesitation_delay = { 15, 10, 5 }

  self.besiege.assault.force_balance_mul = { 1, 2, 3, 4 }
  self.besiege.assault.force_pool_balance_mul = { 1, 2, 3, 4 }

  -- Winters rework
  if difficulty >= 6 then self.phalanx.spawn_chance = { start = 0, increase = 0.25, max = 1, decrease = 1, respawn_delay = 120 }
  else self.phalanx.spawn_chance = { start = 0, increase = 0, max = 0, decrease = 0, respawn_delay = 120 } end

  self.phalanx.check_spawn_intervall = 25
  self.phalanx.vip.damage_reduction = { start = 0, increase = 0, max = 0, increase_intervall = 5 }
end)