--[[ **PAYDAY 2: Thievenfall**
**Copyright (C) 2026  ~/cat/em1/nal/**

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>. ]]

if CrimDusk then return end
local FileIdent = "Setup"
CrimDusk = {}

function CrimDusk:Init()
  self.ModPath = ModPath
  self.SavePath = SavePath

  self.SaveFile = self.SavePath .. "thievenfall_save.txt"
  self.SettingsFile = self.SavePath .. "thievenfall_settings.txt"

  self.SettingsData = io.load_as_json(CrimDusk.SettingsFile) or {}
  if not self.SettingsData then self.SettingsData = {} end

  MenuHelper:LoadFromJsonFile(self.ModPath .. "menus/settings.json", self, self.SettingsData)

  self.state = { heist_started = false }

  -- Helper functions
  function self.Log(FileIdent, LogMessage)
    log("[THIEVENFALL>" .. FileIdent .. "] " .. LogMessage)
  end -- Yes, this WILL crash without a FileIdent. This is intentional.

  function self.ChatNotify(message)
    if not managers.chat then return end
    managers.chat:_receive_message(ChatManager.GAME, "THIEVENFALL", message, Global.CrimDusk.archicolours.orange)
  end

  function self:WriteSave(FileIdent, SaveReason)
    io.save_as_json(Global.CrimDusk.data, self.SaveFile)
    self.Log(FileIdent, "Saved " .. self.SaveFile .. " (" .. SaveReason .. ")")
  end -- Yes, this WILL crash without a FileIdent or SaveReason. This is intentional.

  function self.GoLoud()
    CrimDusk.Log(FileIdent, "Level ID: " .. Global.game_settings.level_id)
    local LoudDelay = Global.CrimDusk.heists[Global.game_settings.level_id].delay or 3
    DelayedCalls:Add("CrimDusk_GoLoudDelay", LoudDelay, function() managers.groupai:state():on_police_called("empty") end)
  end

  -- Play button text
  function self.PlayButtonLoc()
    local campaign = CrimDusk.SettingsData.permadeath and "heists_won_perma" or "heists_won"
    if Global.CrimDusk.campaign[Global.CrimDusk.data[campaign] + 1] then
      managers.localization:add_localized_strings({
        ["crimdusk_continue_run_desc"] = managers.localization:text("crimdusk_play_next_desc", {
          HEIST = managers.localization:text("heist_" .. Global.CrimDusk.campaign[Global.CrimDusk.data[campaign] + 1])
        }),
        ["menu_choose_new_contract"] = managers.localization:text("crimdusk_campaign_active", {
          HEIST = managers.localization:text("heist_" .. Global.CrimDusk.campaign[Global.CrimDusk.data[campaign] + 1])
        })
      })
    else managers.localization:add_localized_strings({
        ["crimdusk_continue_run_desc"] = managers.localization:text("crimdusk_play_next_random"),
        ["menu_choose_new_contract"] = managers.localization:text("crimdusk_campaign_inactive")
      })
    end

    local HeistNumText = ""
    local IsEndless = Global.CrimDusk.data[campaign] >= #Global.CrimDusk.campaign
    if IsEndless then HeistNumText = (Global.CrimDusk.data[campaign] + 1)
    else HeistNumText = Global.CrimDusk.data[campaign] + 1 .. "/" .. #Global.CrimDusk.campaign end
    managers.localization:add_localized_strings({
      ["crimdusk_continue_run_title"] = managers.localization:text("crimdusk_play_next_title", {
        HEIST_NUM = HeistNumText
      })
    })
  end

  -- Difficulty scaling
  function self.DiffScale(ignore_cap)
    local campaign = CrimDusk.SettingsData.permadeath and "heists_won_perma" or "heists_won"
    if (Global.CrimDusk.data[campaign] or 0) < 5 then return Global.CrimDusk.data[campaign] + 2 end

    local HeistsWon = Global.CrimDusk.data[campaign] - 5
    local RawDiff = HeistsWon / (#Global.CrimDusk.campaign - 5) * 7 + 2
    local RoundedDiff = math.floor(RawDiff + 0.5)

    if ignore_cap then return RoundedDiff end
    return math.min(RoundedDiff, 8)
  end

  -- Reset campaign state
  function self:Reset()
    Global.CrimDusk.data = {
      heists_won = 0, heist_chain = {},
      heists_won_perma = 0, heist_chain_perma = {},
      lives = 4, winters_dead = false
    }
  end
end

CrimDusk:Init()

local campaign = CrimDusk.SettingsData.permadeath and "heists_won_perma" or "heists_won"
if NetworkHelper:IsHost() and Global.CrimDusk and (Global.CrimDusk.data[campaign] or 0) < 5 then
  Hooks:Add("LocalizationManagerPostInit", "CrimDusk_PDTHNames", function(loc)
    loc:add_localized_strings({
      ["menu_difficulty_normal"] = loc:text("crimdusk_pdth_normal"),
      ["menu_asset_risklevel_0"] = loc:text("crimdusk_pdth_normal"),
      ["menu_difficulty_hard"] = loc:text("crimdusk_pdth_hard"),
      ["menu_asset_risklevel_1"] = loc:text("crimdusk_pdth_hard"),
      ["menu_difficulty_very_hard"] = loc:text("crimdusk_pdth_very_hard"),
      ["menu_asset_risklevel_2"] = loc:text("crimdusk_pdth_very_hard"),
      ["menu_difficulty_easy_wish"] = loc:text("crimdusk_pdth_mayhem"),
      ["menu_asset_risklevel_4"] = loc:text("crimdusk_pdth_mayhem")
    })
  end)
end

if NetworkHelper:IsClient() then NetworkHelper:SendToPeer(1, "CrimDusk_RequestHeistCount", true) end

-- THIS SECTION ONLY RUNS ONCE ON GAME LAUNCH --
if Global.CrimDusk then return end
Global.CrimDusk = {
  regen_time = { 0.5, 0.5, 1.5, 2.5, 4.5, 6, 7.5 },
  friendly_fire = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.75, 1 },

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
  self.ModVersion = BeardLib.Utils:FindMod("Thievenfall").AssetUpdates.version
  CrimDusk.Log(FileIdent, "Playing Thievenfall v" .. self.ModVersion)
  CrimDusk.Log(FileIdent, "Attempting to load save file...")
  self.data = io.load_as_json(CrimDusk.SaveFile)

  if not self.data then
    CrimDusk:Reset()
    CrimDusk:WriteSave(FileIdent, "save created")
  end

  -- tweakdata modification tables
  dofile(CrimDusk.ModPath .. "lua/tables/melee.lua" )
  dofile(CrimDusk.ModPath .. "lua/tables/weapons.lua" )
  dofile(CrimDusk.ModPath .. "lua/tables/heists.lua" )

  -- Data validation
  self.data.heists_won = self.data.heists_won or 0
  self.data.heist_chain = self.data.heist_chain or {}
  self.data.heists_won_perma = self.data.heists_won_perma or 0
  self.data.heist_chain_perma = self.data.heist_chain_perma or {}
  self.data.lives = self.data.lives or 4

  self.campaign = {
    "red2", "flat", "pal", "man", "nmh", -- PDTH Prologue
    "cd_tut1", "cd_tut2", "cd_tut3", "four_stores", "mallcrasher", "branchbank_prof", "ukrainian_job_prof", "nightclub", -- Early Vlad
    "cd_watchdogs1_wrapper", "cd_watchdogs2_wrapper", "cd_frame3", "cd_bigoil", "cd_firestarter1", "cd_firestarter2", "cd_rats", -- Hector/Elephant
    "family", "arm_wrapper", "arm_for", "roberts", "cd_erection_wrapper", "kosugi", -- Post Launch
    "big", "cd_miami1", "cd_miami2", "gallery", "cd_hox1", "cd_hox2", "pines", "mus", -- Dentist
    "cd_bomb", "cage", "hox_3", "shoutout_raid", "arena", "kenaz", "jolly", "dinner", "pbr", "pbr2", "cane", -- 2015
    "cd_goat1", "cd_goat2", "dark", "mad", "cd_biker1", "cd_biker2", "moon", "friend", -- 2016
    "spa", "fish", "run", "glace", "wwh", "dah", "cd_reservoir", "brb", "tag", "des", "sah", -- Final Arc
    "mex", "chas", "bex", "sand", "pex", "chca", "fex", "pent", "bph", "ranc", "trai", "corp", -- Bopocalypse
    "deep", "vit" -- Conclusion
  }
  self.extra_heists = {
    "hvh", "help", "rat", "nail", "haunted"
  }
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