-- Unlock content that is inaccessible in Criminal Dawn & achievement locked content that impacts gameplay
Hooks:OverrideFunction(GenericDLCManager, "is_content_skirmish_locked", function() return false end)
Hooks:OverrideFunction(GenericDLCManager, "is_content_crimespree_locked", function() return false end)
Hooks:OverrideFunction(GenericDLCManager, "is_weapon_mod_achievement_locked", function() return false end)
Hooks:OverrideFunction(GenericDLCManager, "is_weapon_mod_achievement_milestone_locked", function() return false end)

Hooks:PostHook(GenericDLCManager, "has_dlc", "CrimDawn_GiveCommunityItems", function(self, dlc)
  if Global.CrimDawn.DLC then return false end
  if dlc == "pd2_clan" then return true end
end)