var _moveable = (moveable && __moveable_dialog && __moveable_menu && __moveable_save && __moveable_box && __moveable_warp && __moveable_encounter);
if (_moveable)
{
    if (CHECK_UP)
        move[DIR.UP] = 1.5;
    if (CHECK_DOWN)
        move[DIR.DOWN] = 1.5;
    if (CHECK_LEFT)
        move[DIR.LEFT] = 1.5;
    if (CHECK_RIGHT)
        move[DIR.RIGHT] = 1.5;
		
	#region Sprinting
	if (CHECK_CANCEL)
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
	else
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
        var _collision = noone;
		switch (dir)
		{
			case DIR.UP:
	            _collision = collision_rectangle(x - sprite_width / 2 + 4, y - 5, x + sprite_width / 2 - 4, y - sprite_height + 5, obj_char, false, true);
				break;
			case DIR.DOWN:
				_collision = collision_rectangle(x - sprite_width / 2 + 4, y - sprite_height + 20, x + sprite_width / 2 - 4, y + 15, obj_char, false, true);
				break;
	        case DIR.LEFT:
	            _collision = collision_rectangle(x, y - sprite_height + 19, x + sprite_width / 2 - 15, y, obj_char, false, true);
				break;
	        case DIR.RIGHT:
	            _collision = collision_rectangle(x, y - sprite_height + 19, x + sprite_width / 2 + 15, y, obj_char, false, true);
				break;
		}
        if (instance_exists(_collision))
        {
            with (_collision)
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
