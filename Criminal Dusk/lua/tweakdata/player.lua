Hooks:PostHook(PlayerTweakData, "init", "CrimDawn_InitPlayerTweakData", function(self)
  self.damage.HEALTH_INIT = 20
end)

Hooks:PostHook(PlayerTweakData, "_set_normal", "CrimDawn_PlayerSetDifficulty", function(self)
  self.damage.MIN_DAMAGE_INTERVAL = 2
  self.damage.REVIVE_HEALTH_STEPS = { 0.5 }
end)

Hooks:PostHook(PlayerTweakData, "_set_hard", "CrimDawn_PlayerSetDifficulty", function(self)
  self.damage.MIN_DAMAGE_INTERVAL = 1.5
end)

Hooks:PostHook(PlayerTweakData, "_set_overkill", "CrimDawn_PlayerSetDifficulty", function(self)
  self.damage.MIN_DAMAGE_INTERVAL = 1
  self.damage.REVIVE_HEALTH_STEPS = { 0.3 }
end)

Hooks:PostHook(PlayerTweakData, "_set_overkill_145", "CrimDawn_PlayerSetDifficulty", function(self)
  self.damage.MIN_DAMAGE_INTERVAL = 0.75
  self.damage.REVIVE_HEALTH_STEPS = { 0.25 }
end)

Hooks:PostHook(PlayerTweakData, "_set_easy_wish", "CrimDawn_PlayerSetDifficulty", function(self)
  self.damage.MIN_DAMAGE_INTERVAL = 0.5
  self.damage.REVIVE_HEALTH_STEPS = { 0.2 }
end)

Hooks:PostHook(PlayerTweakData, "_set_overkill_290", "CrimDawn_PlayerSetDifficulty", function(self)
  self.damage.MIN_DAMAGE_INTERVAL = 0.25
  self.damage.REVIVE_HEALTH_STEPS = { 0.15 }
end)

Hooks:PostHook(PlayerTweakData, "_set_sm_wish", "CrimDawn_PlayerSetDifficulty", function(self)
  self.damage.MIN_DAMAGE_INTERVAL = 0
  self.damage.REVIVE_HEALTH_STEPS = { 0.1 }
end)