local FileIdent = "MutatorTable"
for _, mutator in ipairs(managers.mutators:mutators()) do managers.mutators:set_enabled(mutator, false) end
Global.mutators._peers_notified = {}
Global.mutators._peers_ready = {}

local MutatorTable = { "ShotgunTweak", "ZealSniper", "Heavies" }

local DefaultMutators = { CloakerArrest = true }
managers.mutators:set_enabled("MutatorCloakerArrest")

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
end

if Difficulty >= 7 then -- Death Wish
  managers.mutators:set_enabled("MutatorShieldPhalanx")
end

if CrimDusk.SettingsData and CrimDusk.SettingsData.mutators then
  if not CrimDusk.SettingsData.mutators then Mutators = 0 end
end

CrimDusk.Log(FileIdent, "Generating " .. Mutators .. " mutators:")

for i = 1, Mutators do
  if not next(MutatorTable) then break end
  local CurrentIndex = math.random(#MutatorTable)
  local CurrentMutator = MutatorTable[CurrentIndex]
  local state = true

  if DefaultMutators[CurrentMutator] then state = false end
  managers.mutators:set_enabled("Mutator" .. CurrentMutator, state)
  CrimDusk.Log(FileIdent, CurrentMutator)
  table.remove(MutatorTable, CurrentIndex)
end

-- Assign random properties!
managers.mutators:get_mutator_from_id("MutatorCloakerEffect"):set_value("kick_effect", "random")
managers.mutators:get_mutator_from_id("MutatorShotgunTweak"):set_value("pull_strength", 1 + math.random() * (5 - 1))
managers.mutators:get_mutator_from_id("MutatorShotgunTweak"):set_value("mothership", math.random() < 0.5)
managers.mutators:get_mutator_from_id("MutatorFriendlyFire"):set_value("damage_multiplier", math.min(Difficulty - 2, 3))

MenuCallbackHandler:update_matchmake_attributes()