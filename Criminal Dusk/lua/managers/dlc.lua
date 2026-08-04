Hooks:OverrideFunction(GenericDLCManager, "is_content_skirmish_locked", function() return false end)
Hooks:OverrideFunction(GenericDLCManager, "is_content_crimespree_locked", function() return false end)

Hooks:PostHook(GenericDLCManager, "has_dlc", "CrimDusk_GiveCommunityItems", function(self, dlc)
  if dlc == "pd2_clan" then return true end
end)