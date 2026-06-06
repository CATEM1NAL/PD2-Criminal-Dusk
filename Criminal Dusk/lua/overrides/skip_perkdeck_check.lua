local function maybe_award(id, check, set)
	if check then managers.story:award(id, set == true and check or set or nil) end
end

Hooks:OverrideFunction(StoryMissionsTweakData, "_sm_2_check", function()
  local slots = managers.player:equipment_slots()

	maybe_award("story_inv_deployable", slots and #slots > 0)
	maybe_award("story_inv_perkdeck", true)
	maybe_award("story_inv_skillpoints", tweak_data.story.sm_2_skillpoints <= managers.skilltree:total_points_spent())
end)