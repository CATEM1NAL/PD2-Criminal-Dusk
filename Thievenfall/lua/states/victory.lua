if NetworkHelper:IsClient() then return end
local FileIdent = "Victory"

Hooks:PostHook(VictoryState, "at_enter", "CrimDusk_HeistWon", function(self)
  -- Heist completion
  local campaign = CrimDusk.SettingsData.permadeath and "heists_won_perma" or "heists_won"
  if managers.job:on_last_stage() then
    Global.CrimDusk.data[campaign] = Global.CrimDusk.data[campaign] + 1
    CrimDusk.Log(FileIdent, "Heists won: " .. Global.CrimDusk.data[campaign])
    CrimDusk:WriteSave(FileIdent, "heist completed")

    if Global.CrimDusk.data[campaign] == #Global.CrimDusk.campaign then
      CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory"))
      DelayedCalls:Add("CrimDusk_VictoryTease", 3, function()
        CrimDusk.ChatNotify(managers.localization:text("crimdawn_chat_victory2"))
      end)
    end

  end

  NetworkHelper:SendToPeers("CrimDusk_HeistCount", Global.CrimDusk.data[campaign])
end)