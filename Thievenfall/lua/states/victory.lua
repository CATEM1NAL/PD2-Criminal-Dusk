local FileIdent = "Victory"

if Global.game_settings and Global.game_settings.level_id == "chill_combat" then return
elseif NetworkHelper:IsClient() then CrimDusk:WriteSave(FileIdent, "heist completed") return end

Hooks:PostHook(VictoryState, "at_enter", "CrimDusk_HeistWon", function(self)
  local heists_won = "heists_won" .. CrimDusk.IsPermadeath()
  if managers.job:on_last_stage() then
    Global.CrimDusk.data[heists_won] = Global.CrimDusk.data[heists_won] + 1
    CrimDusk.Log(FileIdent, "Heists won: " .. Global.CrimDusk.data[heists_won])

    if Global.CrimDusk.data[heists_won] == #Global.CrimDusk.campaign then
      CrimDusk.SoftReset()
      NetworkHelper:SendToPeers("CrimDusk_CampaignWon", true)
      CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_victory"))
      DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
        CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_victory2"))
      end)

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
      elseif CurrentHeist == "vit" then
        CrimDusk.SoftReset()
        NetworkHelper:SendToPeers("CrimDusk_CampaignWon", true)
        CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_victory"))
        DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
          CrimDusk.ChatNotify(managers.localization:text("crimdusk_chat_victory2"))
        end)
      end
    end

    CrimDusk:WriteSave(FileIdent, "heist completed")
  end
end)