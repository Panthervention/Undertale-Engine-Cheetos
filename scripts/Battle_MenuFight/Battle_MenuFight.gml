#region Damage

function Battle_GetMenuFightDamage() {
	return obj_battle_controller.__menu_fight_damage;
}

///@param damage
function Battle_SetMenuFightDamage(damage) {
	if (damage >= -1)
	{
	    obj_battle_controller.__menu_fight_damage = damage;
	    return true;
	}
	else
	    return false;
}

#endregion

#region Anim Time

function Battle_GetMenuFightAnimTime() {
	return obj_battle_controller.__menu_fight_anim_time;
}

///@param time
function Battle_SetMenuFightAnimTime(TIME) {
	var MENU = Battle_GetMenu();

	if ((MENU == BATTLE_MENU.FIGHT_AIM || MENU == BATTLE_MENU.FIGHT_ANIM) && TIME >= -1)
	{
	    obj_battle_controller.__menu_fight_anim_time = TIME;
	    return true;
	}
	else
	    return false;
}

#endregion

#region Damage Time

function Battle_GetMenuFightDamageTime() {
	return obj_battle_controller.__menu_fight_damage_time;
}

///@param time
function Battle_SetMenuFightDamageTime(TIME) {
	var MENU = Battle_GetMenu();

	if ( (MENU == BATTLE_MENU.FIGHT_AIM ||
		  MENU == BATTLE_MENU.FIGHT_ANIM || 
		  MENU == BATTLE_MENU.FIGHT_DAMAGE) && TIME >= -1)
	{
	    obj_battle_controller.__menu_fight_damage_time = TIME;
	    return true;
	}
	else
	    return false;
}

#endregion

#region Ending

function Battle_EndMenuFightAnim() {
	if (Battle_GetMenu() == BATTLE_MENU.FIGHT_ANIM)
	{
	    Battle_SetMenuFightAnimTime(0);
	    Battle_SetMenu(BATTLE_MENU.FIGHT_DAMAGE);
	    return true;
	}
	else
	    return false;
}

function Battle_EndMenuFightAim() {
	if (Battle_GetMenu() == BATTLE_MENU.FIGHT_AIM)
	{
	    Battle_SetMenu(BATTLE_MENU.FIGHT_ANIM);
	    return true;
	}
	else
	    return false;
}

function Battle_EndMenuFightDamage() {
	if (Battle_GetMenu() == BATTLE_MENU.FIGHT_DAMAGE)
	{
	    Battle_EndMenu();
	    return true;
	}
	else
	    return false;
}

#endregion
