Hooks:PostHook(AmmoBagBase, "init", "CrimDusk_InitAmmoBag", function(self)
  self._max_ammo_amount = tweak_data.upgrades.ammo_bag_base
end)