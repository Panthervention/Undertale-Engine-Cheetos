var STATE = Battle_GetState();
var MENU = Battle_GetMenu();
if (
	STATE == BATTLE_STATE.IN_TURN or 
	STATE == BATTLE_STATE.TURN_PREPARATION or 
   (STATE == BATTLE_STATE.MENU     and MENU != BATTLE_MENU.FIGHT_AIM and 
    MENU != BATTLE_MENU.FIGHT_ANIM and MENU != BATTLE_MENU.FIGHT_DAMAGE)
   )
	draw_self();

if effect
{
	var _sprite = sprite_index;
	var _xscale = effect_xscale;
	var _yscale = effect_yscale;
	var _alpha = effect_alpha;
	var _angle = effect_angle;
	var _color = image_blend;
	var _x = effect_x;
	var _y = effect_y;
	draw_sprite_ext(_sprite,0,_x,_y,_xscale,_yscale,_angle,_color,_alpha);
}

