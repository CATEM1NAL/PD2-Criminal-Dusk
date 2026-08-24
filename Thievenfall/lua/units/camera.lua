local tmp_rot1 = Rotation()

Hooks:PostHook(SecurityCamera, "set_detection_enabled", "CrimDusk_SetInitialCamYaw", function(self, _, settings)
  if settings then
    self:apply_rotations(0, settings.pitch)
    self.rotate_speed = (math.random(0, 1) * 2 - 1) * math.random()
    self._rotation_allowed_t = 0
  end
end)

Hooks:OverrideFunction(SecurityCamera, "_upd_detection", function(self, t)
  local dt = t - self._last_detect_t

  if dt > self._detection_interval then
    self._last_detect_t = t

    if NetworkHelper:IsHost() and t > self._rotation_allowed_t then
      if self._yaw + self.rotate_speed >= 50 or self._yaw + self.rotate_speed <= -50 then
        self.rotate_speed = -self.rotate_speed
        self._rotation_allowed_t = t + 5
      end

      self:apply_rotations(self._yaw + self.rotate_speed, self._pitch)
    end

    --[[ Enable debug camera radius
    --ORIGINAL INTENT WAS TO USE FOR CAMERA VISUALISATION LIKE PAYDAY 3
    --SHOULDN'T BE USED FOR NOW, CONES CLIP THROUGH WALLS AND LOOK ASS
    local ConeColour = next(self._detected_attention_objects) and Color(0.05, 1, 0, 0) or Color(0.05, 0, 1, 0)
    self._brush = self._brush or Draw:brush(ConeColour, self._detection_interval)
    self._look_obj:m_position(self._tmp_vec1)
    local cone_base = self._look_obj:rotation():y()
    mvector3.multiply(cone_base, self._range)
    mvector3.add(cone_base, self._tmp_vec1)
    local cone_base_rad = math.tan(self._cone_angle * 0.5) * self._range
    self._brush:cone(self._tmp_vec1, cone_base, cone_base_rad, 16)
    ]]

    if not self._look_fwd then
      self._look_obj:m_rotation(tmp_rot1)
      self._look_fwd = Vector3()
      mrotation.y(tmp_rot1, self._look_fwd)
    end

    self:_upd_acquire_new_attention_objects(t)
    self:_upd_detect_attention_objects(t)
    self:_upd_suspicion(t)
  end
end)