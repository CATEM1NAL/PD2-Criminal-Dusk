Hooks:PostHook(IngameStandardState, "at_enter", "CrimDusk_HostForceLoud", function()
  if Global.CrimDusk.StealthableHeists[Global.game_settings.level_id] or managers.groupai:state():is_police_called() then return end
  if NetworkHelper:IsClient() then NetworkHelper:SendToPeer(1, "CrimDusk_MaskedUp", true) return end

  managers.groupai:state():on_police_called("empty")
end)