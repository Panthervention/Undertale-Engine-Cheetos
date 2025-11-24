/* Feather ignore GM2016 */
var _input_vertical = PRESS_VERTICAL,
	_input_horizontal = PRESS_HORIZONTAL,
	_input_confirm = PRESS_CONFIRM,
	_input_cancel = PRESS_CANCEL;
	
if (__menu == -1) // Logo
{
	if (_input_confirm)
	{
		__menu = 0;
		if (!audio_is_playing(__menu_bgm))
			audio_play_sound(__menu_bgm, 0, true);
	}
}
else if (__menu == 0) // Instruction - Main menu
{
	if (__mode == 0) // Instruction Page
	{
		if (_input_vertical != 0)
			__choice = posmod(__choice + _input_vertical, 2);

	    else if (_input_confirm)
	    {
			switch (__choice)
			{
				case 0: // Begin
					__menu = 1;
					break;
				case 1: // Setting
					__menu = 4;
					audio_stop_sound(__menu_bgm);
					if (!audio_is_playing(__season_bgm))
						audio_play_sound(__season_bgm, 0, true);
					break;
			}
	    }
	}
	else // Main Menu
	{
		if (__choice != 2 && _input_horizontal != 0)
		{
			__choice = posmod(__choice + _input_horizontal, 2);
			__choice_previous = __choice;
		}
		
		else if (_input_vertical != 0)
			__choice = (_input_vertical == 1) ? 2 : __choice_previous;

	    else if (_input_confirm)
	    {
			switch (__choice)
			{
				case 0: // Continue
					audio_stop_sound(__menu_bgm);
					Player_Load(0);
		            var _target = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ROOM, -1);
		            if (room_exists(_target))
		                room_goto(_target);
		            else
		                show_message($"CHEETOS: Attempt to goto an unexisting room {_target}");
					break;
				
				case 1: // Reset
					__menu = 2;
	
					TweenDestroy(id);
					
					TweenFire(id, "", 0, off, 0, 270, "__confirm_name_x>", 200, "__confirm_name_y>", 230, "__confirm_name_scale>", 7);
					
		            __naming_name = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, Lexicon("ui.save.name.empty").Get());
		            __confirm_title = Lexicon("menu.confirm.title.reset").Get(); // A name has already been chosen.
					
					__menu_label_confirm_title = scribble(__confirm_title).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
					__menu_label_confirm_title.build(true);
					__menu_label_naming_name   = scribble(__naming_name).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
					__menu_label_naming_name.build(true);
					break;
				
				case 2: // Settings
					__menu = 4;		
					audio_stop_sound(__menu_bgm);
					if (!audio_is_playing(__season_bgm))
						audio_play_sound(__season_bgm, 0, true);
					break;
			}
	    }
	}		
}
else if (__menu == 1) // Naming
{
	if (__choice_naming == 0)
	{	
		#region Letter navigation
		if (_input_horizontal != 0)
			__choice_naming_letter = posmod(__choice_naming_letter + _input_horizontal, 52);

	    else if (_input_vertical != 0)
		{
			if (_input_vertical > 0) // Down pressed
			{
				if (__choice_naming_letter >= 21 && __choice_naming_letter <= 25)
				    __choice_naming_letter += 5;
				else if (__choice_naming_letter >= 19 && __choice_naming_letter <= 20)
				    __choice_naming_letter += 12;
				else if (__choice_naming_letter >= 45)
				{
					__choice_naming = 1;
					var _naming_command = [2, 2, 0, 0, 1, 1, 1];
					__choice_naming_command = _naming_command[__choice_naming_letter - 45];
				}
				else
				    __choice_naming_letter += 7;
			}
			else // Up pressed
			{
				if (__choice_naming_letter <= 6)
				{
				    __choice_naming = 1;
					__choice_naming_command = clamp(floor(__choice_naming_letter * 0.5), 0, 2);
				}
				else if (__choice_naming_letter >= 26 && __choice_naming_letter <= 32)
				    __choice_naming_letter -= (__choice_naming_letter < 31) ? 5 : 12;
				else
				    __choice_naming_letter -= 7;
			}
		}
		#endregion
	    else if (_input_confirm) // Letter add
	    {
	        if (string_length(__naming_name) < __naming_length_limit)
	        {
	            var _text = __naming_letter[# ((__choice_naming_letter) % 26), 0];
	            __naming_name += (__choice_naming_letter < 26 ? _text : string_lower(_text));
				__menu_label_naming_name	= scribble(__naming_name).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
				__menu_label_naming_name.build(true);
	        }
	    }
	    else if (_input_cancel) // Letter remove
	    {
	        if (string_length(__naming_name) > 0)
			{
	            __naming_name = string_delete(__naming_name, string_length(__naming_name), 1);
				__menu_label_naming_name	  = scribble(__naming_name).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
				__menu_label_naming_name.build(true);
			}
	    }
	}
	else
	{
		if (_input_horizontal != 0)
			__choice_naming_command = posmod(__choice_naming_command + _input_horizontal, 3);
 
		else if (_input_vertical != 0)
		{
			switch (__choice_naming_command)
			{
			    case 0:
			        __choice_naming_letter = (_input_vertical > 0) ? 0 : 47;
			        break;
			    case 1:
			        __choice_naming_letter = (_input_vertical > 0) ? 2 : 49;
			        break;
			    case 2:
			        __choice_naming_letter = (_input_vertical > 0) ? 5 : 45;
			        break;
			}
			__choice_naming = 0;
		}
			
	    else if (_input_confirm)
	    {
			switch (__choice_naming_command)
			{
				case 0: // Quit
					__menu = 0;
					break;
					
				case 1: // Backspace
					if (string_length(__naming_name) > 0) // Letter remove
						__naming_name = string_delete(__naming_name, string_length(__naming_name), 1);
						__menu_label_naming_name	= scribble(__naming_name).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
						__menu_label_naming_name.build(true);
					break;
					
				case 2: // Done
					if (__naming_name != "") // Only proceed when name is not empty
					{
						__menu = 2;
						
						event_user(1); // Name validation checking
						
						TweenDestroy(id);
						TweenFire(id, "", 0, off, 0, 270, "__confirm_name_x>", 200, "__confirm_name_y>", 230, "__confirm_name_scale>", 7);
					}
					break;
			}
	    }
	    else if (_input_cancel)
	    {
	        if (string_length(__naming_name) > 0) // Letter remove
			{
	            __naming_name = string_delete(__naming_name, string_length(__naming_name), 1);
				__menu_label_naming_name	= scribble(__naming_name).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
				__menu_label_naming_name.build(true);
			}
	    }
	}
	if (__naming_shake_buffer > 0)
		__naming_shake_buffer --;
	else
	{
		__naming_shake_buffer = __naming_shake_buffer_asign;
		var i = 0;
		repeat (26)
		{
			__naming_letter_shake_x[# i, 0] = random_range(-1, 1);
			__naming_letter_shake_x[# i, 1] = random_range(-1, 1);
			__naming_letter_shake_y[# i, 0] = random_range(-1, 1);
			__naming_letter_shake_y[# i, 1] = random_range(-1, 1);
			i++;
		}
	}
}
else if (__menu == 2) // Name Confirmation
{
	if (_input_horizontal != 0)
		__choice_confirm = (_input_horizontal == 1 && __confirm_valid) ? 1 : 0;
	else if (_input_confirm)
	{
	    if (__choice_confirm == 0) // No
		{
	        __menu = __mode ? 0 : 1;
			TweenDestroy(id);
			__confirm_name_x = 280;
			__confirm_name_y = 110;
			__confirm_name_scale = 2;
		}
	    else // Yes
		{
	        __menu = 3;
			audio_stop_sound(__menu_bgm);
			var _cymbal = audio_play_sound(bgm_cymbal, 0, false);
			audio_sound_gain(_cymbal, 0.8, 0);
			audio_sound_pitch(_cymbal, 0.95)
			audio_sound_set_track_position(_cymbal, 1.4);
			obj_global.fader_color = c_white;
			Fader_Fade(0, 1, 240, c_white);
			alarm[0] = 300;
		}
	}
}
else if (__menu == 4) // Settings
{
	__choice_setting = posmod(__choice_setting + _input_vertical, 4);
	switch (__choice_setting)
	{
		case 0: // Exit
			if (_input_confirm)
			{
				__menu = 0;
				audio_stop_sound(__season_bgm);
				if (!audio_is_playing(__menu_bgm))
					audio_play_sound(__menu_bgm, 0, true);
			}
			break;
		case 1: // Language
			break;
		case 2: // Volume
			if (_input_horizontal != 0)
			{
				__setting_mastervolume = clamp(__setting_mastervolume + _input_horizontal * 5, 0, 100);
				audio_master_gain(__setting_mastervolume / 100);
				Flag_Set(FLAG_TYPE.SETTINGS, FLAG_SETTINGS.VOLUME, __setting_mastervolume);
				Flag_Save(FLAG_TYPE.SETTINGS);
			}
			break;
		case 3: // Border
			if (_input_horizontal != 0)
			{
				// feather disable GM1041
				// __setting_border_option sometimes triggers GM1041 before fixing itself, possibly a product of the fact that feather does not consider User Event 0 as a part of Create.
				__setting_border = clamp(__setting_border + _input_horizontal, 0, array_length(__setting_border_option) - 1);
				// feather enable GM1041
				Border_SetEnabled(__setting_border != 0, __setting_border == 2);
				// feather ignore once GM1063
				// -1 is the empty version of Asset
				Border_SetSprite(__setting_border == 2 ? -1 : spr_border, __setting_border == 3 ? 2 : (__setting_border > 4 ? __setting_border + 4 : 0));
				Flag_Set(FLAG_TYPE.SETTINGS, FLAG_SETTINGS.BORDER, __setting_border);
				Flag_Save(FLAG_TYPE.SETTINGS);
			}
			break;
	}
}

if (__menu == 2 || __menu == 3)
{
    if (__confirm_name_update)
    {
        __confirm_name_offset_x = random_range(-1, 1);
        __confirm_name_offset_y = random_range(-1, 1);
        __confirm_name_angle = random_range(-1, 1);
    }
    __confirm_name_update ^= true;
}
else
{
	__confirm_name_offset_x = 0;
	__confirm_name_offset_y = 0;
	__confirm_name_angle = 0;
	__confirm_name_update = true;
}
