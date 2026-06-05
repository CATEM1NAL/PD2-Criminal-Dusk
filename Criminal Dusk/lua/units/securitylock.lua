Hooks:PostHook(SecurityLockGui, "_start", "CrimDawn_StartSecurityLockGUI", function(self, _, timer)
  local TimerMult = 1

  self._timer = self._timer * TimerMult
  self._current_timer = self._current_timer * TimerMult
end)