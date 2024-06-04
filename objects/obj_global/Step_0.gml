#region Stats lerping
global.hp = EaseOutQuad(global.refill_speed, global.hp, Player_GetHp() - global.hp, 1);
global.hp_max = EaseOutQuad(global.refill_speed, global.hp_max, Player_GetHpMax() - global.hp_max, 1);
global.kr = EaseOutQuad(global.refill_speed, global.kr, Player_GetKr() - global.kr, 1);
#endregion

#region Debug
if allow_debug && !released && (keyboard_check_pressed(vk_f3))
	global.debug = !global.debug;
if global.debug
{
	var input_horizontal = PRESS_HORIZONTAL;
	global._fps_real = floor(fps_real);
	global._fps_average = fps_average;
	global._fps_min = min(max(global._fps_min, 0), global._fps_real);
	global._fps_max = max(global._fps_max, global._fps_real);
	if keyboard_check(vk_shift)
	{
		if !debug_fps_lock
		{
			var game_speed = game_get_speed(gamespeed_fps);
			game_set_speed(max(1, game_speed + input_horizontal * 5), gamespeed_fps);
			if keyboard_check_pressed(ord("F")) room_speed = 600;
			if keyboard_check_pressed(ord("R")) room_speed = 60;
		}
		if keyboard_check_pressed(ord("H"))
		{
			Player_SetHp(Player_GetHpMax());
			Player_SetKr(0);
			audio_play_sound(snd_item_heal, 0, false);
		}
	}
	if keyboard_check(vk_control)
	{
		if keyboard_check_pressed(ord("L"))
			debug_fps_lock = !debug_fps_lock;
		if keyboard_check_pressed(ord("H"))
			global.show_hitbox = !global.show_hitbox;
	}
		
	if Player_IsInBattle()
	{
		var current_turn = Battle_GetTurnNumber();
		if keyboard_check(vk_control)
			Battle_SetTurnNumber(current_turn + input_horizontal);
			
		if keyboard_check(vk_shift)
		{
			if keyboard_check_pressed(ord("E")) and instance_exists(obj_battle_turn)
			{
				Battle_EndTurn();
				Battle_SetTurnNumber(current_turn);
				if instance_exists(obj_battle_bullet)
					instance_destroy(obj_battle_bullet);
				cam_angle = 0;
				fader_alpha = 0;
				audio_resume_all();
				with obj_battle_controller
					TweenDestroy({target: id});
				with obj_battle_turn
					TweenDestroy({target: id});
				with obj_battle_bullet
					TweenDestroy({target: id});
				with obj_battle_board
				{
					TweenDestroy({target: id});
					x = 320;
					y = 320;
					up = 65;
					down = 65;
					left = 283;
					right = 283;
				}
				with obj_battle_soul
				{
					hor_lock = false;
					ver_lock = false;
					fall_multi = 1;
					TweenDestroy({target: id});
				}
			}
		}
	}
}
#endregion

#region Global Functions
if (timer >= 60)
{
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.TIME, Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.TIME) + 1);
	timer = 0;
}
else
	timer += 1;

if ((keyboard_check_pressed(vk_f2)) && !global.f2_locked)
	game_restart();

if (keyboard_check_pressed(vk_f4) && !keyboard_check(vk_alt) && !keyboard_check(vk_control) && !keyboard_check(vk_shift))
{
	window_set_fullscreen(!window_get_fullscreen());
	alarm[0] = 1;
	display_set_gui_maximize();
}
	
if (keyboard_check(vk_escape))
{
	quit_timer += 1;
	if (quit_timer >= 60)
		game_end();
}
else
{
	if quit_timer > 0 quit_timer -= 2;
	else quit_timer = 0
}
#endregion

#region Camera Functions
if (cam_shake_x > 0)
{
	if (_cam_shake_time_x > 0)
	    _cam_shake_time_x -= 1;
	else
	{
	    if (!cam_shake_random_x)
	    {
	        if (_cam_shake_positive_x)
	            _cam_shake_pos_x = cam_shake_x;
	        else
	        {
	            cam_shake_x -= cam_shake_decrease_x;
	            _cam_shake_pos_x = -cam_shake_x;
	        }
	        _cam_shake_positive_x = !_cam_shake_positive_x;
	    }
	    else
	    {
	        _cam_shake_pos_x = random_range(-cam_shake_x, cam_shake_x);
	        cam_shake_x -= cam_shake_decrease_x;
	    }
	    _cam_shake_time_x = cam_shake_speed_x;
	}
}
else
{
	cam_shake_speed_x = 0;
	cam_shake_decrease_x = 1;
	cam_shake_random_x = false;
	_cam_shake_time_x = 0;
	_cam_shake_pos_x = 0;
	_cam_shake_positive_x = true;
}
if (cam_shake_y > 0)
{
	if (_cam_shake_time_y > 0)
	    _cam_shake_time_y -= 1;
	else
	{
	    if (!cam_shake_random_y)
	    {
	        if (_cam_shake_positive_y)
	            _cam_shake_pos_y = cam_shake_y;
	        else
	        {
	            cam_shake_y -= cam_shake_decrease_y;
	            _cam_shake_pos_y = -cam_shake_y;
	        }
	        _cam_shake_positive_y = !_cam_shake_positive_y;
	    }
	    else
	    {
	        _cam_shake_pos_y = random_range(-cam_shake_y, cam_shake_y);
	        cam_shake_y -= cam_shake_decrease_y;
	    }
	    _cam_shake_time_y = cam_shake_speed_y;
	}
}
else
{
	cam_shake_speed_y = 0;
	cam_shake_decrease_y = 1;
	cam_shake_random_y = false;
	_cam_shake_time_y = 0;
	_cam_shake_pos_y = 0;
	_cam_shake_positive_y = true;
}


if (!instance_exists(cam_target))
{
	camera_set_view_target(global.camera, noone);
	camera_set_view_pos(global.camera, cam_x + _cam_shake_pos_x, cam_y + _cam_shake_pos_y);
}
else
{
	camera_set_view_target(global.camera, cam_target);
	camera_set_view_border(global.camera, cam_width / cam_scale_x / 2, cam_height / cam_scale_y / 2);
	cam_x = camera_get_view_x(global.camera);
	cam_y = camera_get_view_y(global.camera);
}
camera_set_view_size(global.camera, cam_width / cam_scale_x, cam_height / cam_scale_y);
camera_set_view_angle(global.camera, cam_angle);
#endregion

#region Border Functions
if (border_enable)
{
    if (sprite_exists(border_sprite_previous) && border_alpha >= 1)
    {
        sprite_flush(border_sprite_previous);
        border_sprite_previous = -1;
    }
}
#endregion
