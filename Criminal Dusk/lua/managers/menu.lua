local FileIdent = "MenuManager"

function MenuCallbackHandler:CrimDawn_SaveToggleSettings(item)
  CrimDawn.SettingsData[item:name():sub(10)] = item:value() == "on"
	io.save_as_json(CrimDawn.SettingsData, CrimDawn.SettingsFile)
end

function MenuCallbackHandler:CrimDawn_SaveChoiceSettings(item)
  CrimDawn.SettingsData[item:name():sub(10)] = item:value()
	io.save_as_json(CrimDawn.SettingsData, CrimDawn.SettingsFile)
end

Hooks:PreHook(MenuCallbackHandler, "start_the_game", "CrimDawn_PreStartGame", function(self)
  if Utils:IsInGameState() or CrimDawn.state.heist_started then return end

  -- Activate mutators
  dofile(CrimDawn.ModPath .. "lua/mutators.lua")

  -- Prevent from running again, otherwise peer mutators become desynced
  CrimDawn.state.heist_started = true
end)