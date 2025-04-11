#region Invincibility
if (global.inv > 0)
{
	global.inv--;
	if (Player_GetInv() > 3)
	{
		if image_speed == 0
		{
			image_speed = 1/2;
			image_index = 1;
		}
	}
}
else
{
	if (image_speed != 0)
	{
		image_speed = 0;
		image_index = 0;
	}
}
#endregion

#region Soul Movement (idk why but to maintain full functionality it has to be this way)
var STATE = Battle_GetState();
if (STATE == BATTLE_STATE.TURN_PREPARATION or STATE == BATTLE_STATE.IN_TURN)
{
	var x_offset = sprite_width / 2;
	var y_offset = sprite_height / 2;
	
	#region Board variables
	var check_board = instance_exists(obj_battle_board);
	if check_board // When the board is real XD
	{
		var board = obj_battle_board;
		var board_x = board.x;
		var board_y = board.y;
		var board_angle = board.image_angle;
		var board_margin = [board.up, board.down, board.left, board.right];
		
		var board_top_limit    = (board_y - board_margin[0]) + y_offset;
		var board_bottom_limit = (board_y + board_margin[1]) - y_offset;
		var board_left_limit   = (board_x - board_margin[2]) + x_offset;
		var board_right_limit  = (board_x + board_margin[3]) - x_offset;
	}
	#endregion
	
	if follow_board
	{
		x += board_x - board.xprevious;
		y += board_y - board.yprevious;
	}

	var h_spd = !hor_lock ? CHECK_HORIZONTAL : 0;
	var v_spd = !ver_lock ? CHECK_VERTICAL   : 0;
		
	var move_spd = (Player_GetSpdTotal() / (CHECK_CANCEL + 1))
	
	if mode == SOUL_MODE.RED // Red
	{		
		move_x = h_spd * move_spd;
		move_y = v_spd * move_spd;
		var _angle = image_angle;
		
		if moveable == true
		{
			if input_rot
			{
				x += lengthdir_x(move_x, _angle);
				y += lengthdir_y(move_y, _angle - 90);
			}
			else
			{
				x += move_x;
				y += move_y;
			}
		}
		image_angle = _angle;
	}
	
	if mode == SOUL_MODE.BLUE // Blue
	{		
		var _on_ground = false;
		var _on_ceil = false;
		var _on_platform = false;
		var _fall_spd = fall_spd;
		var _fall_grav = fall_grav;

		var _angle = image_angle;
		
		var platform_check_x = [0, 0];
		var platform_check_y = [0, 0];
		
		if _fall_spd < 4 and _fall_spd > 0.25 _fall_grav = 0.15;
		if _fall_spd <= 0.25 and _fall_spd > -0.5 _fall_grav = 0.05;
		if _fall_spd <= -0.5 and _fall_spd > -2 _fall_grav = 0.125;
		if _fall_spd <= -2 _fall_grav = 0.05;
	
		_fall_spd += (_fall_grav * fall_multi);
	
		var _dist = point_distance(board_x, board_y, x, y);
		var _dir = point_direction(board_x, board_y, x, y);
		var r_x = lengthdir_x(_dist, _dir - board_angle) + board_x;
		var r_y = lengthdir_y(_dist, _dir - board_angle) + board_y;
		
		if _angle == 0
		{
			if check_board
			{
				_on_ground = r_y >= board_bottom_limit - 0.1;
				_on_ceil = r_y <= board_top_limit + 0.1;
			}
			
			platform_check_x = [0, 0];
			platform_check_y = [x_offset + 1, x_offset];
			
			jump_input = input_check("up");
			move_input = h_spd * move_spd;
		}
		if _angle == 180
		{
			if check_board
			{
				_on_ground = r_y <= board_top_limit + 0.1;
				_on_ceil = r_y >= board_bottom_limit - 0.1;
			}
			
			platform_check_x = [0, 0];
			platform_check_y = [y_offset - 1, -y_offset];
			
			jump_input = input_check("down");
			move_input = h_spd * -move_spd;
		}
		if _angle == 90
		{
			if check_board
			{
				_on_ground = r_x >= board_right_limit - 0.1;
				_on_ceil = r_x <= board_left_limit + 0.1;
			}
			
			platform_check_x = [x_offset - 1, -x_offset];
			platform_check_y = [0, 0];
			
			jump_input = input_check("left");
			move_input = v_spd * -move_spd;
		}
		if _angle == 270 or _angle == -90
		{
			if check_board
			{
				_on_ground = r_x <= board_left_limit + 0.1;
				_on_ceil = r_x >= board_right_limit - 0.1;
			}
			
			platform_check_x = [x_offset + 1, x_offset];
			platform_check_y = [0, 0];
			
			jump_input = input_check("right");
			move_input = v_spd * move_spd;
		}
		
		if !check_board 
		{ 
			_on_ground = false; 
			_on_ceil = false;
		}
		
		platform_check = instance_position(x + platform_check_x[0], y + platform_check_y[0], obj_battle_platform);
		
		if position_meeting(x + platform_check_x[0], y + platform_check_y[0], obj_battle_platform) and _fall_spd >= 0
		{
			_on_platform = true;
			while position_meeting(x + platform_check_x[1], y + platform_check_y[1], obj_battle_platform)
			{
				var soul_x = x,
					soul_y = y;
				with (platform_check)
				{
					soul_x += lengthdir_x(0.1, image_angle + 90);
					soul_y += lengthdir_y(0.1, image_angle + 90);
				}
				x = soul_x;
				y = soul_y;
			}
		}
		
		if (instance_exists(platform_check) && !h_spd && !v_spd)
		{
			var soul_x = x,
				soul_y = y;
			with (platform_check)
			{
				if (sticky)
				{
					soul_x += xdelta;
					soul_y += ydelta;
				}
			}
			x = soul_x;
			y = soul_y;
		}
		
		if _on_ground or _on_platform or (_fall_spd < 0 and _on_ceil)
		{
			if slam
			{
				slam = false;
				Camera_Shake(global.slam_power / 2, global.slam_power / 2, 1, 1, 1, 1, true, true);
				if global.slam_damage
				{
					if Player_GetHp() > 1 Player_Hurt(1);
					else Player_SetHp(1);
				}
			
				audio_stop_sound(snd_impact);
				audio_play_sound(snd_impact, 50, false);
			}
		
			_fall_spd = 0;
			if (_on_ground or _on_platform) and ((mode == 2 and jump_input) or (mode == 3 and !input_check("confirm"))) 
				_fall_spd = -3;
		}
		else if !jump_input and _fall_spd < -0.5 
			_fall_spd = -0.5;
	
		move_x = lengthdir_x(move_input, _angle) - lengthdir_y(_fall_spd, _angle);
		move_y = lengthdir_x(move_input, _angle + 90) - lengthdir_y(_fall_spd, _angle + 90);
	
		on_ground = _on_ground;
		on_ceil = _on_ceil;
		on_platform = _on_platform;
		fall_spd = _fall_spd;
		fall_grav = _fall_grav;
		image_angle = _angle;
			
		if (moveable)
		{
			x += move_x;
			y += move_y;
		}
	}
	
	if check_board
	{
		var _dist = point_distance(board_x, board_y, x, y);
		var _dir = point_direction(board_x, board_y, x, y);
		var r_x = clamp(lengthdir_x(_dist, _dir - board_angle) + board_x, board_left_limit, board_right_limit);
		var r_y = clamp(lengthdir_y(_dist, _dir - board_angle) + board_y, board_top_limit, board_bottom_limit);
		
		var _dist = point_distance(board_x, board_y, r_x, r_y);
		var _dir = point_direction(board_x, board_y, r_x, r_y);
		
		x = lengthdir_x(_dist, _dir + board_angle) + board_x;
		y = lengthdir_y(_dist, _dir + board_angle) + board_y;
	}
}
#endregion
