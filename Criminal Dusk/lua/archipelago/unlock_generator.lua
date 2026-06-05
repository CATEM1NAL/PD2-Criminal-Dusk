local FileIdent = "UnlockGenerator"

local function AnyObtained(reqs, req_type)
  if req_type == "upgrades" then
    for _, item in ipairs(reqs) do
      for _, upgrade in ipairs(Global.CrimDawn.data.upgrades) do
        if upgrade == item then return true end
      end
    end

  elseif req_type == "unlocks" then
    for _, item in ipairs(reqs) do
      if Global.CrimDawn.data[req_type][item] then return true end
    end
  end
return false end

local function UpgradeMatched(upg_name)
  for _, upgrade in ipairs(Global.CrimDawn.data.upgrades) do
    if upgrade == upg_name then return true end
  end
return false end

local function GetUpgradeType(table_name)
  if table_name ~= "deployable" then
    local rarity = math.random(1, 100)

    if 0 < rarity and rarity <= 10 then return "rare"
    elseif 10 < rarity and rarity <= 35 then return "uncommon"
    else return "common" end
  end
return nil end

function CrimDawn:RandomUpgrade(count, table_name)
  self.Log(FileIdent, "Generating " .. count .. " random " .. table_name .. " upgrades")
  local DisabledUpgrades = {}
  local AcquiredUpgrades = {}

  -- Setup
  for _, upgrade in ipairs(Global.CrimDawn.data.upgrades) do
    local TableName, key = upgrade:match("([^%-]+)%-(.+)")
    if TableName == table_name then
      AcquiredUpgrades[key] = true

      if Global.CrimDawn.tables.upgrades[table_name][key].disable then
        for item in Global.CrimDawn.tables.upgrades[table_name][key].disable:gmatch("([^,]+)") do
          DisabledUpgrades[item] = true
        end
      end

    end
  end

  for i = 1, count do
    local BaseTable = {}
    local UpgType = GetUpgradeType(table_name, i)
    if UpgType then self.Log(FileIdent, "Next upgrade type: " .. UpgType)
    else self.Log(FileIdent, "No upgrade type given") end

    for key, data in pairs(Global.CrimDawn.tables.upgrades[table_name]) do

      local CountMet
      if data.count_req then
        local CountKey, CountValue = data.count_req:match("([^:]+):(.*)")
        if data.count_req and (Global.CrimDawn.data.x[CountKey] >= tonumber(CountValue)) then
          CountMet = true
        end
      end

      local ItemReq = {}
      if data.item_req then
        for item in data.item_req:gmatch("([^,]+)") do table.insert(ItemReq, item) end
      end

      local UpgReq = {}
      if data.upg_req then
        for item in data.upg_req:gmatch("([^,]+)") do table.insert(UpgReq, item) end
      end

      -- Create valid upgrade table
      if data.dlc_owned and data.upg_type == UpgType and
      not DisabledUpgrades[key] and not AcquiredUpgrades[key] and
      (not data.upg_req or AnyObtained(UpgReq, "upgrades")) and
      (not data.item_req or AnyObtained(ItemReq, "unlocks")) and
      (not data.count_req or CountMet) then
        BaseTable[key] = true
      end
    end

    -- Build working table from base table
    local WorkingTable = {}
    for key in pairs(BaseTable) do table.insert(WorkingTable, key) end

    -- Give player random upgrade
    if next(WorkingTable) then
      --Utils.PrintTable(WorkingTable)
      local UpgradeIndex = math.random(#WorkingTable)
      table.insert(Global.CrimDawn.data.upgrades, table_name .. "-" .. WorkingTable[UpgradeIndex])
      self.Log(FileIdent, "Added " .. WorkingTable[UpgradeIndex] .. " to upgrade table")

      -- Set up for next pass
      if i < count then
        AcquiredUpgrades[WorkingTable[UpgradeIndex]] = true
        local LastUpgrade = Global.CrimDawn.tables.upgrades[table_name][WorkingTable[UpgradeIndex]]

        if LastUpgrade.disable then
          for item in LastUpgrade.disable:gmatch("([^,]+)") do
            DisabledUpgrades[item] = true
          end
        end

        table.remove(WorkingTable, UpgradeIndex)
      end

    else self.Log(FileIdent, "No upgrades in WorkingTable!") end
  end
end

local TypeToPrefix = {
  primaries = "w_",
  akimbos = "w_",
  secondaries = "w_",
  g26 = "wp_pis_",
  melee = "melee_",
  throwables = "",
  deployables = "equipment_",
  armour = "armor_level_"
}

local function UnlockMenu(unlock_type)
  local UnlockName = {}
  local TypeName = {}

  for i = 1, 3 do
    TypeName[i] = unlock_type
    if unlock_type == "armour" then
      UnlockName[i] = tonumber((CrimDawn.state.unlockopt[i] or "0"):sub(-1)) + 1
    else
      UnlockName[i] = Global.CrimDawn.tables.WeaponIDToName[CrimDawn.state.unlockopt[i]] or CrimDawn.state.unlockopt[i] or "nil"
      if UnlockName[i] == "g26" then TypeName[i] = "g26" end -- Chimano Compact has its own prefix. Thanks Overkill.
    end
  end

  local UnlockButtons = {
    [1] = { text = managers.localization:text("bm_" .. TypeToPrefix[TypeName[1]] .. UnlockName[1]),
            callback = CrimDawn.UnlockButton1 },
    [2] = { text = managers.localization:text("bm_" .. TypeToPrefix[TypeName[2]] .. UnlockName[2]),
            callback = CrimDawn.UnlockButton2 },
    [3] = { text = managers.localization:text("bm_" .. TypeToPrefix[TypeName[3]] .. UnlockName[3]),
            callback = CrimDawn.UnlockButton3 }
  }
  if not CrimDawn.state.unlockopt[3] then table.remove(UnlockButtons, 3) end
  if not CrimDawn.state.unlockopt[2] then table.remove(UnlockButtons, 2) end

  local UnlockMenu = QuickMenu:new(
    string.upper("New " .. unlock_type),
    managers.localization:text("crimdawn_new_item" .. math.random(1,25)),
    UnlockButtons,
    true
  )
end

function CrimDawn.UnlockButton1()
  CrimDawn.UnlockItem(1)
end

function CrimDawn.UnlockButton2()
  CrimDawn.UnlockItem(2)
end

function CrimDawn.UnlockButton3()
  CrimDawn.UnlockItem(3)
end

function CrimDawn.UnlockItem(i)
  CrimDawn.Log(FileIdent, "player chose " .. CrimDawn.state.unlockopt[i])
  Global.CrimDawn.data.unlocks[CrimDawn.state.unlockopt[i]] = true
  managers.upgrades:aquire(CrimDawn.state.unlockopt[i])

  for _, deployable in ipairs(Global.CrimDawn.tables.etc.deployables) do
    if CrimDawn.state.unlockopt[i] == deployable then
      CrimDawn:RandomUpgrade(1, "deployable")
    break end
  end

  CrimDawn:WriteSave(FileIdent, "new item unlocked")
  table.remove(CrimDawn.state.upg_queue, 1)
  if next(CrimDawn.state.upg_queue) then
    CrimDawn:RandomUnlock(
      CrimDawn.state.upg_queue[1][BaseTable],
      CrimDawn.state.upg_queue[1][TableName]
    )
  end
end

function CrimDawn:RandomUnlock()
  if not next(CrimDawn.state.upg_queue) then return end
  local BaseTable = CrimDawn.state.upg_queue[1].BaseTable
  local TableName = CrimDawn.state.upg_queue[1].TableName
  local WorkingTable = deep_clone(Global.CrimDawn.tables[BaseTable][TableName])

  for i = #WorkingTable, 1, -1 do
    if Global.CrimDawn.data.unlocks[WorkingTable[i]] then table.remove(WorkingTable, i) end
  end

  CrimDawn.state.unlockopt = {}
  for i = 1, math.min(3, #WorkingTable) do
    local UnlockIndex = math.random(#WorkingTable)
    CrimDawn.state.unlockopt[i] = WorkingTable[UnlockIndex]
    table.remove(WorkingTable, UnlockIndex)
  end

  CrimDawn.Log(FileIdent, TableName .. " choice 1: " .. (CrimDawn.state.unlockopt[1] or "nil"))
  CrimDawn.Log(FileIdent, TableName .. " choice 2: " .. (CrimDawn.state.unlockopt[2] or "nil"))
  CrimDawn.Log(FileIdent, TableName .. " choice 3: " .. (CrimDawn.state.unlockopt[3] or "nil"))

  if CrimDawn.state.unlockopt[1] then UnlockMenu(TableName)
  else CrimDawn.Log(FileIdent, "NO VALID CHOICES! Skipping...")
    table.remove(self.state.upg_queue, 1)
    self:RandomUnlock()
  end
end