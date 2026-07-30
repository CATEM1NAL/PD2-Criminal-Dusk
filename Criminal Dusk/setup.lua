if CrimDusk then return end
local FileIdent = "Setup"
CrimDusk = {}

function CrimDusk:Init()
  self.ModPath = ModPath
  self.SavePath = SavePath

  self.SaveFile = self.SavePath .. "crimdusk_save.txt"
  self.SettingsFile = self.SavePath .. "crimdusk_settings.txt"

  self.SettingsData = io.load_as_json(CrimDusk.SettingsFile) or {}
  if not self.SettingsData then self.SettingsData = {} end

  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/settings.json", self, self.SettingsData)

  self.state = { heist_started = false }

  -- Helper functions
  function self.Log(FileIdent, LogMessage)
    log("[DUSK>" .. FileIdent .. "] " .. LogMessage)
  end -- Yes, this WILL crash without a FileIdent. This is intentional.

  function self.ChatNotify(message)
    if not managers.chat then return end
    managers.chat:_receive_message(ChatManager.GAME, "CRIMINAL DUSK", message, Global.CrimDusk.archicolours.orange)
  end

  function self:WriteSave(FileIdent, SaveReason)
    io.save_as_json(Global.CrimDusk.data, self.SaveFile)
    self.Log(FileIdent, "Saved " .. self.SaveFile .. " (" .. SaveReason .. ")")
  end -- Yes, this WILL crash without a FileIdent or SaveReason. This is intentional.

  function self.GoLoud()
    local LoudDelay = 3
    if Global.game_settings.level_id == "friend" then LoudDelay = 5 end
    DelayedCalls:Add("CrimDusk_GoLoudDelay", LoudDelay, function() managers.groupai:state():on_police_called("empty") end)
  end

  -- Difficulty scaling
  function self.DiffScale(ignore_cap)
    if (Global.CrimDusk.data.heists_won or 0) < 5 then
      return Global.CrimDusk.data.heists_won + 2
    end

    local HeistsWon = Global.CrimDusk.data.heists_won - 5
    local RawDiff = HeistsWon / (#Global.CrimDusk.campaign - 5) * 7 + 2
    local RoundedDiff = math.floor(RawDiff + 0.5)

    if ignore_cap then return RoundedDiff end
    return math.min(RoundedDiff, 8)
  end

  -- Reset campaign state
  function self:Reset()
    Global.CrimDusk.data = { heists_won = 0, lives = 4 }
  end
end

CrimDusk:Init()

if NetworkHelper:IsHost() and Global.CrimDusk and (Global.CrimDusk.data.heists_won or 0) < 5 then
  Hooks:Add("LocalizationManagerPostInit", "CrimDusk_PDTHNames", function(loc)
    loc:load_localization_file(CrimDusk.ModPath .. "loc/pdth_difficulties.json")
  end)
end

local function SetTweakData()
  -- Player colours
  local player1 = Global.CrimDusk.archicolours.blue
  local player2 = Global.CrimDusk.archicolours.pink
  local player3 = Global.CrimDusk.archicolours.red
  local player4 = Global.CrimDusk.archicolours.yellow
  local team_ai = Global.CrimDusk.archicolours.orange

  tweak_data.peer_vector_colors[1] = player1
  tweak_data.chat_colors[1] = player1
  tweak_data.preplanning_peer_colors[1] = Global.CrimDusk.archicolours.blue_alt

  tweak_data.peer_vector_colors[2] = player2
  tweak_data.chat_colors[2] = player2
  tweak_data.preplanning_peer_colors[2] = Global.CrimDusk.archicolours.pink_alt

  tweak_data.peer_vector_colors[3] = player3
  tweak_data.chat_colors[3] = player3
  tweak_data.preplanning_peer_colors[3] = Global.CrimDusk.archicolours.red_alt

  tweak_data.peer_vector_colors[4] = player4
  tweak_data.chat_colors[4] = player4
  tweak_data.preplanning_peer_colors[4] = Global.CrimDusk.archicolours.yellow_alt

  tweak_data.peer_vector_colors[5] = team_ai
  tweak_data.chat_colors[5] = team_ai

  -- Spy camera feed colour
  for i = 1, #tweak_data.chat_colors - 1 do
    local theme_id = "spy_camera_peer_" .. i

    tweak_data.camera_themes[theme_id] = clone(tweak_data.camera_themes.spy_camera)
    tweak_data.camera_themes[theme_id].tint_color = tweak_data.chat_colors[i]:with_alpha(0.2)
  end

  -- Other menu colours
  tweak_data.system_chat_color = Global.CrimDusk.archicolours.orange

  tweak_data.screen_colors.resource = Global.CrimDusk.archicolours.red
  tweak_data.screen_colors.button_stage_2 = Global.CrimDusk.archicolours.orange
  tweak_data.screen_colors.button_stage_3 = Global.CrimDusk.archicolours.red
  tweak_data.screen_colors.risk = Global.CrimDusk.archicolours.yellow
  tweak_data.screen_colors.ghost_color = Global.CrimDusk.archicolours.red

  -- XP curve
  local xp = 1000
  for i = 1, 100 do
      tweak_data.experience_manager.levels[i] = { points = xp }
      xp = 1000 * (i + 1)
  end

  -- XP tweaks
  tweak_data.experience_manager.prestige_xp_max = 5000000
  tweak_data.experience_manager.difficulty_multiplier = { 1.5, 2, 2.5, 3, 3.5, 4 }
  tweak_data.experience_manager.level_limit.pc_difference_multipliers = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
  tweak_data.experience_manager.level_limit.low_cap_multiplier = 1

  -- Projectile damage
  local Grenade = 40
  
  local HighLauncher = 30
  local LowLauncher = 15
  local ShockLauncher = 1
  
  local Bow = 15
  local BowPoison = Bow * 0.75
  local BowExp = Bow * 1.5
  
  local Crossbow = Bow * 0.8
  local CrossbowPoison = Crossbow * 0.75
  local CrossbowExp = Crossbow * 1.5

  local ProjDmg = {
    -- frags
    frag = Grenade, dynamite = Grenade, dada_com = Grenade, frag_com = Grenade * 0.5, sticky_grenade = HighLauncher,
    -- special grenades
    wpn_gre_electric = ShockLauncher * 2.5, poison_gas_grenade = 0, molotov = 0, fir_com = 0,
    -- thrown
    wpn_prj_four = 7.5, wpn_prj_ace = 0.1, wpn_prj_jav = 50, wpn_prj_hur = 15, wpn_prj_target = 15, xmas_snowball = 10,

    -- frag launchers
    launcher_frag = HighLauncher, launcher_frag_slap = HighLauncher,
    launcher_frag_m32 = HighLauncher, launcher_frag_china = LowLauncher, launcher_frag_arbiter = LowLauncher, launcher_frag_ms3gl = LowLauncher,
    -- incendiary launchers
    launcher_incendiary = 0, launcher_incendiary_slap = 0,
    launcher_incendiary_m32 = 0, launcher_incendiary_china = 0, launcher_incendiary_arbiter = 0, launcher_incendiary_ms3gl = 0,
    -- shock launchers
    launcher_electric = ShockLauncher, launcher_electric_slap = ShockLauncher,
    launcher_electric_m32 = ShockLauncher, launcher_electric_china = ShockLauncher, launcher_electric_arbiter = ShockLauncher, launcher_electric_ms3gl = ShockLauncher,
    -- poison launchers
    launcher_poison = 0, launcher_poison_gre_m79 = 0, launcher_poison_slap = 0,
    launcher_poison_m32 = 0, launcher_poison_china = 0, launcher_poison_arbiter = 0, launcher_poison_ms3gl_conversion = 0,

    -- frag underbarrels
    launcher_m203 = HighLauncher, underbarrel_m203_groza = HighLauncher,
    -- shock underbarrels
    underbarrel_electric = ShockLauncher, underbarrel_electric_groza = ShockLauncher,
    -- poison underbarrels
    launcher_poison_contraband = 0, launcher_poison_groza = 0,

    -- standard bows
    west_arrow = Bow, long_arrow = Bow * 2, elastic_arrow = Bow * 2,
    -- explosive bows
    west_arrow_exp = BowExp, long_arrow_exp = BowExp * 2, elastic_arrow_exp = BowExp * 2,
    -- poison bows
    bow_poison_arrow = BowPoison, long_poison_arrow = BowPoison * 2, elastic_arrow_poison = BowPoison * 2,

    -- standard crossbows
    crossbow_arrow = Crossbow, frankish_arrow = Grenade, arblast_arrow = 200, ecp_arrow = Crossbow,
    -- explosive crossbows
    crossbow_arrow_exp = CrossbowExp, frankish_arrow_exp = Grenade * 1.5, arblast_arrow_exp = 300, ecp_arrow_exp = CrossbowExp,
    -- poison crossbows
    crossbow_poison_arrow = CrossbowPoison, frankish_poison_arrow = Grenade * 0.75, arblast_poison_arrow = 100, ecp_arrow_poison = CrossbowPoison,

    -- other
    launcher_rocket = 150, rocket_ray_frag = 37.5
  }

  for proj, dmg in pairs(ProjDmg) do
    tweak_data.projectiles[proj].damage = dmg
    if tweak_data.projectiles[proj].player_damage then tweak_data.projectiles[proj].player_damage = dmg * 0.1 end
    if tweak_data.projectiles[proj].poison_gas_duration then tweak_data.projectiles[proj].poison_gas_duration = 5 end
  end

  tweak_data.projectiles.poison_gas_grenade.poison_gas_duration = 15

  tweak_data.team_ai.stop_action.distance = 10000 -- Crew AI will only start following you after you go 100m away (vanilla is 30m)

  -- Medic rework; medics have no cooldown but have half range
  tweak_data.medic.radius = 200
  tweak_data.medic.cooldown = 0

  tweak_data:digest_tweak_data()
end

if Global.CrimDusk then SetTweakData() end

-- THIS SECTION ONLY RUNS ONCE ON GAME LAUNCH --
if Global.CrimDusk then return end
Global.CrimDusk = {
  regen_time = { 0.5, 0.5, 1, 2, 3.5, 5, 6.5 },

  archicolours = {
    green = Color(255, 117, 194, 117) / 255,
    green_alt = Color(255, 43, 194, 43) / 255,

    blue = Color(255, 118, 126, 189) / 255,
    blue_alt = Color(255, 66, 83, 189) / 255,

    pink = Color(255, 202, 148, 194) / 255,
    pink_alt = Color(255, 202, 89, 194) / 255,

    red = Color(255, 201, 118, 130) / 255,
    red_alt = Color(255, 201, 41, 66) / 255,

    orange = Color(255, 217, 160, 125) / 255,
    orange_alt = Color(255, 217, 160, 56) / 255,

    yellow = Color(255, 238, 227, 145) / 255,
    yellow_alt = Color(255, 238, 227, 50) / 255
  }
}

function Global.CrimDusk:Init()
  self.ModVersion = BeardLib.Utils:FindMod("Criminal Dusk").AssetUpdates.version
  CrimDusk.Log(FileIdent, "Playing Criminal Dusk v" .. self.ModVersion)
  CrimDusk.Log(FileIdent, "Attempting to load save file...")
  self.data = io.load_as_json(CrimDusk.SaveFile)

  if not self.data then
    CrimDusk:Reset()
    CrimDusk:WriteSave(FileIdent, "save created")
  end

  self.campaign = {
    "red2", "flat", "pal", "man", "nmh", -- PDTH Prologue
    "cd_tut1", "cd_tut2", "cd_tut3", "four_stores", "mallcrasher", "branchbank_prof", "ukrainian_job_prof", "nightclub", -- Early Vlad
    "cd_watchdogs1_wrapper", "cd_watchdogs2_wrapper", "cd_frame3", "cd_bigoil", "cd_firestarter1", "cd_firestarter2", "alex", -- Hector/Elephant
    "family", "arm_wrapper", "arm_for", "roberts", "cd_erection_wrapper", "kosugi", -- Post Launch
    "big", "cd_miami1", "cd_miami2", "gallery", "cd_hox1", "cd_hox2", "pines", "mus", -- Dentist
    "cd_bomb", "cage", "hox_3", "shoutout_raid", "arena", "kenaz", "jolly", "dinner", "pbr", "pbr2", "cane", -- 2015
    "cd_goat1", "cd_goat2", "dark", "mad", "cd_biker1", "cd_biker2", "moon", "friend", -- 2016
    "spa", "fish", "run", "glace", "wwh", "dah", "cd_reservoir", "brb", "tag", "des", "sah", -- Final Arc
    "mex", "chas", "bex", "sand", "pex", "chca", "fex", "pent", "bph", "ranc", "trai", "corp", -- Bopocalypse
    "deep", "vit" -- Conclusion
  }
  self.StealthableHeists = { -- Alarm doesn't go off immediately on these heists
    kosugi = true, fish = true, dark = true, tag = true, cage = true,
    pal = true, man = true, nmh = true, dah = true, gallery = true, framing_frame_3 = true,
    election_day_2 = true, short_1_1 = true, short_1_2 = true, welcome_to_the_jungle_2 = true,
    firestarter_2 = true, alex_2 = true, crojob1 = true, kenaz = true, chca = true, family = true
  }
  self.LoudHeists = { -- Alarm goes off immediately, PDTH style
    "red2", "flat", "man", "four_stores", "nmh", "mallcrasher", "branchbank", "ukrainian_job", "nightclub", "welcome_to_the_jungle_2",
    "firestarter_1", "arm_for", "roberts", "big", "mus", "hox_3", "arena", "friend", "sah", "mex", "chas", "bex", "sand", "pex", "chca",
    "fex", "pent", "bph", "ranc", "trai", "corp", "deep", "vit"
  }

  SetTweakData()
end

-- Logo replacements
DB:create_entry(Idstring("texture"), Idstring("guis/textures/menu_title_screen"), CrimDusk.ModPath .. "assets/logo/title.texture")
DB:create_entry(Idstring("texture"), Idstring("guis/textures/game_small_logo"), CrimDusk.ModPath .. "assets/logo/small.texture")
DB:create_entry(Idstring("texture"), Idstring("units/menu/menu_scene/menu_cylinder_logo"), CrimDusk.ModPath .. "assets/logo/menu.texture")

-- Background replacements
DB:create_entry(Idstring("texture"), Idstring("guis/textures/pd2/menu_backdrop/bd_baselayer"), CrimDusk.ModPath .. "assets/bg/briefing.texture")

-- Drill
DB:create_entry(Idstring("texture"), Idstring("guis/textures/drill_screen_background"), CrimDusk.ModPath .. "assets/drill_screen_background.texture")

Global.CrimDusk:Init()