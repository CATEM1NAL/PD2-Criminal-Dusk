if not managers.player:player_unit() or not managers.player:player_unit():movement() or not managers.player:player_unit():movement():current_state() then return end
local ValidState = { standard = true, carry = true }
log(managers.player:current_state())

if ValidState[managers.player:current_state()] and managers.player:player_unit():movement():current_state():_melee_repeat_allowed() then
  local CurrentMelee = managers.blackmarket:equipped_melee_weapon()

  Global.blackmarket_manager.melee_weapons[CurrentMelee].equipped = false
  Global.blackmarket_manager.melee_weapons.weapon.equipped = true
  Global.blackmarket_manager.melee_weapons.weapon.unlocked = true

  managers.player:player_unit():movement():current_state():_do_action_melee(managers.player:player_timer():time())

  Global.blackmarket_manager.melee_weapons[CurrentMelee].equipped = true
  Global.blackmarket_manager.melee_weapons.weapon.equipped = false
  Global.blackmarket_manager.melee_weapons.weapon.unlocked = false
end