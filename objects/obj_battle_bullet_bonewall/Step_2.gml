if (active)
{
	if (time_warn <= 0)
	{
		var _spr = bone_index,
			_spr_width = sprite_get_width(_spr);

		var _board = obj_battle_board,
			_board_x = _board.x,
			_board_y = _board.y,
			_board_u = _board_y - _board.up,
			_board_d = _board_y + _board.down,
			_board_l = _board_x - _board.left,
			_board_r = _board_x + _board.right;
			
		var _soul = obj_battle_soul;
			
		var _wall_angle = 0,
			_wall_head = (_spr_width / 2) - 1;
		
		if (dir == DIR.UP || dir == DIR.DOWN)
		{
			_wall_angle = BONE.VERTICAL;
			
			var _bone_y = 0;
			
			if (dir == DIR.UP)
				_bone_y = [(_board_u - _wall_head) + (height / 2), _board_u, (_board_u - _wall_head + height) - 1];
			else if (dir == DIR.DOWN)
				_bone_y = [(_board_d + _wall_head) - (height / 2), _board_d, (_board_d + _wall_head - height) - 1];
				
			if (!global.inv && collision_rectangle(_board_l + 2, _bone_y[1], _board_r - 3, _bone_y[2], _soul, false, true))
			{
				Battle_CallSoulEventBulletCollision();
			}	
		}		
		else if (dir == DIR.LEFT || dir == DIR.RIGHT)
		{
			_wall_angle = BONE.HORIZONTAL;
			
			var _bone_x = 0;
			if (dir == DIR.LEFT)
				_bone_x = [(_board_l - _wall_head) + (height / 2), _board_l, (_board_l - _wall_head + height) - 1];
			else if (dir == DIR.RIGHT)
				_bone_x = [(_board_r + _wall_head) - (height / 2), _board_r, (_board_r + _wall_head - height) - 1];

			if (!global.inv && collision_rectangle(_bone_x[1], _board_u + 2, _bone_x[2], _board_d - 3, _soul, false, true))
			{
				Battle_CallSoulEventBulletCollision();
			}
		}
		
		if (state == 1)
		{
			state = 2;
			height = -target_height;
		}
	}
	if (state == 2)
	{
		state = 3;
		
		audio_stop_sound(snd_bonewall);
		audio_play_sound(snd_bonewall, 50, false);
		
		if (time_stab > 0)
		{
			TweenFire(id, "", 0, off, 0, time_stab, "height>", target_height);
			TweenFire(id, "", 0, off, time_stab + time_stay, time_stab, "height>", height - target_height);
		}
		else
		{
			height = target_height;
			alarm[2] = time_stay;
		}
	}
	if (state == 3)
	{
		timer++;
		if (timer > ((time_stab * 2) + time_stay))
			instance_destroy();
	}
}
