local FileIdent = "WeaponTweakData"

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


-- Player weapon stat categories
local WeaponDamage = {
  rifles = { low = 24, med = 32, high = 46, vhigh = 92 },
  shotguns = { base = 20 },
  lmgs = { low = 32, med = 46, high = 92 },
  snipers = { low = 75, high = 50 }, -- low x2, high x4
  pistols = { auto = 16, low = 32, med = 46, high = 65 },
  revolvers = { low = 80, high = 120 },
  smgs = { vlow = 16, low = 24, med = 32, high = 46 },
  special = { flame = 4, xlow = 12, xhigh = 20, rpg = 15, mini = 23, bow = 30, gl = 150 }
}

local SpreadMults = {
  rifles = {
    standing = 2, crouching = 1, steelsight = 1.25,
    moving_standing = 4, moving_crouching = 2, moving_steelsight = 1
  },
  shotguns = {
    standing = 3, crouching = 1.5, steelsight = 1.2,
    moving_standing = 3, moving_crouching = 2, moving_steelsight = 1
  },
  lmgs = { -- NOT FINISHED
    standing = 3, crouching = 1.5, steelsight = 1.25,
    moving_standing = 4, moving_crouching = 2, moving_steelsight = 1
  },
  snipers = {
    standing = 1, crouching = 0.5, steelsight = 1.5,
    moving_standing = 8, moving_crouching = 4, moving_steelsight = 1
  },
  pistols = { -- NOT FINISHED
    standing = 2, crouching = 1, steelsight = 1.25,
    moving_standing = 4, moving_crouching = 2, moving_steelsight = 1
  },
  revolvers = { -- NOT FINISHED
    standing = 2, crouching = 1, steelsight = 1.25,
    moving_standing = 4, moving_crouching = 2, moving_steelsight = 1
  },
  smgs = { -- NOT FINISHED
    standing = 2, crouching = 1, steelsight = 1.25,
    moving_standing = 4, moving_crouching = 2, moving_steelsight = 1
  },
  special = { -- NOT FINISHED
    standing = 2, crouching = 1, steelsight = 1.25,
    moving_standing = 4, moving_crouching = 2, moving_steelsight = 1
  }
}

local MaxMagazines = {
  rifles = 5, shotguns = 4, lmgs = 2, snipers = 3, pistols = 4, revolvers = 2, smgs = 5, special = 2
}

local AmmoPickup = {
  none = { 0, 0 }, flame = { 18, 22 }
}

