var _battle_state = Battle_GetState(), _menu_state = Battle_GetMenu();
if (
	_battle_state == BATTLE_STATE.IN_TURN ||
	_battle_state == BATTLE_STATE.TURN_PREPARATION ||
   (_battle_state == BATTLE_STATE.MENU    && _menu_state != BATTLE_MENU.FIGHT_AIM && 
    _menu_state != BATTLE_MENU.FIGHT_ANIM && _menu_state != BATTLE_MENU.FIGHT_DAMAGE)
   )
	draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);  // Forces it to be drawn on pixels