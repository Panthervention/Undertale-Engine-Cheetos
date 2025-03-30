var input_horizontal = PRESS_HORIZONTAL,
	input_confirm = PRESS_CONFIRM,
	input_cancel = PRESS_CANCEL;

if (__state == -1) // Initiate Saving UI
{
    if (!instance_exists(obj_ui_dialog))
    {
        __state = 0;
		Flag_Load(FLAG_TYPE.INFO);
    }
}
else if (__state == 0) // Saving
{
    if (input_horizontal != 0) // Option switching
	{
		_choice = posmod(_choice + input_horizontal, 2);
		audio_play_sound(snd_menu_switch, 0, false);
	}
    else if (input_confirm)
    {
        if (_choice == 0) // Saved
        {
            __state = 1;
			
			Player_Save(0); // Save to slot 0
			audio_play_sound(snd_save, 0, false);
			
			// Update timer
			_timer = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.TIME);
			_minute = _timer div 60;
			_second = _timer mod 60;
			
			event_user(0); // Refresh text elements
        }
        else // Return
            instance_destroy();
    }
    else if (input_confirm || input_cancel) // Closing Save UI
        instance_destroy();
}
else if (__state == 1) // Saved
{
    if (input_confirm || input_cancel) // Closing Save UI
        instance_destroy();
}
