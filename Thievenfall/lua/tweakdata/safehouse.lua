Hooks:PostHook(CustomSafehouseTweakData, "_init_map", "CrimDusk_InitSafehouseMap", function(self)
  for floor, _ in ipairs(self.map.floors) do
    for i = #self.map.floors[floor].rooms, 1, -1 do
      if self.map.floors[floor].rooms[i] == "old_hoxton" then table.remove(self.map.floors[floor].rooms, i)
      elseif self.map.floors[floor].rooms[i] == "wild" then table.remove(self.map.floors[floor].rooms, i) end
    end
  end
end)