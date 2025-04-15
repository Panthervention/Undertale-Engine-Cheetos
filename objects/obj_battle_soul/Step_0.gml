#region Invincibility
if (global.inv > 0)
{
	global.inv--;
	if (Player_GetInv() > 3)
	{
		if (image_speed == 0)
		{
			image_speed = 1/2;
			image_index = 1;
		}
	}
}
else if (image_speed != 0)
{
	image_speed = 0;
	image_index = 0;
}
#endregion

#region Soul Movement (idk why but to maintain full functionality it has to be this way)
var _battle_state = Battle_GetState();
if (_battle_state == BATTLE_STATE.TURN_PREPARATION || _battle_state == BATTLE_STATE.IN_TURN)
{
	image_angle %= 360;
	var _angle = (image_angle + 90) % 360;
	
	var _hspeed = (!hor_lock) ? CHECK_HORIZONTAL : 0,
		_vspeed = (!ver_lock) ? CHECK_VERTICAL   : 0,
		_mspeed = (Player_GetSpdTotal() / (CHECK_CANCEL + 1));
	
	var _x_offset = sprite_width / 2,
		_y_offset = sprite_height / 2;
	
	#region Board variables
	var _board_exists = instance_exists(obj_battle_board);
	if (_board_exists)
	{
		var _board = obj_battle_board,
			_board_x = _board.x,
			_board_y = _board.y,
			_board_angle = posmod(_board.image_angle, 360),
			_board_dir = _board_angle div 90,
			_board_thickness = _board.frame_thickness;
		
		var _board_top_limit    = (_board_y - _board.up) + _y_offset,
			_board_bottom_limit = (_board_y + _board.down) - _y_offset,
			_board_left_limit   = (_board_x - _board.left) + _x_offset,
			_board_right_limit  = (_board_x + _board.right) - _x_offset;
	}
	#endregion
	
	if (follow_board)
	{
		x += _board_x - _board.xprevious;
		y += _board_y - _board.yprevious;
	}
	
	switch (mode)
	{
		case SOUL_MODE.RED:			
			if (!hor_lock)
				x += (_hspeed * _mspeed) * dcos(_angle);
			if (!ver_lock)
				y += (_vspeed * _mspeed) * dcos(_angle);
			break;
			
		case SOUL_MODE.BLUE:			
			var _jump_input = 0,
				_move_input = 0;
			
			var _on_ground = false,
				_on_ceil = false,
				_on_platform = false;
		
			var _fall_spd = fall_spd,
				_fall_grav = fall_grav;
		
			#region Soul gravity
			if (_fall_spd < 4 && _fall_spd > 0.25)
				_fall_grav = 0.15;
			else if (_fall_spd <= 0.25 && _fall_spd > -0.5)
				_fall_grav = 0.05;
			else if (_fall_spd <= -0.5 && _fall_spd > -2)
				_fall_grav = 0.125;
			else if (_fall_spd <= -2)
				_fall_grav = 0.05;
	
			_fall_spd += (_fall_grav * fall_multi);
			#endregion
			
			#region Position calculation
			var _dist = point_distance(_board_x, _board_y, x, y),
				_dir = point_direction(_board_x, _board_y, x, y) - _board_dir,
				_r_x = lengthdir_x(_dist, _dir) + _board_x,
				_r_y = lengthdir_y(_dist, _dir) + _board_y,
				_displace_x = lengthdir_x(_x_offset + (_board_thickness / 2), _angle - 90) + (2 * dcos((_board_angle % 90) - 90)),
				_displace_y = lengthdir_y(_y_offset + (_board_thickness / 2), _angle - 90) + (2 * dsin(_board_angle % 90));
			
			var _sin = dsin(_board_angle),
				_cos = dcos(_board_angle);
			
			var _top_left_x = -_board.left,
				_top_left_y = -_board.up,
				_top_left_x_rotated = _top_left_x * _cos - _top_left_y * _sin,
				_top_left_y_rotated = _top_left_x * _sin + _top_left_y * _cos;
			
			var _top_right_x = _board.right,
				_top_right_y = -_board.up,
				_top_right_x_rotated = _top_right_x * _cos - _top_right_y * _sin,
				_top_right_y_rotated = _top_right_x * _sin + _top_right_y * _cos;
			
			var _bottom_left_x = -_board.left,
				_bottom_left_y = _board.down,
				_bottom_left_x_rotated = _bottom_left_x * _cos - _bottom_left_y * _sin,
				_bottom_left_y_rotated = _bottom_left_x * _sin + _bottom_left_y * _cos;
			
			var _bottom_right_x = _board.right,
				_bottom_right_y = _board.down,
				_bottom_right_x_rotated = _bottom_right_x * _cos - _bottom_right_y * _sin,
				_bottom_right_y_rotated = _bottom_right_x * _sin + _bottom_right_y * _cos;
			
			var _board_vertices = [
				_board_x + _top_left_x_rotated, _board_y + _top_left_y_rotated,
				_board_x + _top_right_x_rotated, _board_y + _top_right_y_rotated,
				_board_x + _bottom_right_x_rotated, _board_y + _bottom_right_y_rotated,
				_board_x + _bottom_left_x_rotated, _board_y + _bottom_left_y_rotated
			];
			
			var _ground_top    = !point_in_parallelogram(_r_x, _r_y + _displace_y, _board_vertices),
				_ground_bottom = !point_in_parallelogram(_r_x, _r_y + _displace_y, _board_vertices),
				_ground_left   = !point_in_parallelogram(_r_x + _displace_x, _r_y, _board_vertices),
				_ground_right  = !point_in_parallelogram(_r_x + _displace_x, _r_y, _board_vertices);
				
			var _ceil_top    = !point_in_parallelogram(_r_x, _r_y - _displace_y, _board_vertices),
				_ceil_bottom = !point_in_parallelogram(_r_x, _r_y - _displace_y, _board_vertices),
				_ceil_left   = !point_in_parallelogram(_r_x - _displace_x, _r_y, _board_vertices),
				_ceil_right  = !point_in_parallelogram(_r_x - _displace_x, _r_y, _board_vertices);
			#endregion
			
			#region Collision processing
			var _platform_check_position = array_create(4, 0);
			#region Input and collision check of different directions of soul
			// Up
			if (_angle == 180)
			{
				if (_board_exists)
				{
					_on_ground = _ground_top;
					_on_ceil = _ceil_top;
				}
				
				_platform_check_position[2] = -10;
				_platform_check_position[3] = -_y_offset;
				
				_jump_input = CHECK_DOWN;
				_move_input = _hspeed * -_mspeed;
			}
			// Down
			else if (_angle == 0)
			{
				if (_board_exists)
				{
					_on_ground = _ground_bottom;
					_on_ceil = _ceil_bottom;
				}
				
				_platform_check_position[2] = _y_offset + 1;
				_platform_check_position[3] = _y_offset;
				
				_jump_input = CHECK_UP;
				_move_input = _hspeed * _mspeed;
			}
			// Left
			else if (_angle == 270)
			{
				if (_board_exists)
				{
					_on_ground = _ground_left;
					_on_ceil = _ceil_left;
				}
				
				_platform_check_position[0] = -10;
				_platform_check_position[1] = _x_offset;
				
				_jump_input = CHECK_RIGHT;
				_move_input = _vspeed * _mspeed;
			}
			// Right
			else if (_angle == 90)
			{
				if (_board_exists)
				{
					_on_ground = _ground_right;
					_on_ceil = _ceil_right;
				}
				
				_platform_check_position[1] = _x_offset + 1;
				_platform_check_position[0] = -_x_offset;
				
				_jump_input = CHECK_LEFT;
				_move_input = _vspeed * -_mspeed;
			}
			#endregion
			
			// If the board doesn't exist, it will never be on the ground nor touching the ceiling
			if (!_board_exists)
			{
				_on_ground = false;
				_on_ceil = false;
			}
			
			// Platform checking
			var _relative_x = x + _platform_check_position[0],
				_relative_y = y + _platform_check_position[2];
			
			platform_check = instance_position(_relative_x, _relative_y, obj_battle_platform);
			// If the soul is on a platform, stop the falling
			if (position_meeting(_relative_x, _relative_y, obj_battle_platform) && _fall_spd >= 0)
			{
				_on_platform = true;
				while position_meeting(x + _platform_check_position[1], y + _platform_check_position[3], obj_battle_platform)
				{
					x -= lengthdir_y(0.1, _angle);
					y -= lengthdir_x(0.1, _angle);
				}
			}
			
			if (instance_exists(platform_check))
			{
				var _soul_x = x, _soul_y = y;
				// If the platform is sticky, carry the soul
				with (platform_check)
				{
					if (sticky)
					{
						_soul_x += xdelta;
						_soul_y += ydelta;
					}
				}
				x = _soul_x; y = _soul_y;
			}
			#endregion
			
			#region Soul slamming (or some might call this soul throwing)
			if (_on_ground || _on_platform || (_fall_spd < 0 && _on_ceil))
			{
				if (slam)
				{
					slam = false;
					Camera_Shake(global.slam_power / 2, global.slam_power / 2, 1, 1, 1, 1, true, true);
				
					if (global.slam_damage)
					{
						if (Player_GetHp() > 1)
							Player_Hurt(1);
						else
							Player_SetHp(1);
					}
			
					audio_stop_sound(snd_impact);
					audio_play_sound(snd_impact, 50, false);
				}
				_fall_spd = ((_on_ground || _on_platform) && _jump_input) ? -3 : 0;
			}
			else if (!_jump_input && _fall_spd < -0.5)
				_fall_spd = -0.5;
			#endregion
			
			// Rotate the movement by the soul's angle
			var _move_x = lengthdir_x(_move_input, _angle) - lengthdir_y(_fall_spd, _angle),
				_move_y = lengthdir_y(_move_input, _angle) + lengthdir_x(_fall_spd, _angle);

			on_ground = _on_ground;
			on_ceil = _on_ceil;
			on_platform = _on_platform;
	
			fall_spd = _fall_spd;
			fall_grav = _fall_grav;
	
			// Finalize movement
			if (moveable)
			{
				x += _move_x;
				y += _move_y;
			} 
			break;
	}
	#region Soul clamping (aka the soul stay inside the board)
	// Collision check for the main bullet board
	if (_board_exists)
	{
		var _dist = point_distance(_board_x, _board_y, x, y),
			_dir = point_direction(_board_x, _board_y, x, y) - _board_angle,
			_r_x = clamp(lengthdir_x(_dist, _dir) + _board_x, _board_left_limit, _board_right_limit),
			_r_y = clamp(lengthdir_y(_dist, _dir) + _board_y, _board_top_limit, _board_bottom_limit);

		_dist = point_distance(_board_x, _board_y, _r_x, _r_y);
		_dir = point_direction(_board_x, _board_y, _r_x, _r_y) + _board_angle;
		// Clamp the soul inside the rectangle board
		x = lengthdir_x(_dist, _dir) + _board_x;
		y = lengthdir_y(_dist, _dir) + _board_y;
	}
	#endregion
	
	image_angle = (_angle - 90) % 360;
}
#endregion
