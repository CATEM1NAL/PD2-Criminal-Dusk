Hooks:OverrideFunction(GenericDLCManager, "is_content_skirmish_locked", function() return false end)
Hooks:OverrideFunction(GenericDLCManager, "is_content_crimespree_locked", function() return false end)

Hooks:PostHook(GenericDLCManager, "has_dlc", "CrimDusk_GiveCommunityItems", function(self, dlc)
  if dlc == "pd2_clan" then return true end
end)

-- Unlocked characters
Hooks:OverrideFunction(GenericDLCManager, "has_freed_old_hoxton", function() return Global.CrimDusk.data["heists_won" .. CrimDusk.IsPermadeath()] < 5 or Global.CrimDusk.data.free_hoxton > 3 end)
function GenericDLCManager:has_wild_char() return Global.CrimDusk.data["rust_recruited" .. CrimDusk.IsPermadeath()] end