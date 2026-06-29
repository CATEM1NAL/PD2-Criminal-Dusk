Hooks:PostHook(DoctorBagBase, "init", "CrimDusk_InitDoctorBag", function(self)
  self._max_amount = tweak_data.upgrades.doctor_bag_base
end)