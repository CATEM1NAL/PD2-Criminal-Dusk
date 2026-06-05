Hooks:PostHook(GroupAITweakData, "_init_task_data", "CrimDawn_InitGroupAITaskData", function(self)
  self.besiege.assault.force = { 10, 12, 14 }
  self.besiege.assault.force_pool = { 50, 100, 200 }
  self.besiege.assault.delay = { 60, 60, 45 }
  self.besiege.assault.hostage_hesitation_delay = { 0, 0, 15 }
end)