-- Assign weapon stats
local WeaponClasses = {
  rifles = {
    hailstorm = { dmg = 12, chamber = 0 },

    famas = { dmg = "low" },
    asval = { dmg = "low", mag = 20 },
    corgi = { dmg = "low" },
    vhs = { dmg = "low" },
    galil = { dmg = "low" },
    komodo = { dmg = "low" },
    m16 = { dmg = "low", mag = 20, reload = 20 },
    tkb = { dmg = "low", chamber = 3 },

    s552 = { dmg = "med" },
    aug = { dmg = "med" },
    groza = { dmg = "med" },
    sub2000 = { dmg = "med" },
    g36 = { dmg = "med" },
    l85a2 = { dmg = "med" },
    new_m14 = { dmg = "med" },
    ak5 = { dmg = "med" },
    fal = { dmg = "med" },

    scar = { dmg = "high", mag = 20 },
    ak74 = { dmg = "high" },
    new_m4 = { dmg = "high" },
    flint = { dmg = "high"},
    tecci = { dmg = "high" },
    contraband = { dmg = "high" },
    g3 = { dmg = "high", mag = 20 },

    amcar = { dmg = "vhigh" },
    akm = { dmg = "vhigh" },
    akm_gold = { dmg = "vhigh" },
    shak12 = { dmg = "vhigh" },
    ching = { dmg = "vhigh", chamber = 0 },
  },

  shotguns = {
    striker = { dmg = "base", acc = 5, chamber = 0 },
    basset = { dmg = "base", acc = 3 },
    rota = { dmg = "base", acc = 5, chamber = 0 },
    sko12 = { dmg = "base", acc = 3 },
    saiga = { dmg = "base", acc = 3, mag = 5, reload = 20 },
    aa12 = { dmg = "base", acc = 3, reload = 20 },
    serbu = { dmg = "base", acc = 5 },
    ultima = { dmg = "base", acc = 5 },
    judge = { dmg = "base", acc = 5, chamber = 0 },
    spas12 = { dmg = "base", acc = 5 },
    r870 = { dmg = "base", acc = 9 },
    benelli = { dmg = "base", acc = 5 },
    ksg = { dmg = "base", acc = 9 },
    m1897 = { dmg = "base", acc = 9 },
    supernova = { dmg = "base", acc = 9 },
    m37 = { dmg = "base", acc = 9 },
    m590 = { dmg = "base", acc = 5 },
    boot = { dmg = "base", acc = 17 },
    b682 = { dmg = "base", acc = 17, magdump = false, chamber = 0 },
    huntsman = { dmg = "base", acc = 17, chamber = 0 },
    coach = { dmg = "base", acc = 17, magdump = false, chamber = 0 }
  },

  lmgs = {
    mg42 = { dmg = "low", chamber = 0 },
    kacchainsaw = { dmg = "low", chamber = 0 },
    m249 = { dmg = "low", chamber = 0 },
    par = { dmg = "low", chamber = 0 },

    rpk = { dmg = "med" },
    hk21 = { dmg = "med" },
    hk51b = { dmg = "med" },

    hcar = { dmg = "high" },
    m60 = { dmg = "high", chamber = 0 }
  },

  snipers = {
    bessy = { dmg = 60, chamber = 0 },
    m95 = { dmgmult = 100, dmg = 15 },

    wa2000 = { dmg = "low" },
    siltstone = { dmg = "low" },
    qbu88 = { dmg = "low" },
    tti = { dmg = "low" },
    victor = { dmg = "low" },
    msr = { dmg = "low" },
    winchester1874 = { dmg = "low" },
    scout = { dmg = "low" },
    r700 = { dmg = "low" },

    r93 = { dmg = "high" },
    model70 = { dmg = "high" },
    desertfox = { dmg = "high" },
    mosin = { dmg = "high" },
    contender = { dmg = "high", chamber = 0 },
    awp = { dmg = "high" },
    sbl = { dmg = "high" }
  },

  pistols = {
    glock_18c = { dmg = "auto" },
    b92fs = { dmg = "auto" },
    czech = { dmg = "auto" },
    beer = { dmg = "auto" },

    glock_17 = { dmg = "low" },
    ppk = { dmg = "low" },
    legacy = { dmg = "low" },
    g22c = { dmg = "low" },
    shrew = { dmg = "low" },
    g26 = { dmg = "low" },
    holt = { dmg = "low" },
    maxim9 = { dmg = "low" },
    pl14 = { dmg = "low" },
    packrat = { dmg = "low" },
    welrod = { dmg = "low" },
    jowi = { dmg = "low" },
    x_g17 = { dmg = "low" },

    p226 = { dmg = "med" },
    colt_1911 = { dmg = "med" },
    x_1911 = { dmg = "med" },
    m1911 = { dmg = "med" },
    c96 = { dmg = "med" },
    type54 = { dmg = "med" },
    breech = { dmg = "med" },
    hs2000 = { dmg = "med" },
    stech = { dmg = "med" },
    pmm = { dmg = "med" },
    usp = { dmg = "med" },
    sparrow = { dmg = "med" },

    lemming = { dmg = "high" },
    model3 = { dmg = "high", chamber = 0 }
  },

  revolvers = {
    deagle = { dmg = "low" },
    mateba = { dmg = "low", chamber = 0 },
    x_2006m = { dmg = "low", chamber = 0 },
    korth = { dmg = "low", chamber = 0 },

    peacemaker = { dmgmult = 1, dmg = 100, chamber = 0 },

    new_raging_bull = { dmg = "high", chamber = 0 },
    x_rage = { dmg = "high", chamber = 0 },
    chinchilla = { dmg = "high", chamber = 0 },

    rsh12 = { dmg = 75, rof = 0.5, chamber = 0 }
  },

  smgs = {
    cobray = { dmg = "vlow", chamber = 0 },
    pm9 = { dmg = "vlow" },
    fmg9 = { dmg = "vlow" },
    baka = { dmg = "vlow" },
    polymer = { dmg = "vlow" },
    mac10 = { dmg = "vlow", chamber = 0 },
    mp7 = { dmg = "vlow" },
    mp9 = { dmg = "vlow" },
    p90 = { dmg = "vlow" },
    tec9 = { dmg = "vlow" },
    scorpion = { dmg = "vlow" },

    akmsu = { dmg = "low" },
    hajk = { dmg = "low" },
    vityaz = { dmg = "low" },
    new_mp5 = { dmg = "low" },
    x_mp5 = { dmg = "low" },
    m1928 = { dmg = "low", chamber = 0 },
    shepheard = { dmg = "low" },
    sr2 = { dmg = "low" },
    uzi = { dmg = "low", chamber = 0 },

    m45 = { dmg = "med", chamber = 0 },
    schakal = { dmg = "med" },
    olympic = { dmg = "med", reload = 20 },
    erma = { dmg = "med", chamber = 0 },
    coal = { dmg = "med" },

    speen = { dmg = "high" },
    sterling = { dmg = "high", chamber = 0 }
  },

  special = {
    flamethrower_mk2 = { dmg = "flame", pickup = "flame", chamber = 0 },
    system = { dmg = "flame", pickup = "flame", chamber = 0 },
    money = { dmg = "flame", pickup = "flame", chamber = 0 },

    hunter = { dmg = "xlow", pickup = "none", chamber = 0 },
    ecp = { dmg = "xlow", pickup = "none", chamber = 0 },
    arblast = { dmg = "xhigh", pickup = "none", chamber = 0 },
    frankish = { dmg = "xhigh", pickup = "none", chamber = 0 },

    plainsrider = { dmg = "rpg", pickup = "none", chamber = 0 },
    long = { dmgmult = 10, dmg = "bow", pickup = "none", chamber = 0 },
    elastic = { dmgmult = 10, dmg = "bow", pickup = "none", chamber = 0 },

    rpg7 = { dmg = "rpg", pickup = "none", chamber = 0 },
    ray = { dmgmult = 25, dmg = "rpg", pickup = "none", chamber = 0 },

    shuno = { dmg = "mini", chamber = 0 },
    m134 = { dmg = "mini", chamber = 0 },

    china = { dmgmult = 1, dmg = "gl", chamber = 0 },
    ms3gl = { dmgmult = 1, dmg = "gl", chamber = 0 },
    arbiter = { dmgmult = 1, dmg = "gl", chamber = 0 },
    gre_m79 = { dmgmult = 2, dmg = "gl", chamber = 0 },
    slap = { dmgmult = 2, dmg = "gl", chamber = 0 },
    m32 = { dmgmult = 2, dmg = "gl", chamber = 0 },

    saw = { chamber = 0 },
    saw_secondary = { chamber = 0 }
  }
}

