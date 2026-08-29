local FileIdent = "CrimeNetManager"

Hooks:OverrideFunction(CrimeNetManager, "_get_jobs_by_jc", function(self)
  local t = {}

  for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
    local is_not_wrapped = not tweak_data.narrative.jobs[job_id].wrapped_to_job
    local dlc = tweak_data.narrative:job_data(job_id).dlc
    local is_not_dlc_or_got = not dlc or managers.dlc:is_dlc_unlocked(dlc)
    local pass_all_tests = is_not_wrapped and is_not_dlc_or_got
    pass_all_tests = pass_all_tests and not tweak_data.narrative:is_job_locked(job_id)

    if pass_all_tests then
      local job_data = tweak_data.narrative:job_data(job_id)
      local difficulty_id = CrimDusk.DiffScale()
      local difficulty = tweak_data:index_to_difficulty(difficulty_id)

      t[10] = t[10] or {}
      table.insert(t[10], {
        job_id = job_id,
        difficulty_id = difficulty_id,
        difficulty = difficulty,
        marker_dot_color = job_data.marker_dot_color or nil,
        color_lerp = job_data.color_lerp or nil,
        one_down = CrimDusk.IsPermadeath() == "_perma" and 1 or nil
      })
    end
  end

  return t
end)

Hooks:OverrideFunction(CrimeNetManager, "_setup", function(self)
  self._presets = {}

  local jcs = tweak_data.narrative:get_jcs_from_stars(10)
  local no_jcs = #jcs
  local jobs_by_jc = self:_get_jobs_by_jc()
  local no_picks = self:_number_of_jobs(jcs, jobs_by_jc)
  local j = 0
  local tests = 0

  while j < no_picks do
    for i = 1, no_jcs do
      if not jobs_by_jc[jcs[i]] then
      elseif #jobs_by_jc[jcs[i]] == 0 then
      else local job_data
        job_data = table.remove(jobs_by_jc[jcs[i]], math.random(#jobs_by_jc[jcs[i]]))

        local job_tweak = tweak_data.narrative:job_data(job_data.job_id)
        local chance_multiplier = job_tweak and job_tweak.spawn_chance_multiplier or 1
        job_data.chance = 1 * chance_multiplier

        table.insert(self._presets, job_data)

        j = j + 1
        break
      end
    end

    tests = tests + 1
    if no_picks <= tests then break end
  end
end)

local HeistsGenerated = {}
local disabled_contacts = { "wip", "tests", "escape", "skirmish" }

Hooks:OverrideFunction(CrimeNetManager, "activate_job", function(self)
  if CrimDusk.IsPermadeath() ~= "_perma" and Global.CrimDusk.data.heists_won < #Global.CrimDusk.campaign then
    if Global.CrimDusk.data.heists_won == 42 then managers.crimenet:set_getting_hacked(0.5) -- full duration = 42.16
    -- Beneath The Mountain; wanted this to trigger the full Locke hack, but the audio doesn't seem to play.

    elseif Global.CrimDusk.data.heists_won == 59 then managers.crimenet:set_getting_hacked(0.5) end
    -- Reservoir Dogs; feels thematic.

    self._active_jobs[1] = { added = false, active_timer = self._active_job_time }
  return end

  local HeistsGenerated = Global.CrimDusk.data["next_heists" .. CrimDusk.IsPermadeath()]

  if next(HeistsGenerated) then
    for i = 1, #HeistsGenerated do
      for index, data in ipairs(self._presets) do
        if data.job_id == HeistsGenerated[i] then
          if HeistsGenerated[i] == "cd_reservoir" then managers.crimenet:set_getting_hacked(0.5) end
          self._active_jobs[index] = { added = false, active_timer = self._active_job_time }
        break end
      end
    end
  return end

  math.randomseed(os.time() % math.floor(os.clock() * 1000000))
  math.random() -- *seems* to make the rng more varied??

  for i = 1, math.min(math.random(3), #self._presets) do
    while true do
      local heist = math.random(#self._presets)
      if math.random() <= self._presets[heist].chance then

        -- Reservoir Dogs is a special case; should be the only heist if selected
        if self._presets[heist].job_id == "cd_reservoir" then
          for index, _ in ipairs(self._active_jobs) do self._active_jobs[index] = nil end
          managers.crimenet:set_getting_hacked(0.5)
          self._active_jobs[heist] = { added = false, active_timer = self._active_job_time }
          HeistsGenerated = { "cd_reservoir" }
          CrimDusk:WriteSave(FileIdent, "Reservoir Dogs chosen!")
        return end

        -- Regular heists
        local contact = tweak_data.narrative.jobs[self._presets[heist].job_id].contact
        if not self._active_jobs[heist] and not table.contains(disabled_contacts, contact) then
          self._active_jobs[heist] = { added = false, active_timer = self._active_job_time }
          table.insert(HeistsGenerated, self._presets[heist].job_id)
        break end
      end

      CrimDusk.Log(FileIdent, self._presets[heist].job_id .. " failed roll (" .. 100 * self._presets[heist].chance .. "% to be selected), rolling again", true)
    end
  end

  CrimDusk:WriteSave(FileIdent, "generated random heists")
end)

function CrimeNetSidebarGui:clbk_new_weekly_holdout()
  if Global.game_settings.single_player then return false end
  local LastWeekly = Global.CrimDusk.holdout_data
  if (LastWeekly.end_timestamp or 0) > os.time() then return false
  elseif not Global.skirmish_manager then return false
  else for key, value in pairs(Global.skirmish_manager.active_weekly) do
      if LastWeekly[key] ~= value then return true end
    end
  end
end

function CrimeNetSidebarGui:clbk_setup_weekly_holdout()
  local weekly_skirmish = managers.skirmish:active_weekly()
  local job_data = {
    difficulty = "normal",
    weekly_skirmish = true,
    job_id = weekly_skirmish.id
  }
  MenuCallbackHandler:start_job(job_data)
end