var _battle_state = Battle_GetState(), _menu_state = Battle_GetMenu();
if (
	_battle_state == BATTLE_STATE.IN_TURN || 
	_battle_state == BATTLE_STATE.TURN_PREPARATION || 
   (_battle_state == BATTLE_STATE.MENU    && _menu_state != BATTLE_MENU.FIGHT_AIM && 
    _menu_state != BATTLE_MENU.FIGHT_ANIM && _menu_state != BATTLE_MENU.FIGHT_DAMAGE)
   )
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle + 90, image_blend, image_alpha);

if (effect)
{
	var _sprite = sprite_index;
	var _xscale = effect_xscale;
	var _yscale = effect_yscale;
	var _alpha = effect_alpha;
	var _angle = effect_angle;
	var _color = image_blend;
	var _x = effect_x;
	var _y = effect_y;
	draw_sprite_ext(_sprite, 0, _x, _y, _xscale, _yscale, _angle + 90, _color, _alpha);
}

