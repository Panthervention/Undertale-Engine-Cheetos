if (active)
{
	if (time_warn <= 0)
	{
		var spr = bone_index,
			spr_width = sprite_get_width(spr);

		var board = obj_battle_board,
			board_x = board.x,
			board_y = board.y,
			board_u = board_y - board.up,
			board_d = board_y + board.down,
			board_l = board_x - board.left,
			board_r = board_x + board.right;
			
		var soul = obj_battle_soul;
			
		var wall_angle = 0,
			wall_head = (spr_width / 2) - 1;
		
		if (dir == DIR.UP or dir == DIR.DOWN)
		{
			wall_angle = BONE.VERTICAL;
			
			var bone_y = 0;
			
			if (dir == DIR.UP)
				bone_y = [(board_u - wall_head) + (height / 2), board_u, (board_u - wall_head + height) - 1];
			if (dir == DIR.DOWN)
				bone_y = [(board_d + wall_head) - (height / 2), board_d, (board_d + wall_head - height) - 1];
				
			if !global.inv && collision_rectangle(board_l + 2, bone_y[1], board_r - 3, bone_y[2], soul, false, true)
			{
				var white = type != 1 || type != 2,
					blue = type == 1 && Battle_IsSoulMoving(),
					orange = type == 2 && !Battle_IsSoulMoving();
				if (white || blue || orange)
					Battle_CallSoulEventBulletCollision();
			}	
		}
		
		if (dir == DIR.LEFT or dir == DIR.RIGHT)
		{
			wall_angle = BONE.HORIZONTAL;
			
			var bone_x = 0;
			if (dir == DIR.LEFT)
				bone_x = [(board_l - wall_head) + (height / 2), board_l, (board_l - wall_head + height) - 1];
			if (dir == DIR.RIGHT)
				bone_x = [(board_r + wall_head) - (height / 2), board_r, (board_r + wall_head - height) - 1];

			if !global.inv && collision_rectangle(bone_x[1], board_u + 2, bone_x[2], board_d - 3, soul, false, true)
			{
				var white = type != 1 || type != 2,
					blue = type == 1 && Battle_IsSoulMoving(),
					orange = type == 2 && !Battle_IsSoulMoving();
				if (white || blue || orange)
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
