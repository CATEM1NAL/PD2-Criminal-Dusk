Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "CrimDusk_InitMeleeTweakData", function(self)
  -- Blunt
  local Punch = { "fists", "fight", "moneybundle" }
  local Gloves = { "brass_knuckles", "boxing_gloves" }
  local SmallObject = {
    "swagger", "aziz", "spatula", "microphone", "selfie", "zeus", "baton", "chac", "shock", "oldbaton", "detector",
    "branding_iron", "croupier_rake", "brick", "model24", "funder_strike", "sap", "bonk", "bonk2", "micstand", "taser", "hammer", "shillelagh", "stick",
    "piggy_hammer", "whiskey", "tenderizer"
  }
  local LargeObject = { "meter", "alien_maul", "briefcase", "spoon", "spoon_gold", "shovel", "cutters", "baseballbat", "slot_lever", "hockey", "buck", "dingdong", "road" }

  for _, weapon in ipairs(Punch) do
    self.melee_weapons[weapon].stats.weapon_type = "blunt"
    self.melee_weapons[weapon].stats.min_damage = 1
    self.melee_weapons[weapon].stats.max_damage = 2
    self.melee_weapons[weapon].stats.min_damage_effect = 2
    self.melee_weapons[weapon].stats.max_damage_effect = 2
    self.melee_weapons[weapon].stats.charge_time = 1
  end

  for _, weapon in ipairs(Gloves) do
    self.melee_weapons[weapon].stats.weapon_type = "blunt"
    self.melee_weapons[weapon].stats.min_damage = 2
    self.melee_weapons[weapon].stats.max_damage = 4
    self.melee_weapons[weapon].stats.min_damage_effect = 2
    self.melee_weapons[weapon].stats.max_damage_effect = 2
    self.melee_weapons[weapon].stats.charge_time = 1
  end

  for _, weapon in ipairs(SmallObject) do
    self.melee_weapons[weapon].stats.weapon_type = "blunt"
    self.melee_weapons[weapon].stats.min_damage = 4
    self.melee_weapons[weapon].stats.max_damage = 6
    self.melee_weapons[weapon].stats.min_damage_effect = 2
    self.melee_weapons[weapon].stats.max_damage_effect = 2
    self.melee_weapons[weapon].stats.charge_time = 2
  end

  for _, weapon in ipairs(LargeObject) do
    self.melee_weapons[weapon].stats.weapon_type = "blunt"
    self.melee_weapons[weapon].stats.min_damage = 6
    self.melee_weapons[weapon].stats.max_damage = 8
    self.melee_weapons[weapon].stats.min_damage_effect = 2
    self.melee_weapons[weapon].stats.max_damage_effect = 2
    self.melee_weapons[weapon].stats.charge_time = 3
  end

  -- Sharp
  local Knives = {
    "kabar", "toothbrush", "clean", "kabartanto", "nin", "fork", "shawn", "boxcutter", "bayonet", "sword", "fear", "hauteur", "ballistic", "pugio", "kampfmesser",
    "wing", "ostry", "switchblade", "grip", "push", "twins", "bowie", "chef", "x46", "tiger", "catch", "scoutknife", "gerber", "fairbair", "poker", "cqc", "rambo"
  }
  local SmallBlades = { "cs", "pitchfork", "sandsteel", "gator", "oxide", "agave", "bullseye", "scalper", "meat_cleaver", "cleaver", "tomahawk", "machete", "becker", "iceaxe" }
  local LargeBlades = { "beardy", "mining_pick", "morning", "great", "freedom", "fireaxe", "barbedwire" }

  for _, weapon in ipairs(Knives) do
    self.melee_weapons[weapon].stats.weapon_type = "sharp"
    self.melee_weapons[weapon].stats.min_damage = 2
    self.melee_weapons[weapon].stats.max_damage = 5
    self.melee_weapons[weapon].stats.min_damage_effect = 0.5
    self.melee_weapons[weapon].stats.max_damage_effect =  0.5
    self.melee_weapons[weapon].stats.charge_time = 1
  end

  for _, weapon in ipairs(SmallBlades) do
    self.melee_weapons[weapon].stats.weapon_type = "sharp"
    self.melee_weapons[weapon].stats.min_damage = 5
    self.melee_weapons[weapon].stats.max_damage = 8
    self.melee_weapons[weapon].stats.min_damage_effect = 0.5
    self.melee_weapons[weapon].stats.max_damage_effect = 0.5
    self.melee_weapons[weapon].stats.charge_time = 2
  end

  for _, weapon in ipairs(LargeBlades) do
    self.melee_weapons[weapon].stats.weapon_type = "sharp"
    self.melee_weapons[weapon].stats.min_damage = 8
    self.melee_weapons[weapon].stats.max_damage = 11
    self.melee_weapons[weapon].stats.min_damage_effect = 0.5
    self.melee_weapons[weapon].stats.max_damage_effect = 0.5
    self.melee_weapons[weapon].stats.charge_time = 3
  end

  -- Repeat reset time
  local AxeAnims = {
    "tomahawk", "moneybundle", "bullseye", "model24", "swagger", "shillelagh", "meat_cleaver", "hammer", "whiskey", "spatula", "scalper", "tenderizer", "branding_iron",
    "microphone", "detector", "micstand", "oldbaton", "slot_lever", "croupier_rake", "morning", "shock", "funder_strike", "agave"
  }
  local KnifeMacheteAnims = { "kabar", "bowie", "machete", "gator", "oxide", "x46", "kampfmesser" }
  local Knife2Anims = { "rambo", "gerber", "bayonet" }
  local BaseballAnims = { "barbedwire", "dingdong", "alien_maul", "piggy_hammer", "stick", "bonk", "bonk2", "spoon", "spoon_gold", "hockey" }
  local FistAnims = { "fists", "brass_knuckles", "tiger", "zeus", "push",  }

  for _, weapon in ipairs(AxeAnims) do self.melee_weapons[weapon].repeat_expire_t = 0.35 end
  for _, weapon in ipairs(BaseballAnims) do self.melee_weapons[weapon].repeat_expire_t = 0.8 end
  for _, weapon in ipairs(KnifeMacheteAnims) do self.melee_weapons[weapon].repeat_expire_t = 0.6 end
  for _, weapon in ipairs(Knife2Anims) do self.melee_weapons[weapon].repeat_expire_t = 0.4 end

  self.melee_weapons.hockey.anim_global_param = "melee_baseballbat"

  self.melee_weapons.cs.repeat_expire_t = 0.75
  self.melee_weapons.fireaxe.repeat_expire_t = 1.4
end)