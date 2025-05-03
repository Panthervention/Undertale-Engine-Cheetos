var _moveable = (moveable && __moveable_dialog && __moveable_menu && __moveable_save && __moveable_box && __moveable_warp && __moveable_encounter);
if (_moveable)
{
	var _input = [CHECK_UP, CHECK_DOWN, CHECK_LEFT, CHECK_RIGHT, CHECK_CANCEL, PRESS_CONFIRM, PRESS_MENU],
		_base_speed = 1.5 * (_input[4] + 1);
	var _i = 0; repeat(4)
	{
		var _dir = __dir_list[_i];
		if (_input[_i])
			move[$ _dir] = _base_speed;
		move_speed[$ _dir] = _base_speed;
		resource.move[$ _dir].image_speed = CHECK_CANCEL ? 1/2 : 1/3;		
		_i++;
	}
	
    if (_input[5])
    {
		var _offset = __collision_offset[$ dir],
			_sw = sprite_width, _sh = sprite_height;
		
		var x1 = x + _offset[0] * _sw + _offset[1], y1 = y + _offset[2] * _sh + _offset[3], 
			x2 = x + _offset[4] * _sw + _offset[5], y2 = y + _offset[6] * _sh + _offset[7];
		
		var _collision = collision_rectangle(x1, y1, x2, y2, obj_char, false, true);
        if (instance_exists(_collision))
        {
            with (_collision)
                event_user(0);
        }
    }
    if (!instance_exists(obj_ui_dialog))
    {
        if (_input[6])
            instance_create_depth(0, 0, 0, obj_ui_menu);
    }
}

event_inherited();
