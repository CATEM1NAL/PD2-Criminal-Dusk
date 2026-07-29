Hooks:PostHook(IngameStandardState, "at_enter", "CrimDusk_HostForceLoud", function()
  log(Global.game_settings.level_id)
  if Global.CrimDusk.StealthableHeists[Global.game_settings.level_id] or managers.groupai:state():is_police_called() then return end
  if NetworkHelper:IsClient() then NetworkHelper:SendToPeer(1, "CrimDusk_MaskedUp", true) return end
  CrimDusk.GoLoud()
end)