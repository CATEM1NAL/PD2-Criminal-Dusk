Hooks:PostHook(CrimeNetManager, "_setup", "CrimDusk_SetCrimeNetDifficulty", function(self)
  local diff = CrimDusk.DiffScale()
  local permadeath = CrimDusk.IsPermadeath() == "_perma"
  for _, data in ipairs(self._presets) do
    data.difficulty = tweak_data:index_to_difficulty(diff)
    data.difficulty_id = diff
    if permadeath then data.one_down = 1
    else data.one_down = nil end
  end
end)

local HeistsGenerated = {}
local disabled_contacts = { "wip", "tests", "escape", "skirmish" }

Hooks:OverrideFunction(CrimeNetManager, "activate_job", function(self)
  if Global.CrimDusk.data.heists_won == 42 then managers.crimenet:set_getting_hacked(0.5) end
  -- Wanted this to trigger the full thing, but the audio doesn't seem to play.

  if next(HeistsGenerated) then
    if #HeistsGenerated > self._MAX_ACTIVE_JOBS then HeistsGenerated = {} end

    for i = 1, #HeistsGenerated do
      if not self._active_jobs[HeistsGenerated[i]] then
        self._active_jobs[HeistsGenerated[i]] = { added = false, active_timer = self._active_job_time + math.random(5) }
      end
    end

    if CrimDusk.IsPermadeath() == "_perma" and #HeistsGenerated == 3 then return
    elseif CrimDusk.IsPermadeath() ~= "_perma" and #HeistsGenerated == self._MAX_ACTIVE_JOBS then return end
  end

  local presets = self._presets
  local i = math.random(#presets)

  while i ~= i - 1 do
    local chance = presets[i].chance
    local roll = math.rand(1)

    if roll <= chance then
      local contact = tweak_data.narrative.jobs[presets[i].job_id].contact
      if not self._active_jobs[i] and i ~= 0 and not table.contains(disabled_contacts, contact) then
        self._active_jobs[i] = { added = false, active_timer = self._active_job_time + math.random(5) }
        table.insert(HeistsGenerated, i)
      return end
    end

    i = 1 + math.mod(i, #presets)
  end
end)