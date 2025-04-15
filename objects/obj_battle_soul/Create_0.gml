depth = DEPTH_BATTLE.SOUL;
image_speed = 0;
image_blend = c_red;
image_angle = DIR.DOWN

follow_board = false;

with (global)
{
	inv = 0;
	deadable = true;
	kr_enable = false;
}

mode = SOUL_MODE.RED;

fall_spd = 0;
fall_grav = 0;
fall_multi = 1;

on_ground = false;
on_ceil = false;
on_platform = false;

platform_check = noone;

slam = false;

moveable = true;
hor_lock = false;
ver_lock = false;

effect = false;
effect_xscale = 1;
effect_yscale = 1;
effect_alpha = 1;
effect_angle = image_angle;
effect_x = x;
effect_y = y;

tween = noone;
