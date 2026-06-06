function CrimDawn:RandomHeist()
  local ValidHeists = deep_clone(Global.CrimDawn.tables.heists)

  for tier, heists in pairs(ValidHeists) do
    for i = #heists, 1, -1 do
      if CrimDawn.SettingsData[heists[i]] == false then table.remove(heists, i) end
    end
  end

  local AllValidHeists = {}
  for _, tier in pairs(ValidHeists) do
    for _, heist in ipairs(tier) do table.insert(AllValidHeists, heist) end
  end

  CrimDawn.NextHeist = AllValidHeists[math.random(#AllValidHeists)]
end