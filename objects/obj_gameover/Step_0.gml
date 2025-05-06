if (__state == 0)
{
	if (__soul_shard_render)
	{
		var _i = 0; repeat(6)
		{
			with (__soul_shard[$ _i])
			{
				__gravity_value += gravity;
				y += __gravity_value;
			
				x += lengthdir_x(speed, direction);
				y += lengthdir_y(speed, direction);
			
				image_index += image_speed;
			
				var _frame_count = sprite_get_number(sprite_index);
				if (image_index >= _frame_count)
					image_index -= _frame_count;
			}
			_i++;
		}
	}
}
else if (__state == 1)
{
	if (image_alpha < 1)
		image_alpha += 0.01;
	else
	{
		if (!__gameover_ever_existed && !instance_exists(obj_textwriter))
		{
			__gameover_ever_existed = true;
			var _textwriter = instance_create_depth(165, 300, depth - 1, obj_textwriter);
			with (_textwriter)
			{
				text_skippable = false;
				text_typist.in(0.25, 0).sound_per_char(voice_asgore, 1, 1, " ", 1);
				text = $"[font_dt_mono][scale, 2]You cannot give\nup just yet...[pause][clear]{Player_GetName()}!\n[sleep, 30]Stay determined...[pause][end]";
			}
		}
		else if (!instance_exists(obj_textwriter))
			__state = 2;
	}
}
else if (__state == 2)
{
	if (image_alpha > 0)
		image_alpha -= 0.01;
	else
	{
		if (__timer < 60)
			__timer++;
		else
		{
			__state = 3;
			var _room_return = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.BATTLE_ROOM_RETURN);
			if (room_exists(_room_return))
			{
				room_goto(_room_return);
				Fader_Fade(1, 0, 60);
			}
			else
				alarm[3] = 1;
		}
	}
}
