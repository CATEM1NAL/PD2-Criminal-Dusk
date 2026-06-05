local FileIdent = "HeistSelector"

function CrimDawn:NextHeist(HeistsWon)
  local TierIndex = (6 - Global.CrimDawn.data.game.run_length) + (HeistsWon or 0) + 1
  
  local ValidHeists = deep_clone(Global.CrimDawn.tables.heists)
  local CurrentTier, NextHeist

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