switch (turn)
{
	case 4: // Bone Gacha
		#region
		zone = 0
		if (obj_battle_soul.y >= 290) zone = 1;
		else if (obj_battle_soul.y >= 330) zone = 2;
		
		#region The Gacha part
		reroll = false;
		gg2 = gg;
		gg = g;
		g = irandom(2);
		if (gg == g && gg2 == gg)
		    reroll = true;
		else if ((g == 0 && zone == 0) || (g == 1 && zone == 2))
		    reroll = true;
		if (reroll)
		    g = irandom(2);
		#endregion
		
		switch (g)
		{
			case 0: // Bottom - R2L
				Bullet_Bone(520, 366, 38, -2, 0);
				break;
			case 1: // Top - R2L
				Bullet_Bone(520, 274, 38, -2, 0);
				break;
			case 2: // Middle - L2R
				Bullet_Bone(120, 320, 36, 2, 0);
				break;
		}
		alarm[2] = 30;
		#endregion
		break;
}