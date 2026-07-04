Hooks:OverrideFunction(NewRaycastWeaponBase, "calculate_ammo_max_per_clip", function(self)
  local ammo = tweak_data.weapon[self._name_id].CLIP_AMMO_MAX
  ammo = ammo + (self._extra_ammo or 0)
  ammo = ammo * (1 + managers.player:upgrade_value("weapon", "clip_ammo_increase", 0))

  return math.floor(ammo)
end)