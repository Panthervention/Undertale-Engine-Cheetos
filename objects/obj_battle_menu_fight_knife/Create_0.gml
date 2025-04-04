event_inherited();

__dir = choose(DIR.LEFT, DIR.RIGHT);
__input_acceptable = 1;
__aim_x = 0;
__aim_image = 0;
__aim_angle = 0;
__aim_confirm = false;

__effect = false;
__effect_xscale = 1;
__effect_yscale = 1;
__effect_alpha = 1;
__effect_color = c_white;

__aim_x = (__dir == DIR.LEFT) ?
		 (x - obj_battle_board.left - sprite_get_width(spr_battle_menu_fight_aim) / 2):
		 (x + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_aim) / 2);
__aim_x_change = (__dir == DIR.LEFT) ?
				 (obj_battle_board.left + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_aim)):
				-(obj_battle_board.left + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_aim));
__aim_x_target = __aim_x + __aim_x_change;
__aim_x_tween = TweenFire(id, "", 0, off, 0, 90, "__aim_x>", __aim_x_target);

global.menu_hurt = "de-activated";
global.deadable = true;
