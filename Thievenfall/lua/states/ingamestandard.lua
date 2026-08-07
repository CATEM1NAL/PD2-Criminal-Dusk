Hooks:PostHook(IngameStandardState, "at_enter", "CrimDusk_HostForceLoud", function()
  if Global.CrimDusk.heists[Global.game_settings.level_id].stealthable or managers.groupai:state():is_police_called() then return end
  if NetworkHelper:IsClient() then NetworkHelper:SendToPeer(1, "CrimDusk_MaskedUp", true) return end
  CrimDusk.GoLoud()
end)