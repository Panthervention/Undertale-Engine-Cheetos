var _battle_state = Battle_GetState(), _menu_state = Battle_GetMenu();
if (
	_battle_state == BATTLE_STATE.IN_TURN ||
	_battle_state == BATTLE_STATE.TURN_PREPARATION ||
   (_battle_state == BATTLE_STATE.MENU    && _menu_state != BATTLE_MENU.FIGHT_AIM && 
    _menu_state != BATTLE_MENU.FIGHT_ANIM && _menu_state != BATTLE_MENU.FIGHT_DAMAGE)
   )
	draw_self();