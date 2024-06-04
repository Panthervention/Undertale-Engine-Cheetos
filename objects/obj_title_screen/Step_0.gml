var input_vertical = PRESS_VERTICAL,
	input_horizontal = PRESS_HORIZONTAL,
	input_confirm = PRESS_CONFIRM,
	input_cancel = PRESS_CANCEL;
	
if (_menu == -1)
{
	if (input_confirm)
		_menu = 0;
}
else if (_menu == 0) // Instruction - Main menu
{
	if (_mode == 0) // Instruction Page
	{
		if (input_vertical != 0)
			_choice = posmod(_choice + input_vertical, 2);

	    else if (input_confirm)
	    {
			switch (_choice)
			{
				case 0: // Begin
					_menu = 1;
					break;
				case 1: // Setting
					_menu = 4;
					break;
			}
	    }
	}
	else // Main Menu
	{
		if (_choice != 2 && input_horizontal != 0)
		{
			_choice = posmod(_choice + input_horizontal, 2);
			_choice_previous = _choice;
		}
		
		else if (input_vertical != 0)
			_choice = (input_vertical == 1) ? 2 : _choice_previous;

	    else if (input_confirm)
	    {
			switch (_choice)
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
					_menu = 2;
					
					if (TweenExists(_tween_confirm_name_x))
						TweenDestroy(_tween_confirm_name_x);
					if (TweenExists(_tween_confirm_name_y))
						TweenDestroy(_tween_confirm_name_y);
					if (TweenExists(_tween_confirm_name_scale))
						TweenDestroy(_tween_confirm_name_scale);
					_tween_confirm_name_x = TweenFire(id, "", 0, off, 0, 270, "_confirm_name_x>", 200);
					_tween_confirm_name_y = TweenFire(id, "", 0, off, 0, 270, "_confirm_name_y>", 230);
					_tween_confirm_name_scale = TweenFire(id, "", 0, off, 0, 270, "_confirm_name_scale>", 7);
		                    
		            _naming_name = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, lexicon_text("ui.save.name.empty"));
		            _confirm_title = lexicon_text("menu.confirm.title.reset"); // A name has already been chosen.
					
					_menu_label_confirm_title = scribble(_confirm_title).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
					_menu_label_confirm_title.build(true);
					_menu_label_naming_name	  = scribble(_naming_name)	.starting_format("font_dt_mono", c_white).transform(2, 2, 0);
					_menu_label_naming_name.build(true);
					break;
				
				case 2: // Settings
					_menu = 4;
					break;
			}
	    }
	}		
}
else if (_menu == 1) // Naming
{
	if (_choice_naming == 0)
	{	
		#region Letter navigation
		if (input_horizontal != 0)
			_choice_naming_letter = posmod(_choice_naming_letter + input_horizontal, 52);

	    else if (input_vertical != 0)
		{
			if (input_vertical > 0) // Down pressed
			{
				if (_choice_naming_letter >= 21 && _choice_naming_letter <= 25)
				    _choice_naming_letter += 5;
				else if (_choice_naming_letter >= 19 && _choice_naming_letter <= 20)
				    _choice_naming_letter += 12;
				else if (_choice_naming_letter >= 45)
				{
					_choice_naming = 1;
					var naming_command = [2, 2, 0, 0, 1, 1, 1];
					_choice_naming_command = naming_command[_choice_naming_letter - 45];
				}
				else
				    _choice_naming_letter += 7;
			}
			else // Up pressed
			{
				if (_choice_naming_letter <= 6)
				{
				    _choice_naming = 1;
					_choice_naming_command = floor(_choice_naming_letter * 0.5);
				}
				else if (_choice_naming_letter >= 26 && _choice_naming_letter <= 32)
				    _choice_naming_letter -= (_choice_naming_letter < 31) ? 5 : 12;
				else
				    _choice_naming_letter -= 7;
			}
		}
		#endregion
	    else if (input_confirm) // Letter add
	    {
	        if (string_length(_naming_name) < _naming_length_limit)
	        {
	            var text = _naming_letter[# ((_choice_naming_letter) % 26), 0];
	            _naming_name += (_choice_naming_letter < 26 ? text : string_lower_buffer(text));
				_menu_label_naming_name	= scribble(_naming_name).starting_format("font_dt_mono", c_white).transform(2, 2, 0);
				_menu_label_naming_name.build(true);
	        }
	    }
	    else if (input_cancel) // Letter remove
	    {
	        if (string_length(_naming_name) > 0)
			{
	            _naming_name = string_delete(_naming_name, string_length(_naming_name), 1);
				_menu_label_naming_name	  = scribble(_naming_name)	.starting_format("font_dt_mono", c_white).transform(2, 2, 0);
				_menu_label_naming_name.build(true);
			}
	    }
	}
	else
	{
		if (input_horizontal != 0)
			_choice_naming_command = posmod(_choice_naming_command + input_horizontal, 3);
 
		else if (input_vertical != 0)
		{
			switch (_choice_naming_command)
			{
			    case 0:
			        _choice_naming_letter = (input_vertical > 0) ? 0 : 47;
			        break;
			    case 1:
			        _choice_naming_letter = (input_vertical > 0) ? 2 : 49;
			        break;
			    case 2:
			        _choice_naming_letter = (input_vertical > 0) ? 5 : 45;
			        break;
			}
			_choice_naming = 0;
		}
			
	    else if (input_confirm)
	    {
			switch (_choice_naming_command)
			{
				case 0: // Quit
					_menu = 0;
					break;
					
				case 1: // Backspace
					if (string_length(_naming_name) > 0) // Letter remove
						_naming_name = string_delete(_naming_name, string_length(_naming_name), 1);
						_menu_label_naming_name	= scribble(_naming_name).starting_format("font_dt_mono", c_white).transform(2, 2, 0);
						_menu_label_naming_name.build(true);
					break;
					
				case 2: // Done
					if (_naming_name != "") // Only proceed when name is not empty
					{
						_menu = 2;
						
						event_user(1); // Name validation checking
						
						if (TweenExists(_tween_confirm_name_x))
							TweenDestroy(_tween_confirm_name_x);
						if (TweenExists(_tween_confirm_name_y))
							TweenDestroy(_tween_confirm_name_y);
						if (TweenExists(_tween_confirm_name_scale))
							TweenDestroy(_tween_confirm_name_scale);
						_tween_confirm_name_x = TweenFire(id, "", 0, off, 0, 270, "_confirm_name_x>", 200);
						_tween_confirm_name_y = TweenFire(id, "", 0, off, 0, 270, "_confirm_name_y>", 230);
						_tween_confirm_name_scale = TweenFire(id, "", 0, off, 0, 270, "_confirm_name_scale>", 7);
					}
					break;
			}
	    }
	    else if (input_cancel)
	    {
	        if (string_length(_naming_name) > 0) // Letter remove
			{
	            _naming_name = string_delete(_naming_name, string_length(_naming_name), 1);
				_menu_label_naming_name	= scribble(_naming_name).starting_format("font_dt_mono", c_white).transform(2, 2, 0);
				_menu_label_naming_name.build(true);
			}
	    }
	}
	if (_naming_shake_buffer > 0)
		_naming_shake_buffer --;
	else
	{
		_naming_shake_buffer = _naming_shake_buffer_asign;
		var i = 0;
		repeat (26)
		{
			_naming_letter_shake_x[# i, 0] = random_range(-1, 1);
			_naming_letter_shake_x[# i, 1] = random_range(-1, 1);
			_naming_letter_shake_y[# i, 0] = random_range(-1, 1);
			_naming_letter_shake_y[# i, 1] = random_range(-1, 1);
			i++;
		}
	}
}
else if (_menu == 2) // Name Confirmation
{
	if (input_horizontal != 0)
		_choice_confirm = (input_horizontal == 1 && _confirm_valid) ? 1 : 0
	else if (input_confirm)
	{
	    if (_choice_confirm == 0) // No
	        _menu = (!_mode ? 1 : 0);
	    else // Yes
		{
	        _menu = 3;
			audio_sound_set_track_position(audio_play_sound(snd_cymbal, 0, false), 1.4);
			obj_global.fader_color = c_white;
			Fader_Fade(0, 1, 240);
			alarm[0] = 240;
		}
	}
}
else if (_menu == 4) // Settings
{
	// Such emptiness... Maybe you can cook one up?
}

if (_menu == 2 || _menu == 3)
{
    if (_confirm_name_update)
    {
        _confirm_name_offset_x = random_range(-1, 1);
        _confirm_name_offset_y = random_range(-1, 1);
        _confirm_name_angle = random_range(-1, 1);
    }
    _confirm_name_update = !_confirm_name_update;
}
else
{
	_confirm_name_offset_x = 0;
	_confirm_name_offset_y = 0;
	_confirm_name_angle = 0;
	_confirm_name_update = true;
}
