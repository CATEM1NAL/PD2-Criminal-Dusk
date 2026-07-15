Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "CrimDusk_ProjectileTweakInit", function(self, tweak_data)
  self.projectiles.wpn_prj_ace.max_amount = 1

  local throwables = {
    [12] = { xmas_snowball = 2 },
    [30] = { laser_watch = 8, wpn_gre_electric = 1, concussion = 2, fir_com = 2, chico_injector = 1 },
    [45] = { frag_com = 2, frag = 1, dada_com = 1, copr_ability = 1 },
    [60] = { sticky_grenade = 1, dynamite = 1, tag_team = 1 },
    [75] = { molotov = 1, poison_gas_grenade = 1, smoke_screen_grenade = 1 },
    [120] = { pocket_ecm_jammer = 2 }
  }

  for regen, category in pairs(throwables) do
    for weapon, count in pairs(category) do
      self.projectiles[weapon].base_cooldown = regen
      self.projectiles[weapon].max_amount = count
      self.projectiles[weapon].ignore_auto_equip = true
    end
  end
end)