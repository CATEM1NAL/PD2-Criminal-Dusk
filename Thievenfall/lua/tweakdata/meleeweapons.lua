local MeleeStats = {
  -- Blunt melees
  Unarmed = {
    weapon_type = "blunt", charge_time = 1,
    min_damage = 2, max_damage = 4,
    min_damage_effect = 2, max_damage_effect = 2
  },
  SmallObjects = {
    weapon_type = "blunt", charge_time = 2,
    min_damage = 4, max_damage = 6,
    min_damage_effect = 2, max_damage_effect = 2
  },
  LargeObjects = {
    weapon_type = "blunt", charge_time = 3,
    min_damage = 6, max_damage = 8,
    min_damage_effect = 2, max_damage_effect = 2
  },

  -- Sharp melees
  Knives = {
    weapon_type = "sharp", charge_time = 1,
    min_damage = 2, max_damage = 5,
    min_damage_effect = 0.5, max_damage_effect = 0.5
  },
  SmallBlades = {
    weapon_type = "sharp", charge_time = 2,
    min_damage = 5, max_damage = 8,
    min_damage_effect = 0.5, max_damage_effect = 0.5
  },
  LargeBlades = {
    weapon_type = "sharp", charge_time = 3,
    min_damage = 8, max_damage = 11,
    min_damage_effect = 0.5, max_damage_effect = 0.5
  }
}

local ResetTimers = { melee_axe = 0.35, melee_baseball = 0.8, melee_machete = 0.6, melee_knife2 = 0.4 }

local MeleeClasses = {
  Unarmed = {
    fists = {},
    fight = {},
    moneybundle = {}
  },

  SmallObjects = {
    swagger = {},
    aziz = {},
    spatula = {},
    microphone = {},
    selfie = {},
    zeus = {},
    baton = {},
    chac = {},
    shock = {},
    oldbaton = {},
    detector = {},
    branding_iron = {},
    croupier_rake = {},
    brick = { rep = 0.4 },
    model24 = {},
    funder_strike = {},
    sap = {},
    bonk = {},
    bonk2 = {},
    micstand = {},
    taser = {},
    hammer = {},
    shillelagh = {},
    stick = {},
    piggy_hammer = {},
    whiskey = {},
    tenderizer = {},
    brass_knuckles = {},
    boxing_gloves = {},
    happy = { rep = 0.4 }
  },

  LargeObjects = {
    meter = {},
    alien_maul = {},
    briefcase = {},
    spoon = {},
    spoon_gold = {},
    shovel = {},
    cutters = {},
    baseballbat = {},
    slot_lever = {},
    hockey = { anim = "melee_baseballbat" },
    buck = {},
    dingdong = {},
    road = {}
  },

  Knives = {
    kabar = {},
    toothbrush = {},
    clean = {},
    kabartanto = {},
    nin = {},
    fork = {},
    shawn = {},
    boxcutter = {},
    bayonet = {},
    sword = {},
    fear = {},
    hauteur = {},
    ballistic = {},
    pugio = {},
    kampfmesser = {},
    wing = { rep = 0.5 },
    ostry = {},
    switchblade = {},
    grip = {},
    push = {},
    twins = {},
    bowie = {},
    chef = {},
    x46 = {},
    tiger = {},
    catch = {},
    scoutknife = {},
    gerber = {},
    fairbair = {},
    poker = {},
    cqc = {},
    rambo = {}
  },

  SmallBlades = {
    cs = { rep = 0.75, dismember = true },
    pitchfork = {},
    sandsteel = { dismember = true },
    gator = { dismember = true },
    oxide = { dismember = true },
    agave = { dismember = true },
    bullseye = { dismember = true },
    scalper = { dismember = true },
    meat_cleaver = { dismember = true },
    cleaver = { dismember = true },
    tomahawk = { dismember = true },
    machete = { dismember = true },
    becker = { dismember = true },
    iceaxe = {}
  },

  LargeBlades = {
    beardy = { dismember = true },
    mining_pick = {},
    morning = {},
    great = { dismember = true },
    freedom = {},
    fireaxe = { rep = 1.4, dismember = true  },
    barbedwire = {}
  }
}

Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "CrimDusk_InitMeleeTweakData", function(self)
  for MeleeClass, MeleeClassData in pairs(MeleeClasses) do
    for MeleeWeapon, MeleeData in pairs(MeleeClassData) do
      local Range = self.melee_weapons[MeleeWeapon].stats.range
      local Conceal = self.melee_weapons[MeleeWeapon].stats.concealment

      self.melee_weapons[MeleeWeapon].stats = MeleeStats[MeleeClass]
      self.melee_weapons[MeleeWeapon].stats.range = Range
      self.melee_weapons[MeleeWeapon].stats.concealment = Conceal
      self.melee_weapons[MeleeWeapon].stats.remove_weapon_movement_penalty = true

      for Stat, Value in pairs(MeleeData) do
        if Stat == "rep" then self.melee_weapons[MeleeWeapon].repeat_expire_t = Value 
        elseif Stat == "anim" then self.melee_weapons[MeleeWeapon].anim_global_param = Value
        elseif Stat == "dismember" then self.melee_weapons[MeleeWeapon].dismember = Value end
      end

      local AnimSet = self.melee_weapons[MeleeWeapon].anim_global_param
      if ResetTimers[AnimSet] then self.melee_weapons[MeleeWeapon].repeat_expire_t = ResetTimers[AnimSet] end
    end
  end
end)