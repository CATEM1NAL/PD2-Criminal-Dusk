if NetworkHelper:IsClient() then return end
local FileIdent = "Victory"

Hooks:PostHook(VictoryState, "at_enter", "CrimDusk_HeistWon", function(self)
  -- Heist completion
  local heists_won = "heists_won" .. CrimDusk.IsPermadeath()
  if managers.job:on_last_stage() then
    Global.CrimDusk.data[heists_won] = Global.CrimDusk.data[heists_won] + 1
    CrimDusk.Log(FileIdent, "Heists won: " .. Global.CrimDusk.data[heists_won])

    if Global.CrimDusk.data[heists_won] == #Global.CrimDusk.campaign then
      NetworkHelper:SendToPeers("CrimDusk_CampaignWon", true)
      CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
      DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
        CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
      end)

    -- Set up flags for post-game campaign
    elseif Global.CrimDusk.data[heists_won] > #Global.CrimDusk.campaign then
      local Permadeath = CrimDusk.IsPermadeath()
      local CurrentHeist = Global.CrimDusk.data["heist_chain" .. Permadeath][#Global.CrimDusk.data["heist_chain" .. Permadeath]]

      for Campaign, _ in pairs(Global.CrimDusk.mini_campaign_data) do
        if type(Global.CrimDusk.mini_campaign_data[Campaign][CurrentHeist]) == "number" then
          Global.CrimDusk.data[Campaign .. Permadeath] = Global.CrimDusk.data[Campaign .. Permadeath] + 1
        end
      end

      if CurrentHeist == "bph" then self.data["bain_freed" .. Permadeath] = true
      elseif CurrentHeist == "sand" then self.data["vlad_freed" .. Permadeath] = true
      elseif CurrentHeist == "pex" then self.data["almir_freed" .. Permadeath] = true
      elseif CurrentHeist == "cd_biker1" then self.data["rust_recruited" .. Permadeath] = true end
    end

    CrimDusk:WriteSave(FileIdent, "heist completed")
  end
end)