local AkimboOverride = { jowi = true, x_g17 = true, x_mp5 = true, x_1911 = true, x_2006m = true, x_rage = true }

local CrewNameConversion = {
  new_mp5 = "mp5_crew", new_m4 = "m4_crew", new_m14 = "m14_crew", new_raging_bull = "raging_bull_crew",
  glock_17 = "g17_crew", b92fs = "beretta92_crew", glock_18c = "glock_18_crew", colt_1911 = "c45_crew"
}

local function ModifyStats(self, WeaponClassName, WeaponClassData)
  for Weapon, Data in pairs(WeaponClassData) do

    -- Global changes to account for index tweaks
    self[Weapon].stats.extra_ammo = self[Weapon].stats.extra_ammo + 50
    if self["x_" .. Weapon] then self["x_" .. Weapon].stats.extra_ammo = self["x_" .. Weapon].stats.extra_ammo + 50 end

    self[Weapon].stats.reload = self[Weapon].stats.reload + 5
    if self["x_" .. Weapon] then self["x_" .. Weapon].stats.reload = self["x_" .. Weapon].stats.reload + 5 end

    -- Custom stat initialisation
    self[Weapon].MagDump = true
    if self["x_" .. Weapon] then self["x_" .. Weapon].MagDump = true end

    self[Weapon].ChamberRounds = 1
    if self["x_" .. Weapon] then self["x_" .. Weapon].ChamberRounds = 2 end

    for Stat, Value in pairs(Data) do -- Apply custom stat overrides

      if Stat == "dmgmult" then -- Damage multiplier
        self[Weapon].stats_modifiers.damage = Value

      elseif Stat == "dmg" then -- Damage
        if type(Value) == "string" then Value = WeaponDamage[WeaponClassName][Value] end
        local DmgMult = self[Weapon].stats_modifiers and self[Weapon].stats_modifiers.damage or 1
        local Pellets = self[Weapon].rays and self[Weapon].rays or 1
        local MaxDamage = Value * DmgMult * Pellets

        -- Player damage
        self[Weapon].stats.damage = Value
        if self["x_" .. Weapon] then self["x_" .. Weapon].stats.damage = Value end
        
        -- Team AI damage
        if self[Weapon .. "_crew"] then self[Weapon .. "_crew"].DAMAGE = Value * DmgMult * 0.5
        elseif self[CrewNameConversion[Weapon]] then self[CrewNameConversion[Weapon]].DAMAGE = Value * DmgMult * 0.5 end

        -- Ammo pickup
        local PickupMod = 75 / MaxDamage
        local MostShotsToKill = math.max(150 / (MaxDamage * 2) + (PickupMod^2), 0.5 + PickupMod)
        local LeastShotsToKill = math.max(200 / (MaxDamage * 2.625) - 0.5, 0.5 * PickupMod)

        self[Weapon].AMMO_PICKUP = { LeastShotsToKill, MostShotsToKill }
        if self["x_" .. Weapon] then self["x_" .. Weapon].AMMO_PICKUP = { LeastShotsToKill, MostShotsToKill } end

      elseif Stat == "acc" then -- Accuracy
        self[Weapon].stats.spread = Value
        self[Weapon].stats.spread_moving = Value

        if self["x_" .. Weapon] or AkimboOverride[Weapon] then
          Weapon = self["x_" .. Weapon] and ("x_" .. Weapon) or Weapon
          self[Weapon].stats.spread = math.max(math.floor(Value * 0.5), 1)
          self[Weapon].stats.spread_moving = self[Weapon].stats.spread
        end

      elseif Stat == "pickup" then -- Ammo pickup
        if type(Value) == "string" then Value = AmmoPickup[Value] end
        self[Weapon].AMMO_PICKUP = Value

      elseif Stat == "mag" then -- Magazine size
        if self[Weapon .. "_crew"] then self[Weapon .. "_crew"].CLIP_AMMO_MAX = Value
        elseif self[CrewNameConversion[Weapon]] then self[CrewNameConversion[Weapon]].CLIP_AMMO_MAX = Value end

        self[Weapon].CLIP_AMMO_MAX = Value
        if self["x_" .. Weapon] then self["x_" .. Weapon].CLIP_AMMO_MAX = Value end

      elseif Stat == "chamber" then -- Rounds in chamber
        self[Weapon].ChamberRounds = Value
        if self["x_" .. Weapon] then self["x_" .. Weapon].ChamberRounds = Value * 2 end

      elseif Stat == "magdump" then -- Mag dumping
        self[Weapon].MagDump = Value
        if self["x_" .. Weapon] then self["x_" .. Weapon].MagDump = Value end

      elseif Stat == "reload" then -- Reload speed
        self[Weapon].stats.reload = Value

      elseif Stat == "rof" then -- Fire rate
        self[Weapon].fire_mode_data.fire_rate = Value
        if self[Weapon].single then self[Weapon].single.fire_rate = Value end
        if self[Weapon].auto then self[Weapon].auto.fire_rate = Value end
      end

    end

    -- Stats derived from weapon class
    self[Weapon].AMMO_MAX = self[Weapon].CLIP_AMMO_MAX * MaxMagazines[WeaponClassName]
    self[Weapon].spread = SpreadMults[WeaponClassName]

  end
end

Hooks:PostHook(WeaponTweakData, "init", "CrimDusk_WeaponTweakInit", function(self)
  -- Update stat indexes
  self.stats.reload = {}
  for i = -5, 20 do table.insert(self.stats.reload, i / 10) end

  self.stats.extra_ammo = {}
  for i = -100, 100 do table.insert(self.stats.extra_ammo, i) end

  self.stats.spread = {}
  for i = 0, 25 do table.insert(self.stats.spread, 3 - (i * 0.1)) end

  self.stats.spread_moving = {}
  for i = 0, 25 do table.insert(self.stats.spread_moving, 5 - (i * 0.1)) end

  -- Update weapon damage
  self.trip_mines.damage = 15
  for WeaponClassName, WeaponClassData in pairs(WeaponClasses) do ModifyStats(self, WeaponClassName, WeaponClassData) end

  -- Attribute tweaks
  self.hailstorm.categories = { "assault_rifle" }
  self.welrod.stats_modifiers = nil

  self.lemming.can_shoot_through_shield = nil
  self.lemming.can_shoot_through_wall = nil

  self.maxim9.do_shotgun_push = nil
end)