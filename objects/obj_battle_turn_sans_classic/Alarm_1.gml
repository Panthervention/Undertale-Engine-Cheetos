switch (turn)
{
	case 3: // Bone Stab attack
		#region
		if (slam < slam_max)
		{
			var _dir = [DIR.UP, DIR.DOWN, DIR.LEFT, DIR.RIGHT];
			Bullet_BoneWall(_dir[slam_side], 25, 24, 8);
			slam++;
			alarm[0] = 36;
		}
		#endregion
		break;
	case 4: // Top Line platform
		#region
		Bullet_Platform(-20, 297, 160, 2, 0);
		alarm[1] = 140;
		#endregion
		break;
}
