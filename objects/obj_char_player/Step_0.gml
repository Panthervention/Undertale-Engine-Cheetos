var can_move = (moveable && _moveable_dialog && _moveable_menu && _moveable_save && _moveable_box && _moveable_warp && _moveable_encounter);
if (can_move)
{
    if (input_check("up"))
        move[DIR.UP] = 1.5;
    else if (input_check("down"))
        move[DIR.DOWN] = 1.5;
    if (input_check("left"))
        move[DIR.LEFT] = 1.5;
    else if (input_check("right"))
        move[DIR.RIGHT] = 1.5;
		
	#region Sprinting
	if (input_check("cancel"))
	{
	    move_speed[DIR.UP] = 3;
	    move_speed[DIR.DOWN] = 3;
	    move_speed[DIR.LEFT] = 3;
	    move_speed[DIR.RIGHT] = 3;
	    res_move_speed[DIR.UP] = 1 / 2;
	    res_move_speed[DIR.DOWN] = 1 / 2;
	    res_move_speed[DIR.LEFT] = 1 / 2;
	    res_move_speed[DIR.RIGHT] = 1 / 2;
	}
	else if (!input_check("cancel"))
	{
	    move_speed[DIR.UP] = 1.5;
	    move_speed[DIR.DOWN] = 1.5;
	    move_speed[DIR.LEFT] = 1.5;
	    move_speed[DIR.RIGHT] = 1.5;
	    res_move_speed[DIR.UP] = 1 / 3;
	    res_move_speed[DIR.DOWN] = 1 / 3;
	    res_move_speed[DIR.LEFT] = 1 / 3;
	    res_move_speed[DIR.RIGHT] = 1 / 3;
	}
	#endregion
	
    if (PRESS_CONFIRM)
    {
        var inst = noone;
		switch (dir)
		{
			case DIR.UP:
	            inst = collision_rectangle(x - sprite_width / 2 + 4, y - 5, x + sprite_width / 2 - 4, y - sprite_height + 5, obj_char, false, true);
				break;
			case DIR.DOWN:
				inst = collision_rectangle(x - sprite_width / 2 + 4, y - sprite_height + 20, x + sprite_width / 2 - 4, y + 15, obj_char, false, true);
				break;
	        case DIR.LEFT:
	            inst = collision_rectangle(x, y - sprite_height + 19, x + sprite_width / 2 - 15, y, obj_char, false, true);
				break;
	        case DIR.RIGHT:
	            inst = collision_rectangle(x, y - sprite_height + 19, x + sprite_width / 2 + 15, y, obj_char, false, true);
				break;
		}
        if (instance_exists(inst))
        {
            with (inst)
                event_user(0);
        }
    }
    if (!instance_exists(obj_ui_dialog))
    {
        if (PRESS_MENU)
            instance_create_depth(0, 0, 0, obj_ui_menu);
    }
}

event_inherited();
