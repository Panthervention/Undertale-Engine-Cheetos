var _battle_state = Battle_GetState(), _menu_state = Battle_GetMenu();
visible = (_battle_state == BATTLE_STATE.IN_TURN || _battle_state == BATTLE_STATE.TURN_PREPARATION || (_battle_state == BATTLE_STATE.MENU && _menu_state != BATTLE_MENU.FIGHT_AIM && _menu_state != BATTLE_MENU.FIGHT_ANIM && _menu_state != BATTLE_MENU.FIGHT_DAMAGE));

#region Invincibility and Soul Flickering
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

#region Soul Movement
if (_battle_state == BATTLE_STATE.MENU && _menu_state == BATTLE_MENU.BUTTON)
{
	var _button_pos = obj_battle_controller.ui_button.position,
		_button_scale = obj_battle_controller.ui_button.scale,
		_button = Battle_GetMenuChoiceButton();
	x = lerp(x, _button_pos[_button * 2] - (38 * _button_scale[_button]), 1/3);
	y = lerp(y, _button_pos[_button * 2 + 1] + 1, 1/3);
}

if (_battle_state == BATTLE_STATE.TURN_PREPARATION || _battle_state == BATTLE_STATE.IN_TURN)
{
	image_angle = posmod(image_angle, 360);
	var _soul = id,
		_angle = image_angle,
		_angle_compensation = (_angle + 90) % 360;
	
	var _hspeed = CHECK_HORIZONTAL,
		_vspeed = CHECK_VERTICAL,
		_mspeed = (Player_GetSpdTotal() / (CHECK_CANCEL + 1));
	
	var _x_offset = sprite_width / 2,
		_y_offset = sprite_height / 2;
	
	#region Board variables & follow
	var _board_exists = instance_exists(obj_battle_board);
	if (_board_exists)
	{
		var _board = obj_battle_board,
			_board_x = _board.x,
			_board_y = _board.y,
			_board_angle = posmod(_board.image_angle, 360);
		
		var _board_top_limit    = (_board_y - _board.up) + _y_offset,
			_board_bottom_limit = (_board_y + _board.down) - _y_offset,
			_board_left_limit   = (_board_x - _board.left) + _x_offset,
			_board_right_limit  = (_board_x + _board.right) - _x_offset;

		if (follow_board)
		{
			x += _board_x - _board.xprevious;
			y += _board_y - _board.yprevious;
		}
	}
	#endregion
	
	switch (mode)
	{
		case SOUL.RED:  #region
			if (moveable)
			{
				var _dir_compensation = (input_rotateable ? dcos(_angle_compensation) : 1);
				if (!hor_lock)
					x += (_hspeed * _mspeed) * _dir_compensation;
				if (!ver_lock)
					y += (_vspeed * _mspeed) * _dir_compensation;
			}
			break;
		#endregion
			
		case SOUL.BLUE:	#region
			var _jump_input = 0,
				_move_input = 0;
			
			var _on_ground = false,
				_on_ceil = false,
				_on_platform = false;
		
			var _fall_spd = fall_spd,
				_fall_grav = fall_grav,
				_fall_multi = fall_multi;
			
			#region Position calculation
			var _board_angle_90 = _board_angle mod 90,
				_angle_90 = _angle mod 90,
				_small_offset = 0.001 + abs(min(_board_angle_90, 90 - _board_angle_90) - min(_angle_90, 90 - _angle_90)) / 15,
				_displace_x = lengthdir_x(_x_offset+_small_offset, _angle),
				_displace_y = lengthdir_y(_y_offset+_small_offset, _angle);
			
			// Store board vertices into vectors for checking (Rotated board is a parallelogram)
			var _board_top_left		= new Vector2(-_board.left, -_board.up).Rotated(-_board_angle),
				_board_top_right	= new Vector2(_board.right, -_board.up).Rotated(-_board_angle),
				_board_bottom_left	= new Vector2(-_board.left, _board.down).Rotated(-_board_angle),
				_board_bottom_right = new Vector2(_board.right, _board.down).Rotated(-_board_angle);
			
			var _board_vertices =
			[
				_board_x + _board_top_left.x	, _board_y + _board_top_left.y,
				_board_x + _board_top_right.x	, _board_y + _board_top_right.y,
				_board_x + _board_bottom_right.x, _board_y + _board_bottom_right.y,
				_board_x + _board_bottom_left.x	, _board_y + _board_bottom_left.y
			];
			
			_on_ground = !point_in_parallelogram(x + _displace_x, y + _displace_y, _board_vertices);
			_on_ceil = !point_in_parallelogram(x - _displace_x, y - _displace_y, _board_vertices);
			#endregion
			
			#region Soul gravity
			if (_fall_spd < 4 && _fall_spd > 0.25)
				_fall_grav = 0.15;
			else if (_fall_spd <= 0.25 && _fall_spd > -0.5)
				_fall_grav = 0.05;
			else if (_fall_spd <= -0.5 && _fall_spd > -2)
				_fall_grav = 0.125;
			else if (_fall_spd <= -2)
				_fall_grav = 0.05;
			
			// Apply gravity to speed
			_fall_spd += (_fall_grav * _fall_multi);
			#endregion
			
			#region Collision processing
			
			#region Input and collision check of different directions of soul
			if (_angle >= 45 && _angle <= 135) // Up
			{
				_jump_input = CHECK_DOWN;
				_move_input = _hspeed * -_mspeed;
			}
			else if (_angle >= 225 && _angle <= 315) // Down
			{
				_jump_input = CHECK_UP;
				_move_input = _hspeed * _mspeed;
			}
			else if (_angle > 135 && _angle < 225) // Left
			{
				_jump_input = CHECK_RIGHT;
				_move_input = _vspeed * _mspeed;
			}
			else if (_angle < 45 || _angle > 315) // Right
			{
				_jump_input = CHECK_LEFT;
				_move_input = _vspeed * -_mspeed;
			}
			#endregion
			
			#region Platform check
			var _respective_platform = noone;		
			with (obj_battle_platform)
			{
				var // Get delta
					_dx = xdelta, _dy = ydelta,
					// Get normal angle
					_angle_normal = image_angle + 90,
					// Get delta angle from normal
					_angle_delta = _angle_normal - darctan2(_dy, _dx),
					// Get delta along normal
					_normal_delta_x = _dx * dcos(_angle_delta),
					_normal_delta_y = _dy * -dsin(_angle_delta),
					_normal_delta = sqrt((_normal_delta_x * _normal_delta_x) + (_normal_delta_y * _normal_delta_y));				
				
				// Not colliding if either the soul is not relatively falling
				// or the angle difference is too high
				if ((_fall_spd < 0 && -_fall_spd > _normal_delta) || abs(angle_difference(_angle_compensation, image_angle)) > 75)
					continue;
				
				var 
					// Tip of the soul
					_soul_x = _soul.x + (8 * dsin(_angle_compensation)), _soul_y = _soul.y + (8 * dcos(_angle_compensation)),
					// Top left corner of the platform
					_top_left_x = x + lengthdir_x(-length / 2, image_angle) + lengthdir_y(-2, -image_angle),
					_top_left_y = y + lengthdir_x(-2, image_angle) - lengthdir_y(-length / 2, -image_angle),
					// Rotated length vector of the platform
					_platform_delta_x = lengthdir_x(length, image_angle),
					_platform_delta_y = lengthdir_y(length, image_angle),
					// Top right corner of the platform
					_top_right_x = _top_left_x + _platform_delta_x, _top_right_y = _top_left_y + _platform_delta_y,
					// Displacement vector between soul and left side of the platform
					_soul_delta_x = _soul_x - _top_left_x, _soul_delta_y = _soul_y - _top_left_y,
					// Scalar projection of the soul to the platform
					_projection_scalar = ((_soul_delta_x * _platform_delta_x) + (_soul_delta_y * _platform_delta_y)) / (length * length),
					// Projection vector of the soul to the platform
					_projection_x = _platform_delta_x * _projection_scalar, _projection_y = _platform_delta_y * _projection_scalar;
				
				// Not colliding if the soul is outside of horizontal bounds of the platform 
				// (Left side OR Right side)
				if ((((_projection_x * _platform_delta_x) + (_projection_y * _platform_delta_y)) < 0) || (point_distance(0, 0, _projection_x, _projection_y) > point_distance(0, 0, _platform_delta_x, _platform_delta_y)))
					continue;
				
				// If the nearest point of soul to platform is close enough, it is colliding				
				if (point_distance(0, 0, _projection_x + _top_left_x - _soul_x, _projection_y + _top_left_y - _soul_y) < (_normal_delta + 1))
				{
					_on_platform = true;
					_respective_platform = self;
					continue;
				}
			}
			
			// If the platform is sticky, carry the soul
			if (_respective_platform != noone) then with (_respective_platform)
			{	
				if (sticky)
				{
					_soul.x += xdelta;
					_soul.y += ydelta;
				}
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
						Player_SetHp(max(1, Player_GetHp() - 1));
			
					audio_stop_sound(snd_impact);
					audio_play_sound(snd_impact, 50, false);
				}
				_fall_spd = ((_on_ground || _on_platform) && _jump_input) ? -3 : 0;
			}
			else if (!_jump_input && _fall_spd < -0.5)
				_fall_spd = -0.5;
			#endregion
	
			// Finalize movement
			if (moveable)
			{
				// Apply relative vertical movement
				var _fall_x = -lengthdir_y(_fall_spd, _angle_compensation), _fall_y = lengthdir_x(_fall_spd, _angle_compensation),
					_step_count = max(10, _fall_spd / 2);
				repeat (_step_count) // Preventing the soul to clip through the platform if the fall speed is too high
				{
					x += _fall_x / _step_count; y += _fall_y / _step_count;
					
					// Could have been a function, but I prefer to just inline this
					#region Platform check
					with (obj_battle_platform)
					{
						var // Get delta
							_dx = xdelta, _dy = ydelta,
							// Get normal angle
							_angle_normal = image_angle + 90,
							// Get delta angle from normal
							_angle_delta = _angle_normal - darctan2(_dy, _dx),
							// Get delta along normal
							_normal_delta_x = _dx * dcos(_angle_delta),
							_normal_delta_y = _dy * -dsin(_angle_delta),
							_normal_delta = sqrt((_normal_delta_x * _normal_delta_x) + (_normal_delta_y * _normal_delta_y));
					
						// Not colliding if either the soul is not relatively falling
						// or the angle difference is too high
						if ((_fall_spd < 0 && -_fall_spd > _normal_delta) || abs(angle_difference(_angle_compensation, image_angle)) > 75)
							continue;
				
						var 
							// Tip of the soul
							_soul_x = _soul.x + (8 * dsin(_angle_compensation)), _soul_y = _soul.y + (8 * dcos(_angle_compensation)),
							// Top left corner of the platform
							_top_left_x = x + lengthdir_x(-length / 2, image_angle) + lengthdir_y(-2, -image_angle),
							_top_left_y = y + lengthdir_x(-2, image_angle) - lengthdir_y(-length / 2, -image_angle),
							// Rotated length vector of the platform
							_platform_delta_x = lengthdir_x(length, image_angle),
							_platform_delta_y = lengthdir_y(length, image_angle),
							// Top right corner of the platform
							_top_right_x = _top_left_x + _platform_delta_x, _top_right_y = _top_left_y + _platform_delta_y,
							// Displacement vector between soul and left side of the platform
							_soul_delta_x = _soul_x - _top_left_x, _soul_delta_y = _soul_y - _top_left_y,
							// Scalar projection of the soul to the platform
							_projection_scalar = ((_soul_delta_x * _platform_delta_x) + (_soul_delta_y * _platform_delta_y)) / (length * length),
							// Projection vector of the soul to the platform
							_projection_x = _platform_delta_x * _projection_scalar, _projection_y = _platform_delta_y * _projection_scalar;
				
						// Not colliding if the soul is outside of horizontal bounds of the platform 
						// (Left side OR Right side)
						if ((((_projection_x * _platform_delta_x) + (_projection_y * _platform_delta_y)) < 0) || (point_distance(0, 0, _projection_x, _projection_y) > point_distance(0, 0, _platform_delta_x, _platform_delta_y)))
							continue;
				
						// If the nearest point of soul to platform is close enough, it is colliding				
						if (point_distance(0, 0, _projection_x + _top_left_x - _soul_x, _projection_y + _top_left_y - _soul_y) < (_normal_delta + 1))
						{
							_on_platform = true;
							continue;
						}
					}
					#endregion
					// Same inlining
					#region Soul slamming
					if (_on_platform)
					{
						if (slam)
						{
							slam = false;
							Camera_Shake(global.slam_power / 2, global.slam_power / 2, 1, 1, 1, 1, true, true);
				
							if (global.slam_damage)
								Player_SetHp(max(1, Player_GetHp() - 1));
			
							audio_stop_sound(snd_impact);
							audio_play_sound(snd_impact, 50, false);
						}
						break;
					}
					#endregion
				}
				
				// Apply relative horizontal movement
				x += lengthdir_x(_move_input, _angle_compensation);
				y += lengthdir_y(_move_input, _angle_compensation);
			}			
			
			fall_spd = _fall_spd;
			fall_grav = _fall_grav;
			fall_multi = _fall_multi;
			break;
			#endregion
		#endregion
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
	
	image_angle = _angle;
}
#endregion
