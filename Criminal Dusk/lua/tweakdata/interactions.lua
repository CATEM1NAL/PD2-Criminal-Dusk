Hooks:PostHook(InteractionTweakData, "init", "CrimDusk_InteractionTweakInit", function(self)
  -- ALL instant interactions can be performed unmasked
  for interaction, _ in pairs(self) do
    if type(self[interaction]) == "table" then
      self[interaction].requires_mask_off_upgrade = { category = "player", upgrade = "mask_off_pickup" }
    end
  end

end)