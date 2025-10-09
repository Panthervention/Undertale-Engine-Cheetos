#region		Vitalities Interpolation
with (global)
{
	hp = EaseOutQuad(refill_speed, hp, Player_GetHp() - hp, 1);
	hp_max = EaseOutQuad(refill_speed, hp_max, Player_GetHpMax() - hp_max, 1);
	kr = EaseOutQuad(refill_speed, kr, Player_GetKr() - kr, 1);
	
	if (kr > hp - 1)
		kr = hp - 1;
}
#endregion

#region		Global Logic
if (timer >= 60)
{
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.TIME, Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.TIME) + 1);
	timer = 0;
}
else
	timer++;

// Game restart
if ((keyboard_check_pressed(vk_f2)) && !global.f2_locked)
	game_restart();

// Fullscreen
if (keyboard_check_pressed(vk_f4) && !keyboard_check(vk_alt) && !keyboard_check(vk_control) && !keyboard_check(vk_shift))
{
	window_set_fullscreen(!window_get_fullscreen());
	alarm[0] = 1;
	display_set_gui_maximize();
}

// Quitting
if (CHECK_PAUSE)
{
	if (quit_timer++ > 60)
		game_end();
}
else
	quit_timer = (quit_timer > 0) ? (quit_timer - 2) : 0;
#endregion

#region		Camera Logic
camera.Update();
#endregion

#region		Display Border Logic
with (border)
{
	if (enable)
	{
	    if (sprite_exists(sprite_previous) && alpha >= 1)
	    {
	        sprite_flush(sprite_previous);
	        sprite_previous = -1;
	    }
	}
}
#endregion

#region		Debug Logic
if (allow_debug && !released && keyboard_check_pressed(vk_f3))
	global.debug ^= true;
if (global.debug)
{
	with (global)
	{
		__fps_real = floor(fps_real);
		__fps_average = fps_average;
		__fps_min = min(max(__fps_min, 0), __fps_real);
		__fps_max = max(__fps_max, __fps_real);
	}

	var _input_horizontal = PRESS_HORIZONTAL;
	if (keyboard_check(vk_shift))
	{
		if (!debug_fps_lock)
		{
			var _game_speed = game_get_speed(gamespeed_fps);
			game_set_speed(max(1, _game_speed + _input_horizontal * 5), gamespeed_fps);
			if (keyboard_check_pressed(ord("F"))) game_set_speed(600, gamespeed_fps);
			if (keyboard_check_pressed(ord("R"))) game_set_speed(60, gamespeed_fps);
		}
		if (keyboard_check_pressed(ord("H")))
		{
			Player_SetHp(Player_GetHpMax());
			Player_SetKr(0);
			audio_play_sound(snd_item_heal, 0, false);
		}
	}
	if (keyboard_check(vk_control))
	{
		if (keyboard_check_pressed(ord("L")))
			debug_fps_lock ^= true;
		if (keyboard_check_pressed(ord("H")))
			global.show_hitbox ^= true;
	}
		
	if (Player_IsInBattle())
	{
		var _turn_current = Battle_GetTurnNumber();
		if (keyboard_check(vk_control))
			Battle_SetTurnNumber(_turn_current + _input_horizontal);
			
		if (keyboard_check(vk_shift))
		{
			if (keyboard_check_pressed(ord("E")) && instance_exists(obj_battle_turn))
			{
				Battle_EndTurn();
				Battle_SetTurnNumber(_turn_current);
				if (instance_exists(obj_battle_bullet))
					instance_destroy(obj_battle_bullet);
				fader_alpha = 0;
				audio_resume_all();
				TweenDestroy(all);
				with (obj_battle_board)
				{
					x = 320;
					y = 320;
					up = 65;
					down = 65;
					left = 283;
					right = 283;
				}
				with (obj_battle_soul)
				{
					hor_lock = false;
					ver_lock = false;
					fall_multi = 1;
				}
			}
		}
	}
}
#endregion
