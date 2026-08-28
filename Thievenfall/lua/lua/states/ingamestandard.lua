Hooks:PostHook(IngameStandardState, "at_enter", "CrimDusk_HostForceLoud", function()
  Hooks:RemovePostHook("CrimDusk_HostForceLoud")
  if NetworkHelper:IsClient() then NetworkHelper:SendToPeer(1, "CrimDusk_MaskedUp", true) return end
  CrimDusk.GoLoud()
end)