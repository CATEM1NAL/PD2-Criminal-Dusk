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
tweak_data.experience_manager.difficulty_multiplier = { 1, 1.5, 2, 2.5, 3, 3.5, 4 }
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