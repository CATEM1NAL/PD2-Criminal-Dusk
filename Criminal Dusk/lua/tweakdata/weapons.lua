local function SetAIStats(self)
  -- Health (vanilla OVK)
  self.swat_van_turret_module.HEALTH_INIT = 15000
  self.swat_van_turret_module.SHIELD_HEALTH_INIT = 500
  self.ceiling_turret_module.HEALTH_INIT = 10000
  self.ceiling_turret_module.SHIELD_HEALTH_INIT = 250
  self.aa_turret_module.HEALTH_INIT = 15000
  self.aa_turret_module.SHIELD_HEALTH_INIT = 500
  self.crate_turret_module.HEALTH_INIT = 10000
  self.crate_turret_module.SHIELD_HEALTH_INIT = 500

  -- Damage (vanilla Hard)
  self.ak47_ass_npc.DAMAGE = 0.4
  self.ak47_npc.DAMAGE = 0.5
  self.m4_npc.DAMAGE = 0.4
  self.m4_yellow_npc.DAMAGE = 0.4
  self.g36_npc.DAMAGE = 0.6

  self.r870_npc.DAMAGE = 1
  self.benelli_npc.DAMAGE = 1

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
  self.rpk_lmg_npc.DAMAGE = 0.25
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
  self.colt_1911_primary_npc.DAMAGE = 0.5
  self.glock_18_npc.DAMAGE = 0.5

  self.raging_bull_npc.DAMAGE = 2.5

  self.mp5_npc.DAMAGE = 0.25
  self.mp5_tactical_npc.DAMAGE = 0.25
  self.ump_npc.DAMAGE = 0.25
  self.akmsu_smg_npc.DAMAGE = 0.25
  self.asval_smg_npc.DAMAGE = 0.25

  self.mac11_npc.DAMAGE = 0.25

  self.mp9_npc.DAMAGE = 0.25
  self.sr2_smg_npc.DAMAGE = 0.25

  self.m14_npc.DAMAGE = 2.5
  self.s552_npc.DAMAGE = 0.6
  self.scar_npc.DAMAGE = 1

  self.m14_sniper_npc.trail = "effects/particles/weapons/sniper_trail"
  self.svd_snp_npc.trail = "effects/particles/weapons/sniper_trail"
  self.svdsil_snp_npc.trail = "effects/particles/weapons/sniper_trail"

  self.heavy_snp_npc.DAMAGE = 5 -- ZEAL sniper
  self.heavy_snp_npc.trail = "effects/particles/weapons/sniper_trail_marshal"

  self.dmr_npc.DAMAGE = 2.5 -- Marshal sniper
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
  special = {
    [4]  = { "flamethrower_mk2", "system", "money" },
    [12] = { "hunter", "ecp" },
    [15] = { "ray", "plainsrider", "rpg7" },
    [20] = { "arblast", "frankish" },
    [23] = { "shuno", "m134" },
    [30] = { "long", "elastic" },
    [150] = { "china", "ms3gl", "arbiter", "gre_m79", "slap", "m32" }
  },
  rifles = {
    [12] = { "hailstorm" },
    [24] = { "famas", "asval", "corgi", "vhs", "galil", "komodo", "m16", "tkb" },
    [32] = { "s552", "aug", "groza", "sub2000", "g36", "l85a2", "new_m14", "ak5", "fal" },
    [46] = { "scar", "ak74", "new_m4", "flint", "tecci", "contraband", "g3" },
    [92] = { "amcar", "akm", "akm_gold", "shak12", "ching" }
  },
  shotguns = {
    [25] = { "striker", "basset", "rota", "sko12", "saiga", "aa12", "serbu", "ultima", "judge", "spas12", "r870", "benelli", "ksg", "m1897", "supernova", "m37", "m590", "boot", "b682", "huntsman", "coach" },
  },
  lmgs = {
    [32] = { "mg42", "kacchainsaw", "m249", "par" },
    [46] = { "rpk", "hk21", "hk51b" },
    [92] = { "hcar", "m60" }
  },
  snipers = {
    [15] = { "m95" },
    [50] = { "r93", "model70", "desertfox", "mosin", "contender", "awp", "sbl" },
    [60] = { "bessy" },
    [75] = { "wa2000", "siltstone", "qbu88", "tti", "victor", "msr", "winchester1874", "scout", "r700" }
  },
  pistols = {
    [16] = { "glock_17", "ppk", "b92fs", "legacy", "g22c", "shrew", "g26", "glock_18c", "beer", "czech", "holt", "maxim9", "pl14", "packrat", "welrod" },
    [24] = { "p226", "colt_1911", "m1911", "c96", "type54", "breech", "hs2000", "stech", "pmm", "usp", "sparrow" },
    [32] = { "lemming" },
    [50] = { "peacemaker" },
    [65] = { "model3" },
    [75] = { "rsh12" },
    [80] = { "deagle", "mateba", "korth" },
    [120] = { "new_raging_bull", "chinchilla" }
  },
  smgs = {
    [16] = { "cobray", "pm9", "fmg9", "baka", "polymer", "mac10", "mp7", "mp9", "p90", "tec9", "scorpion" },
    [24] = { "akmsu", "hajk", "vityaz", "new_mp5", "m1928", "shepheard", "sr2", "uzi" },
    [32] = { "m45", "schakal", "olympic", "erma", "coal" },
    [46] = { "speen", "sterling" }
  },
  akimbo = {
    [16] = { "jowi", "x_g17" },
    [24] = { "x_1911", "x_mp5" },
    [92] = { "x_2006m", "x_rage" }
  }
}

