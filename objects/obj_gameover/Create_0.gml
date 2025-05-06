var _x = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_X),
	_y = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_Y);
x = _x;
y = _y;

image_speed = 0;
image_blend = c_red;
image_angle = DIR.DOWN;

audio_stop_all();

alarm[0] = 40;

__state = 0;
__timer = 0;
__gameover_ever_existed = false;

__soul_shard = {};
__soul_shard_render = false;
var _i = 0; repeat(6)
{
	__soul_shard[$ _i] = {};
	with (__soul_shard[$ _i])
	{
		sprite_index = spr_battle_soul_slice;
		image_index = 0;
		x = _x;
		y = _y;
		image_speed = 1/4;
		image_xscale = 1;
		image_yscale = 1;
		image_angle = 0;
		image_blend = c_red;
		image_alpha = 1;
		
		gravity = 0.1;
		speed = 3.5;
		direction = random(360);
		
		__gravity_value = 0;
	}
	_i++;
}
