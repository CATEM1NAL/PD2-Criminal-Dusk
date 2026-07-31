Hooks:PostHook(GameSetup, "init_finalize", "CrimDusk_GameSetupInit", function()
  local script = managers.mission._scripts.default._elements
  local level = managers.job:current_level_id() or "nil"

  local UnmaskedHeists = {
    fex = true,
    pex = true,
    dah = true,
    fish = true,
    ranc = true,
    mex = true,
    trai = true,
    arm_for = true
  }

  if not UnmaskedHeists[level] then return end
  for BaseElementName, BaseElement in pairs(script) do
    if BaseElement.class == "ElementPlayerSpawner" then BaseElement._values.state = "mask_off" end
  end
end)