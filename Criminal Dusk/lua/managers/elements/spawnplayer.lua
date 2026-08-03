Hooks:PreHook(ElementPlayerSpawner, "on_executed", "CrimDusk_PlayerSpawnerHijack", function(self)
  if not Global.CrimDusk.UnmaskedHeists[managers.job:current_level_id()] then return end
  if self._values.state == "standard" then self._values.state = "mask_off" end
end)