local FileIdent = "MutatorTable"
for _, mutator in ipairs(managers.mutators:mutators()) do managers.mutators:set_enabled(mutator, false) end
Global.mutators._peers_notified = {}
Global.mutators._peers_ready = {}

local MutatorTable = { "ZealSniper", "Heavies" }
local Difficulty = CrimDusk.DiffScale(true)

if Difficulty >= 3 then -- Hard
  managers.mutators:set_enabled("MutatorFriendlyFire")
end

if Difficulty >= 4 then -- Very Hard
  table.insert(MutatorTable, "CloakerEffect")
  table.insert(MutatorTable, "DozerRage")
  if Difficulty < 8 then table.insert(MutatorTable, "MedicDozer") end
end

if Difficulty >= 5 then -- Overkill
  table.insert(MutatorTable, "MedicAdrenaline")
  table.insert(MutatorTable, "MedicRage")
end

if Difficulty >= 7 then -- Death Wish
  managers.mutators:set_enabled("MutatorShieldPhalanx")
end

local Mutators = math.min(math.random(1 + Difficulty - 2, 3 + Difficulty - 2), #MutatorTable)
if CrimDusk.SettingsData and CrimDusk.SettingsData.mutators then
  if not CrimDusk.SettingsData.mutators then Mutators = 0 end
end

CrimDusk.Log(FileIdent, "Generating " .. Mutators .. " mutators:")

for i = 1, Mutators do
  if not next(MutatorTable) then break end
  local CurrentIndex = math.random(#MutatorTable)
  local CurrentMutator = MutatorTable[CurrentIndex]

  managers.mutators:set_enabled("Mutator" .. CurrentMutator, true)
  CrimDusk.Log(FileIdent, CurrentMutator)
  table.remove(MutatorTable, CurrentIndex)
end

-- Assign random properties!
managers.mutators:get_mutator_from_id("MutatorCloakerEffect"):set_value("kick_effect", "random")
managers.mutators:get_mutator_from_id("MutatorFriendlyFire"):set_value("damage_multiplier", math.min(Difficulty - 2, 3))

MenuCallbackHandler:update_matchmake_attributes()