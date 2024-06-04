switch (turn)
{
	case 2: // The uncanny GB spam
		#region
		// I tried to make this one least uncanny as possible
		// but as you can see, Toby's power is just beyond comprehension
		var theta = random_range(-90, 270);
		var soul = [obj_battle_soul.x + 8, obj_battle_soul.y + 8];
		var vec_start = [soul[0] + lengthdir_x(400, theta), soul[1] + lengthdir_y(300, theta)];
		var vec_target = [soul[0] + lengthdir_x(200, theta), soul[1] + lengthdir_y(200, theta)];
		
		if (vec_target[0] > 440)		vec_target[0] = 440;
		else if (vec_target[0] < 40)	vec_target[0] = 40;
		if (vec_target[1] > 590)		vec_target[1] = 590;
		else if (vec_target[1] < 50)	vec_target[1] = 50;
		
		var rot = 1;
		if (theta > 90) rot = -1;
		
		var angle_target = point_direction(vec_target[0], vec_target[1], soul[0], soul[1]);
		Bullet_Blaster(spr_gb, vec_start[0], vec_start[1], (angle_target + (270 * rot)), 2, 1,
								vec_target[0], vec_target[1], angle_target, 16, 10, 30);
		alarm[0] = 10;
		#endregion
		break;
	case 3: // Bone Stab attack
		#region
		if (slam < slam_max)
		{
			slam_side = irandom(3);
			var wall_dir = [SOUL_DIR.UP, SOUL_DIR.DOWN, SOUL_DIR.LEFT, SOUL_DIR.RIGHT];
			Battle_SoulSlam(wall_dir[slam_side]);
			alarm[1] = 10;
		}
		else
			Battle_EndTurn();
		#endregion
		break;
	case 4: // Bottom Line platform
		#region
		Bullet_Platform(590, 342, -2, 0, 120);
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

