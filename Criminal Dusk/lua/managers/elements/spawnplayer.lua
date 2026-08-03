Hooks:PreHook(ElementPlayerSpawner, "on_executed", "CrimDusk_PlayerSpawnerHijack", function(self)
  local level = managers.job:current_level_id()

  -- Set maskup prompt according to whether heist is stealthable
  if Global.CrimDusk.StealthableHeists[level] then managers.localization:add_localized_strings({ ["hud_instruct_mask_on"] = managers.localization:text("crimdusk_mask_on_stealth") })
  else managers.localization:add_localized_strings({ ["hud_instruct_mask_on"] = managers.localization:text("crimdusk_mask_on_loud") }) end

  -- Set spawns to casing mode if needed
  if not Global.CrimDusk.UnmaskedHeists[level] then return end
  if self._values.state == "standard" then self._values.state = "mask_off" end
end)