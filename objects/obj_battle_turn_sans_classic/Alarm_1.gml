switch (turn)
{
	case 3: // Bone Stab attack
		#region
		if (slam < slam_max)
		{
			var dir = [[SOUL_DIR.UP, SOUL_DIR.DOWN, SOUL_DIR.LEFT, SOUL_DIR.RIGHT],
					   [DIR.UP, DIR.DOWN, DIR.LEFT, DIR.RIGHT]];
			Bullet_BoneWall(dir[1][slam_side], 25, 24, 8);
			slam++;
			alarm[0] = 36;
		}
		#endregion
		break;
	case 4: // Top Line platform
		#region
		Bullet_Platform(-20, 297, 2, 0, 160);
		alarm[1] = 140;
		#endregion
		break;
}
