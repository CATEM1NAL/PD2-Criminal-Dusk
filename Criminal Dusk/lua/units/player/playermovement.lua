Hooks:OverrideFunction(PlayerMovement, "subtract_stamina", function() end)

Hooks:PostHook(PlayerMovement, "init", "CrimDusk_InitPlayerMovement", function(self)
  self._underdog_skill_data.max_dis_sq = 1000000 -- 10m radius for Underdog
end)