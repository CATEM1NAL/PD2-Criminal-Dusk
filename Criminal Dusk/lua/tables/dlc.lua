local FileIdent = "DLC"

local heist = Global.CrimDawn.tables.heists

-- Keys are DLC content, values are the target table.
local dlc_content = {

  -- Licensed content
  rvd = { cd_reservoir = heist.tier3, rvd = heist.dlc, dark = heist.tier4, mad = heist.tier5 },

  -- Armored Transport
  armored_transport = { arm_und = heist.tier1, arm_fac = heist.tier2,
                        arm_hcm = heist.tier2, arm_cro = heist.tier3,
                        arm_par = heist.tier4, arm_for = heist.tier5,
                        s552 = primary, ppk = secondary, m45 = secondary },

  -- Gage Weapon Pack
  gage_pack = { scar = primary, mp7 = secondary, p226 = secondary, frag = throwable },

  -- Gage LMG Pack
  gage_pack_lmg = { hk21 = primary, m249 = primary, rpk = primary,
                    gerber = melee, kampfmesser = melee, rambo = melee, kabar = melee },

  -- Gage Sniper Pack
  gage_pack_snp = { m95 = primary, msr = primary, r93 = primary },

  -- Big Bank
  big_bank = { big = heist.tier5,
               fal = primary },

  -- Gage Shotgun Pack
  gage_pack_shotgun = { benelli = primary, ksg = primary,
                        striker = secondary,
                        baton = melee, becker = melee, shovel = melee, tomahawk = melee },

  -- Gage Assault Pack
  gage_pack_assault = { famas = primary, galil = primary, g3 = primary, gre_m79 = primary,
                        bayonet = melee, bullseye = melee, dingdong = melee, x46 = melee },

  -- Hotline Miami (game)
  hlm_game = { briefcase = melee },

  -- Hotline Miami (heist)
  hl_miami = { cd_miami1 = heist.tier3, cd_miami2 = heist.tier4, mia = heist.dlc,
               scorpion = secondary, tec9 = secondary, uzi = secondary,
               bat = melee, cleaver = melee, fireaxe = melee, machete = melee },

  -- Gage Historical Pack
  gage_pack_historical = { mosin = primary, mg42 = primary,
                           c96 = secondary, sterling = secondary,
                           fairbair = melee, freedom = melee, model24 = melee, swagger = melee },

  -- Alienware Alpha Mauler
  alienware_alpha_promo = { alien_maul = melee },

  -- Clover Character Pack
  character_pack_clover = { l85a2 = primary,
                            shillelagh = melee,
                            burglar_dodge_1 = true, burglar_dodge_2 = true,
                            burglar_dodge_3 = true, burglar_prio_1 = true,
                            burglar_prio_2 = true, burglar_prio_3 = true,
                            burglar_bag_speed = true, burglar_lockpick_speed = true,
                            burglar_pager_speed = true, burglar_recovery = true },

  -- The Diamond
  hope_diamond = { mus = heist.tier5 },

  -- Dragan Character Pack
  character_pack_dragan = { vhs = primary,
                            meat_cleaver = melee,
                            infil_overdog = true, infil_single_dog_1 = true,
                            infil_single_dog_2 = true, infil_single_dog_3 = true,
                            infil_melee_boost = true, infil_melee_timer = true, infil_melee_heal = true },

  -- Bomb Heists
  the_bomb = { crojob1 = heist.tier4, crojob_wrapper = heist.tier4,
               hs2000 = secondary },

  -- Jacket Character Pack
  hlm2_deluxe = { cobray = secondary, hammer = melee,
                  infil_overdog = true, infil_melee_boost = true,
                  socio_armor_1 = true, socio_heal = true,
                  socio_armor_2 = true, socio_panic = true },

  -- Overkill Pack
  overkill_pack = { m134 = primary, rpg7 = secondary },

  -- Butcher BBQ Pack
  bbq = { flamethrower_mk2 = primary, m32 = primary, aa12 = primary,
          fork = melee, poker = melee, spatula = melee, tenderizer = melee,
          molotov = throwable },

  -- Western Pack
  west = { winchester1874 = primary, plainsrider = primary,
           peacemaker = secondary,
           bowie = melee, branding_iron = melee, mining_pick = melee, scalper = melee,
           dynamite = throwable },

  -- Alesso Heist
  arena = { arena = heist.tier5,
            mateba = secondary,
            detector = melee, microphone = melee, micstand = melee, oldbaton = melee },

  -- Sokol Character Pack
  character_pack_sokol = { asval = primary,
                           hockey = melee,
                           grind_hot_1 = true, grind_hot_2 = true,
                           grind_hot_3 = true, grind_hot_4 = true,
                           grind_hot_duration = true, grind_ap = true },

  -- Golden Grin Casino
  kenaz = { kenaz = heist.tier5,
            sub2000 = primary,
            croupier_rake = melee, slot_lever = melee, switchblade = melee, taser = melee },

  -- Gage Ninja Pack
  turtles = { wa2000 = primary,
              polymer = secondary, hunter = secondary,
              cqc = melee, fight = melee, tiger = melee, twins = melee,
              wpn_prj_four = throwable },

  -- Yakuza Character Pack
  dragon = { baka = secondary,
             sandsteel = melee,
             yakuza_recovery_1 = true, yakuza_recovery_2 = true,
             yakuza_recovery_3 = true, yakuza_speed = true,
             yakuza_threshold = true },

  -- Gage Chivalry Pack
  steel = { arblast = primary, frankish = primary, long = primary,
            beardy = melee, buck = melee, great = melee, morning = melee,
            wpn_prj_jav = throwable },

  -- Point Break Heists
  berry = { pbr = heist.tier3, pbr2 = heist.tier4,
            sparrow = secondary, iceaxe = melee, pugio = melee, selfie = melee, gator = melee },

  -- Goat Simulator
  peta = { cd_goat1 = heist.tier3, cd_goat2 = heist.tier4, peta = heist.dlc,
           m37 = secondary,
           pitchfork = melee, scoutknife = melee, shawn = melee, stick = melee },

  -- Wolf Pack
  pal = { pal = heist.tier2, man = heist.tier4,
          china = secondary,
          nin = melee },

  -- Sydney Character Pack
  opera = { tecci = primary,
            wing = melee,
            anarch_recovery = true, anarch_armour_1 = true,
            anarch_armour_2 = true, anarch_armour_3 = true,
            anarch_bullseye = true },

  -- Biker Character Pack
  wild = { boot = primary,
           road = melee,
           biker_base = true, biker_armour_plus = true,
           biker_health_cd = true, biker_health_plus = true,
           biker_armour_cd = true },

  -- Biker Heist
  born = { cd_biker1 = heist.tier3 ,cd_biker2 = heist.tier1, born = heist.dlc,
           hajk = secondary,
           wpn_prj_hur = throwable },

  -- John Wick Weapon Pack
  pim = { desertfox = primary, x_packrat = akimbo,
          packrat = secondary, schakal = secondary,
          wpn_prj_target = throwable },

  -- Gage Spec Ops Pack
  tango = { arbiter = secondary },

  -- Scarface Character Pack
  chico = { contraband = primary, cs = melee,
            kingpin_base = true, kingpin_prio = true,
            kingpin_immunity = true, kingpin_cd = true },

  -- Scarface Mansion
  friend = { friend = heist.tier5,
             ray = secondary,
             brick = melee },

  -- John Wick Heists Pack
  spa = { spa = heist.tier3, fish = heist.tier4,
          tti = primary,
          catch = melee },

  -- Gage Russian Weapon Pack
  grv = { flint = primary, siltstone = primary,
          coal = secondary,
          oxide = melee },

  -- Pencil Melee
  pn2 = { sword = melee },

  -- h3h3 Character Pack
  ecp = { ecp = primary,
          meter = melee,
          h3h3_base = true, h3h3_cd = true, h3h3_absorption = true },

  -- Border Crossing
  mex = { mex = heist.tier5, mex_cooking = heist.tier5 },

  -- San Martin Bank
  bex = { bex = heist.tier4 },

  -- Federales Weapon Pack
  afp = { x_beer = akimbo, x_czech = akimbo, x_stech = akimbo,
           beer = secondary, czech = secondary, stech = secondary },

  -- Breakfast in Tijuana
  pex = { pex = heist.tier2 },

  -- Fugitive Weapon Pack
  atw = { m60 = primary, r700 = primary, x_holt = akimbo,
          holt = secondary },

  -- Buluc's Mansion
  fex = { fex = heist.tier5 },

  -- Gunslinger Weapon Pack
  mxw = { sbl = primary, m1897 = primary, x_model3 = akimbo,
          model3 = secondary },

  -- Dragon Heist
  chas = { chas = heist.tier2 },

  -- Jiu Feng Smuggler Pack
  fawp = { m590 = primary, x_m1911 = akimbo, x_vityaz = akimbo,
           m1911 = secondary, vityaz = secondary },

  -- Jiu Feng Smuggler Pack 2
  sawp = { groza = primary, qbu88 = primary, x_pm9 = akimbo,
           pm9 = secondary },

  -- Shock Grenade
  sawp_grenade = { wpn_gre_electric = throwable },

  -- Black Cat
  chca = { chca = heist.tier4 },

  -- Jiu Feng Smuggler Pack 3
  tawp = { shak12 = primary, x_type54 = akimbo,
            rsh12 = secondary, type54 = secondary },

  -- Mountain Master
  pent = { pent = heist.tier5 },

  -- Jiu Feng Smuggler Pack 4
  lawp = { x_maxim9 = akimbo,
           fmg9 = secondary, ultima = secondary, maxim9 = secondary },

  -- Midland Ranch
  ranc = { ranc = heist.tier3 },

  -- McShay Weapon Pack
  pxp1 = { hk51b = primary,
           scout = secondary, ms3gl = secondary },

  -- McShay Mod Pack
  mxm = { sticky_grenade = throwable },

  -- McShay Weapon Pack 2
  pxp2 = { x_korth = akimbo, sko12 = primary, x_sko12 = akimbo, hailstorm = primary,
            korth = secondary  }, -- why is there an akimbo variant of a primary weapon.

  -- Hostile Takeover
  corp = { corp = heist.tier5 },

  -- McShay Weapon Pack 3
  pxp3 = { tkb = primary, hcar = primary,
           contender = secondary },

  -- Crude Awakening
  deep = { deep = heist.tier6 },

  -- McShay Weapon Pack 4
  pxp4 = { supernova = primary, kacchainsaw = primary, awp = primary },

  -- Espionage Weapon Pack
  esp = { x_pmm = akimbo,
          pmm = secondary, speen = secondary, dart = secondary },
}

-- To avoid distributing unowned content, test for a DLC unlocker
local DLCIndex = {}
for dlc, _ in pairs(dlc_content) do table.insert(DLCIndex, dlc) end
local FakeDLC = DLCIndex[math.random(#DLCIndex)] .. math.random(4)
if managers.dlc:_check_dlc_data(FakeDLC) then Global.CrimDawn.DLC = true
  CrimDawn.Log(FileIdent, "Found DLC unlocker")
end

if not Global.CrimDawn.DLC then -- Only apply DLC if ownership can be verified
  for dlc, _ in pairs(dlc_content) do
    if managers.dlc:is_dlc_unlocked(dlc) then CrimDawn.Log(FileIdent, "Found DLC " .. dlc)
      for dlc_item, dlc_target in pairs(dlc_content[dlc]) do
        if type(dlc_target) == "boolean" then
          Global.CrimDawn.tables.upgrades.perks[dlc_item]["dlc_owned"] = dlc_target
        else table.insert(dlc_target, dlc_item)
        end
      end
    end
  end
end