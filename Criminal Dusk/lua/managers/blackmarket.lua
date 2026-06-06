-- Automatically unlock side job weapons so they are available for use
Hooks:OverrideFunction(BlackMarketManager, "has_unlocked_arbiter", function() return true end)
Hooks:OverrideFunction(BlackMarketManager, "has_unlocked_breech", function() return true end)
Hooks:OverrideFunction(BlackMarketManager, "has_unlocked_ching", function() return true end)
Hooks:OverrideFunction(BlackMarketManager, "has_unlocked_erma", function() return true end)
Hooks:OverrideFunction(BlackMarketManager, "has_unlocked_victor", function() return true end)

-- Force game to register 2 of every item
Hooks:PostHook(BlackMarketManager, "get_item_amount", "CrimDawn_BMInfiniteItems", function(self, _, category)
  if category ~= "weapon_skins" then return 2 end
end)

-- Assign random van skin
Hooks:OverrideFunction(BlackMarketManager, "equipped_van_skin", function()
  local skins = { "default", "brown", "green", "grey", "red", "white", "yellow", "icecream", "spooky" }
  if not Global.CrimDawn.DLC and managers.dlc:is_dlc_unlocked("overkill_pack") then table.insert(skins, "overkill") end
  return skins[math.random(1, #skins)]
end)