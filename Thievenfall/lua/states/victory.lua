if Global.game_settings and Global.game_settings.level_id == "chill_combat" then return end
local FileIdent = "Victory"

local lives = NetworkHelper:IsClient() and "lives" or "lives" .. CrimDusk.IsPermadeath()

Hooks:PostHook(VictoryState, "at_enter", "CrimDusk_HeistWon", function(self)
  if managers.skirmish:is_skirmish() then -- Weekly Holdout
    Global.CrimDusk.data.weekly_holdout = Global.skirmish_manager.active_weekly
    CrimDusk:WriteSave(FileIdent, "holdout completed")
  return end

  if Global.CrimDusk.data[lives] == -1 then Global.CrimDusk.data[lives] = -2 end
  if NetworkHelper:IsClient() then CrimDusk:WriteSave(FileIdent, "heist completed") return end

  local heists_won = "heists_won" .. CrimDusk.IsPermadeath()
  if managers.job:on_last_stage() then
    Global.CrimDusk.data[heists_won] = Global.CrimDusk.data[heists_won] + 1
    CrimDusk.Log(FileIdent, "Heists won: " .. Global.CrimDusk.data[heists_won])

    if Global.CrimDusk.data[heists_won] == #Global.CrimDusk.campaign then
      CrimDusk.SoftReset()
      CrimDusk.EndingText(true)

    -- Post-game campaign
    elseif (Global.CrimDusk.data[heists_won] > #Global.CrimDusk.campaign) or CrimDusk.IsPermadeath() == "_perma" then
      local Permadeath = CrimDusk.IsPermadeath()
      local CurrentHeist = managers.job:current_job_id()
      CurrentHeist = Global.CrimDusk.job_to_wrapper[CurrentHeist] or CurrentHeist

      Global.CrimDusk.data["heist_chain" .. Permadeath] = Global.CrimDusk.data["heist_chain" .. Permadeath] or {}
      table.insert(Global.CrimDusk.data["heist_chain" .. Permadeath], CurrentHeist)

      for Campaign, _ in pairs(Global.CrimDusk.mini_campaign_data) do
        if type(Global.CrimDusk.mini_campaign_data[Campaign][CurrentHeist]) == "number" then
          Global.CrimDusk.data[Campaign .. Permadeath] = Global.CrimDusk.data[Campaign .. Permadeath] + 1
        break end
      end

      if CurrentHeist == "bph" then Global.CrimDusk.data["bain_freed" .. Permadeath] = true
      elseif CurrentHeist == "sand" then Global.CrimDusk.data["vlad_freed" .. Permadeath] = true
      elseif CurrentHeist == "pex" then Global.CrimDusk.data["almir_freed" .. Permadeath] = true
      elseif CurrentHeist == "cd_biker1" then Global.CrimDusk.data["rust_recruited" .. Permadeath] = true
      elseif Global.CrimDusk.mini_campaign_data.dentist[CurrentHeist] then Global.CrimDusk.data["dentist_heists" .. Permadeath] = Global.CrimDusk.data["dentist_heists" .. Permadeath] + 1
      elseif CurrentHeist == "vit" then
        CrimDusk.EndingText(true)
        CrimDusk.SoftReset()
      end
    end

    CrimDusk:WriteSave(FileIdent, "heist completed")
  end
end)