local CrewNameConversion = { new_mp5 = "mp5_crew", new_m4 = "m4_crew", new_m14 = "m14_crew", new_raging_bull = "raging_bull_crew", glock_17 = "g17_crew", b92fs = "beretta92_crew", glock_18c = "glock_18_crew", colt_1911 = "c45_crew" }

local NoPickup = { 0, 0 }
local Flamethrower = { 18, 22 }
local ForcedAmmoPickup = {
  rpg7 = NoPickup, ray = NoPickup, -- rocket launchers
  hunter = NoPickup, ecp = NoPickup, arblast = NoPickup, frankish = NoPickup, -- crossbows
  plainsrider = NoPickup, long = NoPickup, elastic = NoPickup, -- bows
  flamethrower_mk2 = Flamethrower, system = Flamethrower, money = Flamethrower -- flamethrowers
}

Hooks:PostHook(WeaponTweakData, "init", "CrimDusk_WeaponTweakInit", function(self)
  for ClassName, ClassData in pairs(WeaponClasses) do
    for NewDamage, weapons in pairs(ClassData) do
      for _, WeaponName in ipairs(weapons) do

        -- Damage
        local BaseMult = self[WeaponName].stats_modifiers and self[WeaponName].stats_modifiers.damage or 1
        local ShotgunMult = ClassName == "shotguns" and 4 or 1
        local TotalDamage = BaseMult * NewDamage * ShotgunMult

        self[WeaponName].stats.damage = NewDamage

        if self[WeaponName .. "_crew"] then self[WeaponName .. "_crew"].DAMAGE = NewDamage * BaseMult * 0.5
        elseif self[CrewNameConversion[WeaponName]] then self[CrewNameConversion[WeaponName]].DAMAGE = NewDamage * BaseMult * 0.5
        else log("No crew weapon with name " .. WeaponName .. " found!") end

        if self["x_" .. WeaponName] then self["x_" .. WeaponName].stats.damage = NewDamage end

        -- New ammo pickup
        local PickupMod = 75 / TotalDamage
        local MostShotsToKill = math.max(150 / (TotalDamage * 2) + (PickupMod^2), 0.5 + PickupMod)
        local LeastShotsToKill = math.max(200 / (TotalDamage * 2.625) - 0.5, 0.5 * PickupMod)

        if ForcedAmmoPickup[WeaponName] then self[WeaponName].AMMO_PICKUP = ForcedAmmoPickup[WeaponName]
        else self[WeaponName].AMMO_PICKUP = { LeastShotsToKill, MostShotsToKill } end

        if self["x_" .. WeaponName] then self["x_" .. WeaponName].AMMO_PICKUP = { LeastShotsToKill, MostShotsToKill } end
      end
    end
  end

  -- Shotgun base accuracy
  local ShotgunAcc = {
    x_basset = 1, x_sko12 = 1,
    x_judge = 2, x_rota = 2,
    basset = 3, saiga = 3, sko12 = 3, aa12 = 3,
    striker = 5, rota = 5, ultima = 5, judge = 5, spas12 = 5, benelli = 5, m590 = 5, serbu = 5,
    r870 = 9, ksg = 9, m1897 = 9, supernova = 9, m37 = 9,
    boot = 17, b682 = 17, huntsman = 17, coach = 17
  }

  for weapon, acc in pairs(ShotgunAcc) do
    self[weapon].stats.spread = acc
    self[weapon].stats.spread_moving = math.floor(acc / 2)
  end

  -- Damage modifier tweaks
  self.long.stats_modifiers.damage = 10
  self.elastic.stats_modifiers.damage = 10
  self.china.stats_modifiers.damage = 1
  self.ms3gl.stats_modifiers.damage = 1
  self.arbiter.stats_modifiers.damage = 1
  self.gre_m79.stats_modifiers.damage = 2
  self.m32.stats_modifiers.damage = 2
  self.slap.stats_modifiers.damage = 2
  self.ray.stats_modifiers.damage = 25
  self.m95.stats_modifiers.damage = 100

  -- Magazine size tweaks
  local MagSize = { asval = 20, scar = 20, g3 = 20 }
  for weapon, mag in pairs(MagSize) do
    self[weapon].CLIP_AMMO_MAX = mag
    self[weapon].NR_CLIPS_MAX = 5
    self[weapon].AMMO_MAX = self[weapon].CLIP_AMMO_MAX * self[weapon].NR_CLIPS_MAX
  end

  -- Attribute tweaks
  self.hailstorm.categories = { "assault_rifle" }
  self.welrod.stats_modifiers = nil

  self.lemming.can_shoot_through_shield = nil
  self.lemming.can_shoot_through_wall = nil

  self.maxim9.do_shotgun_push = nil

  -- Fire rate tweaks
  self.rsh12.single = { fire_rate = 0.5 }
  self.rsh12.fire_mode_data = { fire_rate = 0.5 }
end)