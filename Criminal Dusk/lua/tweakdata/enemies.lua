local function SetStats(self, diff)
  local flashbang_mult = { 1, 1.25, 1.5, 1.75, 2, 2.5, 3 }
  local weapon_preset = { "normal", "normal", "good", "good", "expert", "expert", "deathwish" }
  local cloaker_cooldown = {
    {10, 10}, {8, 10}, {6, 8}, {4, 6}, {3, 4}, {2, 3}, {0, 1}
  }

  -- HP (Vanilla OVK)
  self:_multiply_all_hp(3, 1)

  self.hector_boss.HEALTH_INIT = 600
  self.mobster_boss.HEALTH_INIT = 600
  self.biker_boss.HEALTH_INIT = 1800
  self.chavez_boss.HEALTH_INIT = 600
  self.phalanx_minion.HEALTH_INIT = 300
  self.phalanx_minion.DAMAGE_CLAMP_BULLET = 30
  self.phalanx_minion.DAMAGE_CLAMP_EXPLOSION = self.phalanx_minion.DAMAGE_CLAMP_BULLET
  self.phalanx_vip.HEALTH_INIT = 600
  self.phalanx_vip.DAMAGE_CLAMP_BULLET = 60
  self.phalanx_vip.DAMAGE_CLAMP_EXPLOSION = self.phalanx_vip.DAMAGE_CLAMP_BULLET
  self.presets.gang_member_damage.REGENERATE_TIME = 2
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 0.6
	self.presets.gang_member_damage.HEALTH_INIT = 400
	self.presets.gang_member_damage.BLEED_OUT_HEALTH_INIT = self.presets.gang_member_damage.HEALTH_INIT * 0.1

  -- Custom HP values
  local WeakEnemies = {
    "security", "security_undominatable", "mute_security_undominatable", "security_mex", "security_mex_no_pager",
    "fbi", "fbi_female", "gensec", "cop", "cop_scared", "cop_female", "gangster", "biker", "biker_female", "triad",
    "captain", "captain_female", "biker_escape", "mobster", "hector_boss_no_armor", "bolivian_indoors_mex", "bolivian"
  }
  local HeavyEnemies = { "medic", "marshal_marksman", "taser", "shield" }
  for _, enemy in ipairs(WeakEnemies) do self[enemy].HEALTH_INIT = 8 end
  for _, enemy in ipairs(HeavyEnemies) do self[enemy].HEALTH_INIT = 48 end
  self.spooc.HEALTH_INIT = 90
  self.spooc.headshot_dmg_mul = 10

  -- Damage fall-off (based on vanilla OVK/Mayhem)
  local expert = self.presets.weapon.expert
  local skip = { expert = true, gang_member = true, sniper = true, bot_weapons = true }
  for preset, preset_data in pairs(self.presets.weapon) do
    if not skip[preset] then
      for weapon_name, weapon_data in pairs(preset_data) do
        if weapon_data.FALLOFF and expert[weapon_name].FALLOFF then
          weapon_data.FALLOFF = expert[weapon_name].FALLOFF
        end
      end
    end
  end

  self:_set_characters_weapon_preset(weapon_preset[diff])
  self:_multiply_weapon_delay(self.presets.weapon.sniper, 3)
  self.marshal_marksman.weapon.is_rifle.focus_delay = 3

  self.hector_boss.weapon.is_shotgun_mag.FALLOFF = {
		{
			dmg_mul = 2.2, r = 200, acc = { 0.6, 0.9 }, recoil = { 0.4, 0.7 }, mode = { 0, 1, 2, 1 }
		},
		{
			dmg_mul = 1.75, r = 500, acc = { 0.6, 0.9 }, recoil = { 0.4, 0.7 }, mode = { 0, 3, 3, 1 }
		},
		{
			dmg_mul = 1.5, r = 1000, acc = { 0.4, 0.8 }, recoil = { 0.45, 0.8 }, mode = { 1, 2, 2, 0 }
		},
		{
			dmg_mul = 1.25, r = 2000, acc = { 0.4, 0.55 }, recoil = { 0.45, 0.8 }, mode = { 3, 2, 2, 0 }
		},
		{
			dmg_mul = 1, r = 3000, acc = { 0.1, 0.35 }, recoil = { 1, 1.2 }, mode = { 3, 1, 1, 0 }
		}
	}

  if diff > 4 then self.sniper.weapon.is_rifle.use_laser = false end
  self.sniper.weapon.is_rifle.FALLOFF = {
		{
		  dmg_mul = 10, r = 700, acc = { 0.7, 1 }, recoil = { 3, 5 }, mode = { 1, 0, 0, 0 }
		},
		{
			dmg_mul = 10, r = 4000, acc = { 0.6, 0.95 }, recoil = { 3, 5 }, mode = { 1, 0, 0, 0 }
		},
		{
			dmg_mul = 6, r = 10000, acc = { 0.2, 0.5 }, recoil = { 3, 5 }, mode = { 1, 0, 0, 0 }
		}
	}

  -- Finalization
  self.spooc.spooc_attack_timeout = cloaker_cooldown[diff]
  self.spooc.spooc_attack_beating_time[1] = cloaker_cooldown[diff][1]
  self.spooc.spooc_attack_beating_time[2] = cloaker_cooldown[diff][1]

  for _, npc in pairs(self) do -- Enemies can't move bags
    if type(npc) == "table" and npc.steal_loot then npc.steal_loot = nil end
  end

  self.flashbang_multiplier = flashbang_mult[diff]
  self.concussion_multiplier = 1

	self:_process_weapon_usage_table()
end

Hooks:OverrideFunction(CharacterTweakData, "_set_normal", function(self) SetStats(self, 1) end)
Hooks:OverrideFunction(CharacterTweakData, "_set_hard", function(self) SetStats(self, 2) end)
Hooks:OverrideFunction(CharacterTweakData, "_set_overkill", function(self) SetStats(self, 3) end)
Hooks:OverrideFunction(CharacterTweakData, "_set_overkill_145", function(self) SetStats(self, 4) end)
Hooks:OverrideFunction(CharacterTweakData, "_set_easy_wish", function(self) SetStats(self, 5) end)
Hooks:OverrideFunction(CharacterTweakData, "_set_overkill_290", function(self) SetStats(self, 6) end)
Hooks:OverrideFunction(CharacterTweakData, "_set_sm_wish", function(self) SetStats(self, 7) end)