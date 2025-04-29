var _input_vertical = PRESS_VERTICAL,
	_input_horizontal = PRESS_HORIZONTAL,
	_input_confirm = PRESS_CONFIRM,
	_input_cancel = PRESS_CANCEL;
	
if (__menu == -1)
{
	if (_input_confirm)
		__menu = 0;
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
					Player_Load(0);
		            var target = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ROOM, -1);
		            if (room_exists(target))
		                room_goto(target);
		            else
		                show_message($"CHEETOS: Attempt to goto an unexisting room {target}");
					break;
				
				case 1: // Reset
					__menu = 2;
					
					if (TweenExists(__tween_confirm_name_x))
						TweenDestroy(__tween_confirm_name_x);
					if (TweenExists(__tween_confirm_name_y))
						TweenDestroy(__tween_confirm_name_y);
					if (TweenExists(__tween_confirm_name_scale))
						TweenDestroy(__tween_confirm_name_scale);
					__tween_confirm_name_x = TweenFire(id, "", 0, off, 0, 270, "__confirm_name_x>", 200);
					__tween_confirm_name_y = TweenFire(id, "", 0, off, 0, 270, "__confirm_name_y>", 230);
					__tween_confirm_name_scale = TweenFire(id, "", 0, off, 0, 270, "__confirm_name_scale>", 7);
		                    
		            __naming_name = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, lexicon_text("ui.save.name.empty"));
		            __confirm_title = lexicon_text("menu.confirm.title.reset"); // A name has already been chosen.
					
					__menu_label_confirm_title = scribble(__confirm_title).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
					__menu_label_confirm_title.build(true);
					__menu_label_naming_name	  = scribble(__naming_name)	.starting_format("font_dt_mono", c_white).transform(2, 2, 0);
					__menu_label_naming_name.build(true);
					break;
				
				case 2: // Settings
					__menu = 4;
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
					__choice_naming_command = floor(__choice_naming_letter * 0.5);
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
				__menu_label_naming_name	= scribble(__naming_name).starting_format("font_dt_mono", c_white).transform(2, 2, 0);
				__menu_label_naming_name.build(true);
	        }
	    }
	    else if (_input_cancel) // Letter remove
	    {
	        if (string_length(__naming_name) > 0)
			{
	            __naming_name = string_delete(__naming_name, string_length(__naming_name), 1);
				__menu_label_naming_name	  = scribble(__naming_name)	.starting_format("font_dt_mono", c_white).transform(2, 2, 0);
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
						__menu_label_naming_name	= scribble(__naming_name).starting_format("font_dt_mono", c_white).transform(2, 2, 0);
						__menu_label_naming_name.build(true);
					break;
					
				case 2: // Done
					if (__naming_name != "") // Only proceed when name is not empty
					{
						__menu = 2;
						
						event_user(1); // Name validation checking
						
						if (TweenExists(__tween_confirm_name_x))
							TweenDestroy(__tween_confirm_name_x);
						if (TweenExists(__tween_confirm_name_y))
							TweenDestroy(__tween_confirm_name_y);
						if (TweenExists(__tween_confirm_name_scale))
							TweenDestroy(__tween_confirm_name_scale);
						__tween_confirm_name_x = TweenFire(id, "", 0, off, 0, 270, "__confirm_name_x>", 200);
						__tween_confirm_name_y = TweenFire(id, "", 0, off, 0, 270, "__confirm_name_y>", 230);
						__tween_confirm_name_scale = TweenFire(id, "", 0, off, 0, 270, "__confirm_name_scale>", 7);
					}
					break;
			}
	    }
	    else if (_input_cancel)
	    {
	        if (string_length(__naming_name) > 0) // Letter remove
			{
	            __naming_name = string_delete(__naming_name, string_length(__naming_name), 1);
				__menu_label_naming_name	= scribble(__naming_name).starting_format("font_dt_mono", c_white).transform(2, 2, 0);
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
		__choice_confirm = (_input_horizontal == 1 && __confirm_valid) ? 1 : 0
	else if (_input_confirm)
	{
	    if (__choice_confirm == 0) // No
		{
	        __menu = (!__mode ? 1 : 0);
			if (TweenExists(__tween_confirm_name_x))
				TweenDestroy(__tween_confirm_name_x);
			if (TweenExists(__tween_confirm_name_y))
				TweenDestroy(__tween_confirm_name_y);
			if (TweenExists(__tween_confirm_name_scale))
				TweenDestroy(__tween_confirm_name_scale);
			__confirm_name_x = 280;
			__confirm_name_y = 110;
			__confirm_name_scale = 2;
		}
	    else // Yes
		{
	        __menu = 3;
			audio_sound_set_track_position(audio_play_sound(snd_cymbal, 0, false), 1.4);
			obj_global.fader_color = c_white;
			Fader_Fade(0, 1, 240, c_white);
			alarm[0] = 240;
		}
	}
}
else if (__menu == 4) // Settings
{
	// Such emptiness... Maybe you can cook one up?
}

if (__menu == 2 || __menu == 3)
{
    if (__confirm_name_update)
    {
        __confirm_name_offset_x = random_range(-1, 1);
        __confirm_name_offset_y = random_range(-1, 1);
        __confirm_name_angle = random_range(-1, 1);
    }
    __confirm_name_update = !__confirm_name_update;
}
else
{
	__confirm_name_offset_x = 0;
	__confirm_name_offset_y = 0;
	__confirm_name_angle = 0;
	__confirm_name_update = true;
}
