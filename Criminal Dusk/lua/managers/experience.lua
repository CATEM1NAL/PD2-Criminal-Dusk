Hooks:OverrideFunction(ExperienceManager, "_set_next_level_data", function(self, level)
  if level > 100 then level = 100 end
  local level_data = tweak_data.experience_manager.levels[level]

  self._global.next_level_data = {}

  self:_set_next_level_data_points(level_data.points)
  self:_set_next_level_data_current_points(0)

  if self._experience_progress_data then
    table.insert(self._experience_progress_data, {
      current = 0,
      level = level,
      total = tweak_data:get_value("experience_manager", "levels", level, "points")
    })
  end
end)

Hooks:OverrideFunction(ExperienceManager, "_level_up", function(self)
  self:_set_current_level(self:current_level() + 1)
  self:_set_next_level_data(self:current_level() + 1)

  self:_check_achievements()

  if managers.network:session() then
    managers.network:session():send_to_peers_synched("sync_level_up", self:current_level())
  end

  if self:current_level() <= 100 then
    managers.upgrades:level_up()
    managers.skilltree:level_up()
  end

  managers.mission:call_global_event(Message.OnLevelUp)
end)