if CrimDawn then return end
local FileIdent = "Setup"
CrimDawn = {}

function CrimDawn:Init()
  self.ModPath = ModPath
  self.SavePath = SavePath

  self.SaveFile = self.SavePath .. "crimdawn_save.txt"
  self.SettingsFile = self.SavePath .. "crimdusk_settings.txt"

  self.SettingsData = io.load_as_json(CrimDawn.SettingsFile) or {}
  if not self.SettingsData then self.SettingsData = {} end

  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/settings.json", self, self.SettingsData)
  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/heist1.json", self, self.SettingsData)
  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/heist2.json", self, self.SettingsData)
  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/heist3.json", self, self.SettingsData)
  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/heist4.json", self, self.SettingsData)
  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/heist5.json", self, self.SettingsData)

  -- Disable stealth-only heists by default
  if not self.SettingsData.kosugi then self.SettingsData.kosugi = false end
  if not self.SettingsData.cage then self.SettingsData.cage = false end
  if not self.SettingsData.dark then self.SettingsData.dark = false end
  if not self.SettingsData.fish then self.SettingsData.fish = false end
  if not self.SettingsData.tag then self.SettingsData.tag = false end

  self.state = { maskup_time = false,
                 heist_started = false,
                 cap_reached = false,
                 upg_queue = {} }

  -- Helper functions
  function self.Log(FileIdent, LogMessage)
    log("[DAWN>" .. FileIdent .. "] " .. LogMessage)
  end -- Yes, this WILL crash without a FileIdent. This is intentional.

  function self.ScoreNeeded()
    local n = math.ceil((math.sqrt(1 + 8 * (Global.CrimDawn.data.game.score) - 1) / 2))
    return (n * (n + 1) / 2) - math.floor(Global.CrimDawn.data.game.score)
  end

  function self.GoMode()
  return Global.CrimDawn.data.game.progression_items >= Global.CrimDawn.data.game.max_progression_items end

  function self.OnFinalHeist()
    local RunLength = Global.CrimDawn.data.game.run_length
    local HeistsWon = Global.CrimDawn.data.game.heists_won
    local HeistNum = #Global.CrimDawn.data.game.heists
  return HeistsWon < RunLength and HeistNum == RunLength end

  function self.InfiniteTime()
  return CrimDawn.SettingsData.inftime and CrimDawn.GoMode() end

  function self.TimeFromUpgrade()
    local TimePerUpgrade = { 6, 18, 26, 36, 44, 48, 90 }
    local RunLength = Global.CrimDawn.data.game.run_length
    if RunLength == 0 then RunLength = 7 end
  return TimePerUpgrade[RunLength] end

  function self.ChatNotify(message)
    if not managers.chat then return end
    managers.chat:_receive_message(ChatManager.GAME, "CRIMINAL DAWN", message, Global.CrimDawn.archicolours.orange)
  end

  function self:WriteSave(FileIdent, SaveReason)
    if not self.CorrectSaveLoaded() then return end
    io.save_as_json(Global.CrimDawn.data, self.SaveFile)
    self.Log(FileIdent, "Saved " .. self.SaveFile .. " (" .. SaveReason .. ")")
  end -- Yes, this WILL crash without a FileIdent or SaveReason. This is intentional.

  function self.CorrectSaveLoaded()
    local SaveSeed, SaveSlot = Global.CrimDawn.data.game.seed, Global.CrimDawn.data.game.slot
    local ClientSeed, ClientSlot = CrimDawnClient.data.seed, CrimDawnClient.data.slot
    if SaveSeed == ClientSeed and SaveSlot == ClientSlot then return true
    else CrimDawn.Log(FileIdent, "Save is invalid!") return false end
  end

  function self:RunReset(FileIdent)
    Global.CrimDawn.data.upgrades = {}

    -- Generate new random upgrades
    self:RandomUpgrade(Global.CrimDawn.data.x.skills, "skills")
    self:RandomUpgrade(Global.CrimDawn.data.x.perks, "perks")
    self:RandomUpgrade(Global.CrimDawn.data.x.stats, "stats")
    
    local DeployableUpgrades = 0
    for _, deployable in ipairs(Global.CrimDawn.tables.etc.deployables) do
      if Global.CrimDawn.data.unlocks[deployable] then DeployableUpgrades = DeployableUpgrades + 1 end
    end

    self:RandomUpgrade(DeployableUpgrades, "deployable")

    -- Setup next run
    if NetworkHelper:IsHost() then
      Global.CrimDawn.data.game.run = Global.CrimDawn.data.game.run + 1
      Global.CrimDawn.data.game.ponr = false
      Global.CrimDawn.data.game.previous_run = {}

      local skip = { vit = true, deep = true, cd_28stores = true }
      for _, heist in ipairs(Global.CrimDawn.data.game.heists) do
        if not skip[heist] then Global.CrimDawn.data.game.previous_run[heist] = true end
      end

      Global.CrimDawn.data.game.heists = {}
    end

    Global.CrimDawn.data.x.lives = Global.CrimDawn.data.x.max_lives

    self:WriteSave(FileIdent, "run failed")
  end

  -- Difficulty scaling
  function self.DiffScale(ignore_settings, max_value)
    if not Global.CrimDawn.data.game.max_progression_items then return 0 end

    local RunLength = Global.CrimDawn.data.game.run_length
    if RunLength == 0 then RunLength = 6 end
    if max_value then RunLength = max_value end

    local MaxDiff = ignore_settings and RunLength or CrimDawn.SettingsData.diff_cap
    local ItemCount = Global.CrimDawn.data.game.progression_items
    local MaxItems = Global.CrimDawn.data.game.max_progression_items

    return math.max(math.floor(ItemCount / (MaxItems / MaxDiff)), 0)
  end

  local function CalculateDiff(offset)
    local DiffCap = CrimDawn.SettingsData.diff_cap
    local HeistNum = #Global.CrimDawn.data.game.heists - offset
    local RunLength = Global.CrimDawn.data.game.run_length
    if RunLength == 0 then RunLength = 6 end

    -- Any questions about this equation should be directed to @jordansds
    local BaseDiff = (1 + HeistNum / RunLength) * (1 + (HeistNum + CrimDawn.DiffScale()) / RunLength) * 2
    return math.max(math.min(math.floor(BaseDiff), 8) + (DiffCap - 7), 2)
  end

  function self.DiffIndex()
    if #Global.CrimDawn.data.game.heists == 1 then return CalculateDiff(0)
    else return math.min(CalculateDiff(0), CalculateDiff(1) + 1) end
  end

  -- Score cap
  function self.CalculateScoreCap()
    if not Global.CrimDawn then return 0 end
    local state = Global.CrimDawn.data.game

    for i = 1, state.max_score_checks do
      local ReqItems = (i - 1) * state.max_progression_items / state.max_score_checks
      if ReqItems > state.progression_items + 1 then return (i - 1) * i / 2 end
    end

  return state.max_score_checks * (state.max_score_checks + 1) / 2 end

  function self.IsScoreCapped(points)
    local NewScore = Global.CrimDawn.data.game.score + points
    if NewScore >= CrimDawn.CalculateScoreCap() then CrimDawnClient:PollProgression() end
    local ScoreCap = CrimDawn.CalculateScoreCap()
    if NewScore >= ScoreCap then
      Global.CrimDawn.data.game.score = ScoreCap
      CrimDawn.state.cap_reached = true

      local hint = managers.localization:text("crimdawn_chat_score_cap_hint")
      if CrimDawn.GoMode() then hint = "" end

      CrimDawn.ChatNotify(managers.localization:text("crimdawn_chat_score_capped", {
        SCORE_ICON = "",
        SCORE_CAP = ScoreCap,
        HINT = hint
      }))
      return true

    else Global.CrimDawn.data.game.score = NewScore return false end
  end

  -- Wipe save data
  function self:Reset()
    Global.CrimDawn.data = {
      upgrades = {},
      unlocks = {},

      x = {
        bots = 0, skills = 0, permaskills = 0, perks = 0, permaperks = 0,
        max_lives = 1, lives = 1, stats = 0, saws = 0, coins = 0
      },

      game = {
        seed = false, slot = false, max_progression_items = false, run_length = 0, inf_time = false, score = 0, f_score = 0,
        max_score_checks = 0, ponr = false, deathlink_in = os.time(), deathlink_out = 0, previous_run = {}, run = 1,
        heists_won = 0, heists = {}, cash = 0, goal = false, campaign = false, progression_items = 0
      },

      chat = { message = "", timestamp = 0 },
      safehouse = {}
    }
  end

  if Global.CrimDawn then Global.CrimDawn.data.chat = { message = "", timestamp = 0 } end
