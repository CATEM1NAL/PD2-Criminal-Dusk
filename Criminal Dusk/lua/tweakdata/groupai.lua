Hooks:PostHook(GroupAITweakData, "_init_task_data", "CrimDusk_InitGroupAITaskData", function(self, difficulty)
  local FlashbangTimer = { 4, 3.5, 3, 2.5, 2, 1.5, 1 }
  local FlashbangRange = { 1000, 1000, 900, 800, 700, 600, 500 }
  self.flash_grenade.timer = FlashbangTimer[difficulty - 1]
  self.flash_grenade.range = FlashbangRange[difficulty - 1]

  self.besiege.assault.sustain_duration_min = { 30, 90, 120 }
  self.besiege.assault.sustain_duration_max = { 60, 120, 180 }
  self.besiege.assault.sustain_duration_balance_mul = { 1, 1.2, 1.4, 1.6 }

  self.besiege.assault.force = { 10, 12, 14 }
  self.besiege.assault.force_pool = { 50, 100, 100 }
  self.besiege.assault.delay = { 60, 60, 45 }
  self.besiege.assault.hostage_hesitation_delay = { 0, 0, 15 }

  self.besiege.assault.force_balance_mul = { 1, 2, 3, 4 }
  self.besiege.assault.force_pool_balance_mul = { 1, 2, 3, 4 }

  if difficulty >= 6 then self.phalanx.spawn_chance = { start = 0, increase = 0.25, max = 1, decrease = 1, respawn_delay = 120 }
  else self.phalanx.spawn_chance = { start = 0, increase = 0, max = 0, decrease = 0, respawn_delay = 120 } end

  self.phalanx.check_spawn_intervall = 10
  self.phalanx.vip.damage_reduction = { start = 0, increase = 0, max = 0, increase_intervall = 5 }
end)