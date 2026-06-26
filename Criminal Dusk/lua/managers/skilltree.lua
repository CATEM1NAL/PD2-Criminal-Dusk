Hooks:OverrideFunction(SkillTreeManager, "skill_cost", function(self, tier) return tier end)
Hooks:OverrideFunction(SkillTreeManager, "level_up", function() end)

Hooks:OverrideFunction(SkillTreeManager, "_setup_skill_switches", function(self)
  	if not self._global.skill_switches then
		self._global.skill_switches = {}
		local switch_data = nil

		for i = 1, #tweak_data.skilltree.skill_switches do
			self._global.skill_switches[i] = {
				specialization = false,
				unlocked = i == 1,
				points = Application:digest_value(1, true)
			}
			switch_data = self._global.skill_switches[i]
			switch_data.trees = {}

			for tree, data in pairs(tweak_data.skilltree.trees) do
				switch_data.trees[tree] = {
					unlocked = true,
					points_spent = Application:digest_value(0, true)
				}
			end

			switch_data.skills = {}

			for skill_id, data in pairs(tweak_data.skilltree.skills) do
				switch_data.skills[skill_id] = {
					unlocked = 0,
					total = #data
				}
			end
		end
	else
		local switch_data = nil

		for i = 1, #tweak_data.skilltree.skill_switches do
			switch_data = self._global.skill_switches[i]
			switch_data.trees = {}

			for tree, data in pairs(tweak_data.skilltree.trees) do
				switch_data.trees[tree] = {
					unlocked = true,
					points_spent = Application:digest_value(0, true)
				}
			end

			switch_data.skills = {}

			for skill_id, data in pairs(tweak_data.skilltree.skills) do
				switch_data.skills[skill_id] = {
					unlocked = 0,
					total = #data
				}
			end
		end
	end
end)

Hooks:OverrideFunction(SkillTreeManager, "_verify_loaded_data", function(self, points_aquired_during_load)
	for i, switch_data in ipairs(self._global.skill_switches) do
		local points = points_aquired_during_load

		for skill_id, data in pairs(clone(switch_data.skills)) do
			if not tweak_data.skilltree.skills[skill_id] then
				print("[SkillTreeManager:_verify_loaded_data] Skill doesn't exists", skill_id, ", removing loaded data.", "skill_switch", i)

				switch_data.skills[skill_id] = nil
			end
		end

		for tree_id, data in pairs(clone(switch_data.trees)) do
			if not tweak_data.skilltree.trees[tree_id] then
				print("[SkillTreeManager:_verify_loaded_data] Tree doesn't exists", tree_id, ", removing loaded data.", "skill switch", i)

				switch_data.trees[tree_id] = nil
			end
		end

		for tree_id, data in pairs(clone(switch_data.trees)) do
			local points_spent = math.max(Application:digest_value(data.points_spent, false), 0)
			data.points_spent = Application:digest_value(points_spent, true)
			points = points - points_spent
		end

		local unlocked = self:trees_unlocked(switch_data.trees)

		while unlocked > 0 do
			unlocked = unlocked - 1
		end

		switch_data.points = Application:digest_value(points, true)
	end

	for i = 1, #self._global.skill_switches do
		if self._global.skill_switches[i] and Application:digest_value(self._global.skill_switches[i].points or 0, false) < 0 then
			local switch_data = self._global.skill_switches[i]

			if self._global.skill_switches[self._global.selected_skill_switch] and self._global.skill_switches[self._global.selected_skill_switch] == switch_data then
				self._global.selected_skill_switch = 1
			end

			switch_data.points = Application:digest_value(0, true)
		end
	end

	if not self._global.skill_switches[self._global.selected_skill_switch] then
		self._global.selected_skill_switch = 1
	end

	local data = self._global.skill_switches[self._global.selected_skill_switch]
	self._global.points = data.points
	self._global.trees = data.trees
	self._global.skills = data.skills

	for tree_id, tree_data in pairs(self._global.trees) do
		if tree_data.unlocked and not tweak_data.skilltree.trees[tree_id].dlc then
			for tier, skills in pairs(tweak_data.skilltree.trees[tree_id].tiers) do
				for _, skill_id in ipairs(skills) do
					local skill = tweak_data.skilltree.skills[skill_id]
					local skill_data = self._global.skills[skill_id]

					for i = 1, skill_data.unlocked do
						self:_aquire_skill(skill[i], skill_id, true)
					end
				end
			end
		end
	end
end)

Hooks:OverrideFunction(SkillTreeManager, "max_points_for_current_level", function()
  local rep_upgrade_points = 0

	for _, rep_upgrade in ipairs(managers.upgrades:aquired_by_category("rep_upgrade")) do
		rep_upgrade_points = rep_upgrade_points + managers.upgrades:get_value(rep_upgrade)
	end

  return 1 + rep_upgrade_points
end)