if managers.job and managers.job:current_level_id() == "chill" then return end

Hooks:PreHook(ElementSpawnCivilian, "on_executed", "CrimDusk_DisableSafehouseCharacters", function(self)
  local EnabledState = self._values.enabled
  if self._editor_name == "hoxton" and (Global.CrimDusk.data["heists_won" .. CrimDusk.IsPermadeath()] > 4 and Global.CrimDusk.data.free_hoxton < 4) then
    self._values.enabled = false

  elseif self._editor_name == "rust" and not Global.CrimDusk.data["rust_recruited" .. CrimDusk.IsPermadeath()] then
    self._values.enabled = false
  end
end)