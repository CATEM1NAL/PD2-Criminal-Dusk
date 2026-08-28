local FileIdent = "CopDamage"

if NetworkHelper:IsHost() then -- Special characters stay dead for rest of campaign
  Hooks:PreHook(CopDamage, "die", "CrimDusk_PreCopDie", function(self)
    local enemy = self._unit:base()._tweak_table

    if enemy == "phalanx_vip" then
      Global.CrimDusk.data["winters_dead" .. CrimDusk.IsPermadeath()] = true
      CrimDusk:WriteSave(FileIdent, "Winters killed")

    elseif enemy == "hector_boss" or enemy == "hector_boss_no_armor" then
      Global.CrimDusk.data["hector_dead" .. CrimDusk.IsPermadeath()] = true
      CrimDusk:WriteSave(FileIdent, "Hector killed")
    end
  end)
end

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

Hooks:OverrideFunction(CopDamage, "_sync_dismember", function(self, attacker_unit)
  local dismember_victim = false
  if not attacker_unit then return dismember_victim end

  local peer_id = managers.network:session():peer_by_unit(attacker_unit):id()
  local peer = managers.network:session():peer(peer_id)
  local ValidMelee = tweak_data.blackmarket.melee_weapons[peer:melee_id()].dismember

  if ValidMelee then dismember_victim = true end
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
    local DmgMult = tweak_data.weapon[weapon_id].stats_modifiers and tweak_data.weapon[weapon_id].stats_modifiers.damage or 1
    if 100 <= (tweak_data.weapon[weapon_id].stats.damage * DmgMult) then
      if self._unit:damage():has_sequence(body_data.sequence) then self._unit:damage():run_sequence_simple(body_data.sequence) end
      if body_data.special_comment then return body_data.special_comment end
    end
  end
end)