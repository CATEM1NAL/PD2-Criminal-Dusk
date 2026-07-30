Hooks:OverrideFunction(PlayerMovement, "subtract_stamina", function() end)

Hooks:PostHook(PlayerMovement, "init", "CrimDusk_InitPlayerMovement", function(self)
  self._underdog_skill_data.max_dis_sq = 1000000 -- 10m radius for Underdog
end)

Hooks:OverrideFunction(PlayerMovement, "on_SPOOCed", function(self)
  if managers.player:has_category_upgrade("player", "counter_strike_spooc") and self._current_state.in_melee and self._current_state:in_melee() then
    self._current_state:discharge_melee()
    return "countered"
  end

  if self._unit:character_damage()._god_mode or self._unit:character_damage():get_mission_blocker("invulnerable") then return end

  if self._current_state_name == "standard" or self._current_state_name == "carry" or self._current_state_name == "bleed_out" or self._current_state_name == "tased" or self._current_state_name == "bipod" then
    managers.player:set_player_state("arrested")
    managers.achievment:award(tweak_data.achievement.finally.award)
    return true
  end
end)