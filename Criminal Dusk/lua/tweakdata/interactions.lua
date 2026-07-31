Hooks:PostHook(InteractionTweakData, "init", "CrimDusk_InteractionTweakInit", function(self)
  -- ALL instant interactions can be performed unmasked
  for interaction, _ in pairs(self) do
    if type(self[interaction]) == "table" then
      if self[interaction].requires_upgrade then self[interaction].requires_mask_off_upgrade = self[interaction].requires_upgrade
      else self[interaction].requires_mask_off_upgrade = { category = "player", upgrade = "mask_off_pickup" } end
    end
  end

end)