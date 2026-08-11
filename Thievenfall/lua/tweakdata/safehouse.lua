Hooks:PostHook(CustomSafehouseTweakData, "_init_map", "CrimDusk_InitSafehouseMap", function(self)
  for floor, _ in ipairs(self.map.floors) do
    for i = #self.map.floors[floor].rooms, 1, -1 do

      if self.map.floors[floor].rooms[i] == "old_hoxton" and (Global.CrimDusk.data["heists_won" .. CrimDusk.IsPermadeath()] > 4 and Global.CrimDusk.data.free_hoxton < 4) then
        table.remove(self.map.floors[floor].rooms, i)

      elseif self.map.floors[floor].rooms[i] == "wild" and not Global.CrimDusk.data["rust_recruited" .. CrimDusk.IsPermadeath()] then
        table.remove(self.map.floors[floor].rooms, i)
      end

    end
  end
end)

Hooks:PostHook(CustomSafehouseTweakData, "_init_trophies", "CrimDusk_InitTrophies", function(self)
  for _, trophy in ipairs(self.trophies) do
    if trophy.id == "trophy_bains_book" then trophy.objectives = { self:_achievement("nmh_7") }
    elseif trophy.id == "trophy_box_3" then trophy.objectives = { self:_achievement("des_7") }
    elseif trophy.id == "trophy_ace" then trophy.objectives = { self:_progress("trophy_ace", 1, { name_id = "trophy_ace_progress" }) }
    elseif trophy.id == "trophy_black_plate" then trophy.objectives = { self:_achievement("sah_7") }
    elseif trophy.id == "trophy_brb_1" then trophy.objectives = { self:_achievement("brb_7") }
    elseif trophy.id == "trophy_box_1" then trophy.objectives = { self:_achievement("ggez_46"), self:_achievement("des_7") }
    elseif trophy.id == "trophy_box_2" then trophy.objectives = { self:_achievement("tag_7") }
    elseif trophy.id == "trophy_computer" then trophy.objectives = { self:_achievement("gage2_1") }
    elseif trophy.id == "trophy_smwish" then trophy.objectives = { self:_achievement("vit_7") }

    elseif trophy.id == "trophy_pacifier" then
      trophy.objectives = {
        self:_progress("trophy_basics_stealth", 1, { name_id = "heist_short1_stage1_hl" }),
        self:_progress("trophy_basics_stealth_2", 1, { name_id = "heist_short1_stage2_hl" }),
        self:_progress("trophy_basics_loud", 1, { name_id = "heist_short2_stage1_hl" })
      }

    elseif trophy.id == "trophy_stealth" then
      trophy.objectives = {
        self:_progress("trophy_stealth", 14, {
          name_id = "trophy_stealth_progress", verify = "_verify_unique_heist", save_values = { "completed_heists" }
        })
      }

    elseif trophy.id == "trophy_transports" then
      trophy.objectives = {
        self:_progress("trophy_transport_crossroads", 1, { name_id = "heist_arm_cro" }),
        self:_progress("trophy_transport_downtown", 1, { name_id = "heist_arm_hcm" }),
        self:_progress("trophy_transport_harbor", 1, { name_id = "heist_arm_fac" }),
        self:_progress("trophy_transport_park", 1, { name_id = "heist_arm_par" }),
        self:_progress("trophy_transport_underpass", 1, { name_id = "heist_arm_und" })
      }
    end
  end
end)