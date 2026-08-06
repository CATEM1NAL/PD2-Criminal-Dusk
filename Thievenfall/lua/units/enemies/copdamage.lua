Hooks:OverrideFunction(CopDamage, "_dismember_condition", function(self, attack_data)
  local dismember_victim = false
  local target_is_spook = false

  if alive(attack_data.col_ray.unit) and attack_data.col_ray.unit:base() then
    target_is_spook = attack_data.col_ray.unit:base()._tweak_table == "spooc"
  end

  local ValidMelee = tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].dismember
  if target_is_spook and ValidMelee then dismember_victim = true end
  return dismember_victim
end)

Hooks:OverrideFunction(CopDamage, "_check_special_death_conditions", function(self, variant, body, _, weapon_unit)
  local special_deaths = self._unit:base():char_tweak().special_deaths
  if not special_deaths or not special_deaths[variant] then return end

  local body_data = special_deaths[variant][body:name():key()]
  if not body_data then return end

  if alive(weapon_unit) then
    local factory_id = weapon_unit:base()._factory_id
    if not factory_id then return end

    if weapon_unit:base():is_npc() then factory_id = utf8.sub(factory_id, 1, -5) end

    local weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
    if body_data.weapon_id == weapon_id then
      if self._unit:damage():has_sequence(body_data.sequence) then self._unit:damage():run_sequence_simple(body_data.sequence) end
      if body_data.special_comment then return body_data.special_comment end
    end
  end
end)