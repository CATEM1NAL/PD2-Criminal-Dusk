local FileIdent = "MutatorTable"
for _, mutator in ipairs(managers.mutators:mutators()) do managers.mutators:set_enabled(mutator, false) end
Global.mutators._peers_notified = {}
Global.mutators._peers_ready = {}

local MutatorTable = { "EnemyDamage", "EnemyHealth", "ShotgunTweak", "ZealSniper", "Heavies" }

local DefaultMutators = { CloakerArrest = true }
managers.mutators:set_enabled("MutatorCloakerArrest")

local SpecialMutators = { CloakerEffect = true, CloakerArrest = true, MedicDozer = true, DozerRage = true,
                          MedicAdrenaline = true, MedicRage = true, ZealSniper = true, Heavies = true }

local Difficulty = CrimDusk.DiffScale(true)
local Mutators = math.random(1 + Difficulty - 2, 3 + Difficulty - 2)

if Difficulty >= 3 then -- Hard
  table.insert(MutatorTable, "TaserOvercharge")
  managers.mutators:set_enabled("MutatorFriendlyFire")
end

if Difficulty >= 4 then -- Very Hard
  table.insert(MutatorTable, "CloakerEffect")
  table.insert(MutatorTable, "CloakerArrest")
  table.insert(MutatorTable, "MedicDozer")
  table.insert(MutatorTable, "DozerRage")
end

if Difficulty >= 5 then -- Overkill
  table.insert(MutatorTable, "MedicAdrenaline")
  table.insert(MutatorTable, "MedicRage")
  table.insert(MutatorTable, "EnemyReplacer")
end

if Difficulty >= 7 then -- Death Wish
  managers.mutators:set_enabled("MutatorShieldPhalanx")
end

if Difficulty >= 8 then -- Death Sentence
end

if CrimDusk.SettingsData and CrimDusk.SettingsData.mutators then
  if not CrimDusk.SettingsData.mutators then Mutators = 0 end
end

CrimDusk.Log(FileIdent, "Generating " .. Mutators .. " mutators:")

local CurrentIndex

for i = 1, Mutators do
  if not next(MutatorTable) then break end
  local CurrentIndex = math.random(#MutatorTable)
  local CurrentMutator = MutatorTable[CurrentIndex]
  local EnemyModifierEnabled = false
  local state = true

  -- Clone Army disables other enemy mutators
  if CurrentMutator == "EnemyReplacer" then
    EnemyModifierEnabled = true

    for i = #MutatorTable, 1, -1 do
      if SpecialMutators[MutatorTable[i]] then table.remove(MutatorTable, i) end
    end

    Utils.PrintTable(MutatorTable)

  -- Enemy mutators disable Clone Army
  elseif SpecialMutators[CurrentMutator] then
    EnemyModifierEnabled = true

    for index, mutator in ipairs(MutatorTable) do
      if mutator == "EnemyReplacer" then table.remove(MutatorTable, index) break end
    end
  end

  -- Determine new mutator index
  if EnemyModifierEnabled then
    for index, mutator in ipairs(MutatorTable) do
      if mutator == CurrentMutator then CurrentIndex = index break end
    end
  end

  if DefaultMutators[CurrentMutator] then state = false end
  managers.mutators:set_enabled("Mutator" .. CurrentMutator, state)
  CrimDusk.Log(FileIdent, CurrentMutator)
  table.remove(MutatorTable, CurrentIndex)
end

-- Assign random properties!
managers.mutators:get_mutator_from_id("MutatorEnemyHealth"):set_value("health_multiplier", 1.5)
managers.mutators:get_mutator_from_id("MutatorEnemyDamage"):set_value("damage_multiplier", 1.75)
managers.mutators:get_mutator_from_id("MutatorCloakerEffect"):set_value("kick_effect", "random")
managers.mutators:get_mutator_from_id("MutatorShotgunTweak"):set_value("pull_strength", 1 + math.random() * (5 - 1))
managers.mutators:get_mutator_from_id("MutatorShotgunTweak"):set_value("mothership", math.random() < 0.5)
managers.mutators:get_mutator_from_id("MutatorFriendlyFire"):set_value("damage_multiplier", math.min(Difficulty - 2, 3))
managers.mutators:get_mutator_from_id("MutatorEnemyReplacer"):set_value("override_enemy", "taser")

MenuCallbackHandler:update_matchmake_attributes()