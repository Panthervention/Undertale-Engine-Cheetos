switch (turn)
{
	case 2: // The uncanny GB spam
		#region
		// I tried to make this one least uncanny as possible
		// but as you can see, Toby's power is just beyond comprehension
		var _theta = random_range(-90, 270),
			_soul_pos = [obj_battle_soul.x + 8, obj_battle_soul.y + 8],
			_vec_start = [_soul_pos[0] + lengthdir_x(400, _theta), _soul_pos[1] + lengthdir_y(300, _theta)],
			_vec_target = [_soul_pos[0] + lengthdir_x(200, _theta), _soul_pos[1] + lengthdir_y(200, _theta)];
		
		if (_vec_target[0] > 440)		_vec_target[0] = 440;
		else if (_vec_target[0] < 40)	_vec_target[0] = 40;
		if (_vec_target[1] > 590)		_vec_target[1] = 590;
		else if (_vec_target[1] < 50)	_vec_target[1] = 50;
		
		var _rot = 1;
		if (_theta > 90) _rot = -1;
		
		var _angle_target = point_direction(_vec_target[0], _vec_target[1], _soul_pos[0], _soul_pos[1]);
		Bullet_Blaster(spr_gb, _vec_start[0], _vec_start[1], (_angle_target + (270 * _rot)), 2, 1,
								_vec_target[0], _vec_target[1], _angle_target, 16, 10, 30);
		alarm[0] = 10;
		#endregion
		break;
	case 3: // Bone Stab attack
		#region
		if (slam < slam_max)
		{
			slam_side = irandom(3);
			var _dir = [DIR.UP, DIR.DOWN, DIR.LEFT, DIR.RIGHT];
			Battle_SoulSlam(_dir[slam_side]);
			alarm[1] = 10;
		}
		else
			Battle_EndTurn();
		#endregion
		break;
	case 4: // Bottom Line platform
		#region
		Bullet_Platform(590, 342, 120, -2, 0);
		alarm[0] = 110;
		#endregion
		break;
	case 5: // The famous blaster circle
		// Accurate Toby's final blaster circle
		#region
		Bullet_BlasterCircle(spr_gb, obj_battle_board.x,  obj_battle_board.y, 600, 150, cho, dir, 2, 1, 30, 0, 30);
		dir += ((len * 10) * cho);
		if len < 1.7 len += 0.015;
		alarm[0] = 4;
		#endregion
		break;
}

