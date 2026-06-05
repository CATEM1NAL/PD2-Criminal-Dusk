local function SetStats(self)
  -- Health (vanilla OVK)
	self.swat_van_turret_module.HEALTH_INIT = 25000
	self.swat_van_turret_module.SHIELD_HEALTH_INIT = 500
	self.ceiling_turret_module.HEALTH_INIT = 12500
	self.ceiling_turret_module.SHIELD_HEALTH_INIT = 250
	self.aa_turret_module.HEALTH_INIT = 26000
	self.aa_turret_module.SHIELD_HEALTH_INIT = 500
	self.crate_turret_module.HEALTH_INIT = 12500
	self.crate_turret_module.SHIELD_HEALTH_INIT = 500

  -- Damage (vanilla Hard)
  self.ak47_ass_npc.DAMAGE = 0.4
  self.m4_npc.DAMAGE = 0.4
	self.m4_yellow_npc.DAMAGE = 0.4
	self.g36_npc.DAMAGE = 0.6
	self.r870_npc.DAMAGE = 1
	self.smoke_npc.DAMAGE = 0.6

  -- Turret damage adjustments
	self.swat_van_turret_module.DAMAGE = 0.05
	self.ceiling_turret_module.DAMAGE = 0.05
	self.aa_turret_module.DAMAGE = 0.05
	self.crate_turret_module.DAMAGE = 0.05

  -- Dozers
  self.mossberg_npc.DAMAGE = 2
  self.saiga_npc.DAMAGE = 1
	self.m249_npc.DAMAGE = 0.25
	self.mini_npc.DAMAGE = 0.1

  -- Bosses
  self.hk21_npc.DAMAGE = 0.5
  self.contraband_npc.DAMAGE = 0.6
  self.flamethrower_npc.DAMAGE = 0.05

  -- Other damage adjustments
  self.npc_melee.baton.damage = 5
  self.npc_melee.knife_1.damage = 10
  self.npc_melee.fists.damage = 2.5
  self.c45_npc.DAMAGE = 0.5
  self.raging_bull_npc.DAMAGE = 2.5
  self.mp5_npc.DAMAGE = 0.25
  self.mac11_npc.DAMAGE = 0.25
  self.mp9_npc.DAMAGE = 0.25
  self.m14_npc.DAMAGE = 2.5
  self.s552_npc.DAMAGE = 0.6
  self.scar_npc.DAMAGE = 1

  self.m14_sniper_npc.trail = "effects/particles/weapons/sniper_trail"
  self.svd_snp_npc.trail = "effects/particles/weapons/sniper_trail"
  self.svdsil_snp_npc.trail = "effects/particles/weapons/sniper_trail"
  self.heavy_snp_npc.trail = "effects/particles/weapons/sniper_trail_marshal"
end

Hooks:OverrideFunction(WeaponTweakData, "_set_normal", function(self) SetStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_hard", function(self) SetStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_overkill", function(self) SetStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_overkill_145", function(self) SetStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_easy_wish", function(self) SetStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_overkill_290", function(self) SetStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_sm_wish", function(self) SetStats(self) end)