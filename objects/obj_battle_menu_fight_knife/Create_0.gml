event_inherited();
_dir = choose(DIR.LEFT, DIR.RIGHT);
_input_acceptable = 1;
_aim_x = 0;
_aim_image = 0;
_aim_angle = 0;
_aim_confirm = false;

_effect = false;
_effect_xscale = 1;
_effect_yscale = 1;
_effect_alpha = 1;
_effect_color = c_white;

_aim_x = (_dir == DIR.LEFT) ?
		 (x - obj_battle_board.left - sprite_get_width(spr_battle_menu_fight_aim) / 2):
		 (x + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_aim) / 2);
_aim_x_change = (_dir == DIR.LEFT) ?
				 (obj_battle_board.left + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_aim)):
				-(obj_battle_board.left + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_aim));
_aim_x_target = _aim_x + _aim_x_change;
_aim_x_tween = TweenFire(id, "ioQuad", 0, off, 0, 90, "_aim_x>", _aim_x_target);

global.menu_hurt = "de-activated";
global.deadable = true;
