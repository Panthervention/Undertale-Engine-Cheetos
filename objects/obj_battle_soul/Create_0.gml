depth = DEPTH_BATTLE.SOUL;
image_speed = 0;
image_blend = c_red;
image_angle = DIR.DOWN;

follow_board = false;

with (global)
{
	inv = 0;
	deadable = true;
	kr_enable = false;
}

mode = SOUL.RED;

jump_input = 0;
move_input = 0;
				
fall_spd = 0;
fall_grav = 0;
fall_multi = 1;

slam = false;

moveable = true;
hor_lock = false;
ver_lock = false;

input_rotateable = false;

after_effect_angle = image_angle;

__after_effect_system = part_system_create();
__after_effect_type = part_type_create();

part_system_depth(__after_effect_system, depth - 1);
part_type_sprite(__after_effect_type, sprite_index, false, false, false);
part_type_life(__after_effect_type, 1/0.035, 1/0.035);
part_type_size(__after_effect_type, 1, 1, 0.15, 0);
part_type_alpha2(__after_effect_type, 1, 0);

