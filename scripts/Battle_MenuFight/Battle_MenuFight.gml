#region Damage
///@func Battle_GetMenuFightDamage()
///@desc Return the damage value of the menu fight.
///@return {Real}
function Battle_GetMenuFightDamage() {
	return obj_battle_controller.__menu_fight_damage;
}

///@func Battle_SetMenuFightDamage(damage)
///@desc Set the damage value of the menu fight.
///@param {Real}	damage		The damage value to set (must be higher or equal -1).
function Battle_SetMenuFightDamage(_damage) {
	if (_damage >= -1)
	    obj_battle_controller.__menu_fight_damage = _damage;
}
#endregion

#region Anim Time
///@func Battle_GetMenuFightAnimTime()
///@desc Return the timer of the menu fight aiming sequence.
///@return {Real}
function Battle_GetMenuFightAnimTime() {
	return obj_battle_controller.__menu_fight_anim_time;
}

///@func Battle_SetMenuFightAnimTime(time)
///@desc Set the timer of the menu fight aiming sequence.
///@param {Real}	time	The timer value to set.
function Battle_SetMenuFightAnimTime(_time) {
	var _menu_state = Battle_GetMenu();
	if ((_menu_state == BATTLE_MENU.FIGHT_AIM || _menu_state == BATTLE_MENU.FIGHT_ANIM) && _time >= -1)
	    obj_battle_controller.__menu_fight_anim_time = _time;
}
#endregion

#region Damage Time
///@func Battle_GetMenuFightDamageTime()
///@desc Return the timer of the menu fight damage sequence.
///@return {Real}
function Battle_GetMenuFightDamageTime() {
	return obj_battle_controller.__menu_fight_damage_time;
}

///@func Battle_SetMenuFightDamageTime(time)
///@desc Set the timer of the menu fight damage sequence.
///@param {Real}	time	The timer value to set.
function Battle_SetMenuFightDamageTime(_time) {
	var _menu_state = Battle_GetMenu();
	if ((_menu_state == BATTLE_MENU.FIGHT_AIM  ||
		 _menu_state == BATTLE_MENU.FIGHT_ANIM || 
		 _menu_state == BATTLE_MENU.FIGHT_DAMAGE) && _time >= -1)
		obj_battle_controller.__menu_fight_damage_time = _time;
}
#endregion

#region Ending
///@func Battle_EndMenuFightAnim()
///@desc End the menu fight animation sequence.
function Battle_EndMenuFightAnim() {
	if (Battle_GetMenu() == BATTLE_MENU.FIGHT_ANIM)
	{
	    Battle_SetMenuFightAnimTime(0);
	    Battle_SetMenu(BATTLE_MENU.FIGHT_DAMAGE);
	}
}

///@func Battle_EndMenuFightAim()
///@desc End the menu fight aiming sequence.
function Battle_EndMenuFightAim() {
	if (Battle_GetMenu() == BATTLE_MENU.FIGHT_AIM)
	    Battle_SetMenu(BATTLE_MENU.FIGHT_ANIM);
}

///@func Battle_EndMenuFightDamage()
///@desc End the menu fight damage sequence.
function Battle_EndMenuFightDamage() {
	if (Battle_GetMenu() == BATTLE_MENU.FIGHT_DAMAGE)
	    Battle_EndMenu();
}
#endregion
