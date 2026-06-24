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

  -- Difficulty scaling
  function self.DiffScale(ignore_cap)
    if (Global.CrimDusk.data.heists_won or 0) < 6 then
      return Global.CrimDusk.data.heists_won + 2
    end

    local HeistsWon = Global.CrimDusk.data.heists_won - 6
    local RawDiff = HeistsWon / (#Global.CrimDusk.campaign - 6) * 7 + 2
    local RoundedDiff = math.floor(RawDiff + 0.5)

    if ignore_cap then return RoundedDiff end
    return math.min(RoundedDiff, 8)
  end

  -- Reset campaign state
  function self:Reset()
    Global.CrimDusk.data = { heists_won = 0, lives = 5 }
  end
end

CrimDusk:Init()

if Global.CrimDusk and (Global.CrimDusk.data.heists_won or 0) < 6 then
  Hooks:Add("LocalizationManagerPostInit", "CrimDusk_PDTHNames", function(loc)
    loc:load_localization_file(CrimDusk.ModPath .. "loc/pdth_difficulties.json")
  end)
end

local function SetColours()
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

  tweak_data.system_chat_color = Global.CrimDusk.archicolours.orange

  tweak_data.screen_colors.resource = Global.CrimDusk.archicolours.red
  tweak_data.screen_colors.button_stage_2 = Global.CrimDusk.archicolours.orange
  tweak_data.screen_colors.button_stage_3 = Global.CrimDusk.archicolours.red
  tweak_data.screen_colors.risk = Global.CrimDusk.archicolours.yellow
  tweak_data.screen_colors.ghost_color = Global.CrimDusk.archicolours.red
end

if Global.CrimDusk then SetColours() end

-- THIS SECTION ONLY RUNS ONCE ON GAME LAUNCH --
if Global.CrimDusk then return end
Global.CrimDusk = {
  regen_time = { 0.5, 1, 2, 3, 4.5, 6, 7.5 },

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
  local ModVersion = BLT.Mods:GetModByName("Criminal Dusk").version
  CrimDusk.Log(FileIdent, "Playing Criminal Dusk v" .. ModVersion)
  CrimDusk.Log(FileIdent, "Attempting to load save file...")
  self.data = io.load_as_json(CrimDusk.SaveFile)

  if not self.data then
    CrimDusk:Reset()
    CrimDusk:WriteSave(FileIdent, "save created")
  end

  self.campaign = {
    "red2", "flat", "dinner", "pal", "man", "nmh", -- PDTH Prologue
    "cd_tut1", "cd_tut2", "cd_tut3", "four_stores", "mallcrasher", "branchbank_prof", "ukrainian_job_prof", "nightclub", -- Early Vlad
    "cd_watchdogs1", "cd_watchdogs2", "cd_frame3", "cd_bigoil", "cd_firestarter1", "cd_firestarter2", "alex", -- Hector/Elephant
    "family", "arm_wrapper", "arm_for", "roberts", "cd_erection_wrapper", "kosugi", -- Post Launch
    "big", "cd_miami1", "cd_miami2", "gallery", "cd_hox1", "cd_hox2", "pines", "mus", -- Dentist
    "cd_bomb", "cage", "hox_3", "shoutout_raid", "arena", "kenaz", "jolly", "pbr", "pbr2", "cane", -- 2015
    "cd_goat1", "cd_goat2", "dark", "mad", "cd_biker1", "cd_biker2", "moon", "friend", -- 2016
    "spa", "fish", "run", "glace", "wwh", "dah", "cd_reservoir", "brb", "tag", "des", "sah", -- Final Arc
    "mex", "chas", "bex", "sand", "pex", "chca", "fex", "pent", "bph", "ranc", "trai", "corp", -- Bopocalypse
    "vit", "deep" -- Conclusion
  }

  SetColours()
end

-- Logo replacements
DB:create_entry(Idstring("texture"), Idstring("guis/textures/menu_title_screen"), CrimDusk.ModPath .. "assets/logo/title.texture")
DB:create_entry(Idstring("texture"), Idstring("guis/textures/game_small_logo"), CrimDusk.ModPath .. "assets/logo/small.texture")
DB:create_entry(Idstring("texture"), Idstring("units/menu/menu_scene/menu_cylinder_logo"), CrimDusk.ModPath .. "assets/logo/menu.texture")

for i = 0, 6 do -- Safehouse frames
  DB:create_entry(Idstring("texture"), Idstring("crimdawn/safehouse" .. i), CrimDusk.ModPath .. "assets/safehouse/tier" .. i .. ".texture")
end

-- Background replacements
--DB:create_entry(Idstring("texture"), Idstring("guis/textures/loading/loading-bg"), CrimDusk.ModPath .. "assets/bg/loading.texture")
DB:create_entry(Idstring("texture"), Idstring("guis/textures/pd2/menu_backdrop/bd_baselayer"), CrimDusk.ModPath .. "assets/bg/briefing.texture")

-- Drill
DB:create_entry(Idstring("texture"), Idstring("guis/textures/drill_screen_background"), CrimDusk.ModPath .. "assets/drill_screen_background.texture")

Global.CrimDusk:Init()