Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "CrimDawn_ProjectileTweakInit", function(self, tweak_data)
  self.projectiles.wpn_prj_ace.max_amount = 1

  local throwables = {
    [12] = { laser_watch = 10, xmas_snowball = 2 },
    [30] = { concussion = 1, fir_com = 2 },
    [45] = { frag_com = 2, frag = 1, dada_com = 1 },
    [60] = { wpn_gre_electric = 1, sticky_grenade = 1, dynamite = 1 },
    [75] = { molotov = 1, poison_gas_grenade = 1 }
  }

  for regen, category in pairs(throwables) do
    for weapon, count in pairs(category) do
      self.projectiles[weapon].base_cooldown = regen
      self.projectiles[weapon].max_amount = count
    end
  end
end)