local function SetAIStats(self)
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

Hooks:OverrideFunction(WeaponTweakData, "_set_normal", function(self) SetAIStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_hard", function(self) SetAIStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_overkill", function(self) SetAIStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_overkill_145", function(self) SetAIStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_easy_wish", function(self) SetAIStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_overkill_290", function(self) SetAIStats(self) end)
Hooks:OverrideFunction(WeaponTweakData, "_set_sm_wish", function(self) SetAIStats(self) end)

-- Player weapon stats
local WeaponClasses = {
  rifles = {
    [46] = { "famas", "asval", "corgi", "vhs", "galil", "komodo", "m16", "tkb" },
    [60] = { "s552", "aug", "groza", "sub2000", "g36", "l85a2", "new_m14", "ak5", "fal" },
    [90] = { "scar", "ak74", "new_m4", "flint", "tecci", "contraband", "g3" },
    [120] = { "amcar", "akm", "akm_gold", "shak12", "ching" }
  },
  shotguns = {
    
  },
  lmgs = {
    [60] = { "mg42", "kacchainsaw", "m249", "par" },
    [90] = { "rpk", "hk21", "hk51b" },
    [120] = { "hcar", "m60" }
  },
  snipers = {
    [185] = { "wa2000", "siltstone", "qbu88", "tti", "victor" },
    [123] = { "msr", "winchester1874", "scout", "r700" },
    [90] = { "r93", "sbl", "model70", "desertfox", "mosin", "m95", "contender" },
    [150] = { "awp" }
  },
  pistols = {
    [45] = { "glock_17", "ppk", "b92fs", "legacy", "g22c", "shrew", "g26", "glock_18c", "beer", "czech", "holt", "maxim9", "pl14", "packrat", "welrod" },
    [62] = { "p226", "colt_1911", "m1911", "c96", "type54", "breech", "hs2000", "stech", "pmm", "usp", "sparrow" },
    [78] = { "lemming", "model3" },
    [85] = { "peacemaker" },
    [170] = { "deagle", "mateba", "new_raging_bull", "chinchilla", "korth" },
    [123] = { "rsh12" }
  },
  smgs = {
    [38] = { "cobray", "pm9", "fmg9", "baka", "polymer", "mac10", "mp7", "mp9", "p90", "tec9", "scorpion" },
    [46] = { "akmsu", "hajk", "vityaz", "new_mp5", "m1928", "shepheard", "sr2", "uzi" },
    [60] = { "m45", "schakal", "olympic", "erma", "coal" },
    [90] = { "speen", "sterling" }
  }
}

Hooks:PostHook(WeaponTweakData, "init", "CrimDusk_WeaponTweakInit", function(self)
  for _, class in pairs(WeaponClasses) do
    for NewDamage, weapons in pairs(class) do
      for _, WeaponName in ipairs(weapons) do
        --log(WeaponName)
        self[WeaponName].stats.damage = NewDamage

        -- New ammo pickup
        local BaseMult = self[WeaponName].stats_modifiers and self[WeaponName].stats_modifiers.damage or 1
        local MostShotsToKill = math.max(480 / (BaseMult * NewDamage * 2) + 0.1, 0.51)
        local LeastShotsToKill = math.max(480 / (BaseMult * NewDamage * 1.05 * 2.5) - 0.5, 0.1)
        self[WeaponName].AMMO_PICKUP = { LeastShotsToKill, MostShotsToKill }
      end
    end
  end

  self.welrod.stats_modifiers = nil

  self.lemming.can_shoot_through_shield = nil
  self.lemming.can_shoot_through_wall = nil

  self.maxim9.do_shotgun_push = nil

  self.rsh12.single = { fire_rate = 0.5 }
  self.rsh12.fire_mode_data = { fire_rate = 0.5 }

  self.sbl.single = { fire_rate = 0.333 }
  self.sbl.fire_mode_data = { fire_rate = 0.333 }
end)