end

CrimDawn:Init()

local function SetColours()
  local player1 = Global.CrimDawn.archicolours.blue
  local player2 = Global.CrimDawn.archicolours.pink
  local player3 = Global.CrimDawn.archicolours.red
  local player4 = Global.CrimDawn.archicolours.yellow
  local team_ai = Global.CrimDawn.archicolours.orange

  tweak_data.peer_vector_colors[1] = player1
  tweak_data.chat_colors[1] = player1
  tweak_data.preplanning_peer_colors[1] = Global.CrimDawn.archicolours.blue_alt

  tweak_data.peer_vector_colors[2] = player2
  tweak_data.chat_colors[2] = player2
  tweak_data.preplanning_peer_colors[2] = Global.CrimDawn.archicolours.pink_alt

  tweak_data.peer_vector_colors[3] = player3
  tweak_data.chat_colors[3] = player3
  tweak_data.preplanning_peer_colors[3] = Global.CrimDawn.archicolours.red_alt

  tweak_data.peer_vector_colors[4] = player4
  tweak_data.chat_colors[4] = player4
  tweak_data.preplanning_peer_colors[4] = Global.CrimDawn.archicolours.yellow_alt

  tweak_data.peer_vector_colors[5] = team_ai
  tweak_data.chat_colors[5] = team_ai

  tweak_data.system_chat_color = Global.CrimDawn.archicolours.orange

  tweak_data.screen_colors.resource = Global.CrimDawn.archicolours.red
  tweak_data.screen_colors.button_stage_2 = Global.CrimDawn.archicolours.orange
  tweak_data.screen_colors.button_stage_3 = Global.CrimDawn.archicolours.red
  tweak_data.screen_colors.risk = Global.CrimDawn.archicolours.yellow
  tweak_data.screen_colors.ghost_color = Global.CrimDawn.archicolours.red
