local FileIdent = "GameSetup"

Hooks:PostHook(GameSetup, "init_finalize", "CrimDusk_GameSetupInit", function()
  if not Global.CrimDusk.UnmaskedHeists[managers.job:current_level_id()] then return end
  CrimDusk.Log(FileIdent, "Changing spawns to casing mode!")

  local script = managers.mission._scripts.default._elements
  for BaseElementName, BaseElement in pairs(script) do
    if BaseElement.class == "ElementPlayerSpawner" then BaseElement._values.state = "mask_off" end
  end
end)