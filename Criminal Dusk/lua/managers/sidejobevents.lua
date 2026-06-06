local function CompleteAllEventJobs()
  for _, data in pairs(tweak_data.event_jobs.challenges) do
    if data.id ~= "cg22_1" then
      managers.event_jobs:completed_challenge(data.id)
      for i = 1, #data.rewards do
        if data.rewards[i].type_items ~= "xp" then managers.event_jobs:claim_reward(data.id, i) end
      end
    end
  end
end

Hooks:PostHook(SideJobEventManager, "load", "CrimDawn_SideJobEventLoad", function(self)
  CompleteAllEventJobs()
end)

Hooks:PostHook(SideJobEventManager, "reset", "CrimDawn_SideJobEventReset", function(self)
  CompleteAllEventJobs()
end)