end

if Global.CrimDawn then SetColours() end

-- THIS SECTION ONLY RUNS ONCE ON GAME LAUNCH --
if Global.CrimDawn then return end
Global.CrimDawn = {
  tables = {},

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

function Global.CrimDawn:Init()
  local ModVersion = BLT.Mods:GetModByName("Criminal Dusk").version
  CrimDawn.Log(FileIdent, "Playing Criminal Dusk v" .. ModVersion)
  CrimDawn.Log(FileIdent, "Attempting to load save file...")
  self.data = io.load_as_json(CrimDawn.SaveFile)

  if not self.data then
    CrimDawn:Reset()
  end

  self.data.game.deathlink_in = os.time()
  dofile(CrimDawn.ModPath .. "lua/tables/etc.lua")

  SetColours()
end

-- Logo replacements
DB:create_entry(Idstring("texture"), Idstring("guis/textures/menu_title_screen"), CrimDawn.ModPath .. "assets/logo/title.texture")
DB:create_entry(Idstring("texture"), Idstring("guis/textures/game_small_logo"), CrimDawn.ModPath .. "assets/logo/small.texture")
DB:create_entry(Idstring("texture"), Idstring("units/menu/menu_scene/menu_cylinder_logo"), CrimDawn.ModPath .. "assets/logo/menu.texture")

for i = 0, 6 do -- Safehouse frames
  DB:create_entry(Idstring("texture"), Idstring("crimdawn/safehouse" .. i), CrimDawn.ModPath .. "assets/safehouse/tier" .. i .. ".texture")
end

-- Background replacements
--DB:create_entry(Idstring("texture"), Idstring("guis/textures/loading/loading-bg"), CrimDawn.ModPath .. "assets/bg/loading.texture")
DB:create_entry(Idstring("texture"), Idstring("guis/textures/pd2/menu_backdrop/bd_baselayer"), CrimDawn.ModPath .. "assets/bg/briefing.texture")

-- Drill
DB:create_entry(Idstring("texture"), Idstring("guis/textures/drill_screen_background"), CrimDawn.ModPath .. "assets/drill_screen_background.texture")

Global.CrimDawn:Init()