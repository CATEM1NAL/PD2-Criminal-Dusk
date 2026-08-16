local player = managers.player:player_unit()
if not player or not player:movement() or not player:movement():current_state() or player:movement():current_state():_interacting() then return end
CrimDusk.Log("QuickMelee", managers.player:current_state(), true)

local ValidState = { standard = true, carry = true }
if ValidState[managers.player:current_state()] and player:movement():current_state():_melee_repeat_allowed() then
  local CurrentMelee = managers.blackmarket:equipped_melee_weapon()

  Global.blackmarket_manager.melee_weapons[CurrentMelee].equipped = false
  Global.blackmarket_manager.melee_weapons.weapon.equipped = true
  Global.blackmarket_manager.melee_weapons.weapon.unlocked = true

  player:movement():current_state():_do_action_melee(managers.player:player_timer():time())

  Global.blackmarket_manager.melee_weapons[CurrentMelee].equipped = true
  Global.blackmarket_manager.melee_weapons.weapon.equipped = false
  Global.blackmarket_manager.melee_weapons.weapon.unlocked = false
end