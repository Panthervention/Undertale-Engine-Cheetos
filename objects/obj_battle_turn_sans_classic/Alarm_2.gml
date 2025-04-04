switch (turn)
{
	case 4: // Bone Gacha
		#region
		var _zone = 0
		if (obj_battle_soul.y >= 290) _zone = 1;
		else if (obj_battle_soul.y >= 330) _zone = 2;
		
		#region The Gacha part
		var _reroll = false;
		gg2 = gg;
		gg = g;
		g = irandom(2);
		if (gg == g && gg2 == gg)
		    _reroll = true;
		else if ((g == 0 && _zone == 0) || (g == 1 && _zone == 2))
		    _reroll = true;
		if (_reroll)
		    g = irandom(2);
		#endregion
		
		switch (g)
		{
			case 0: // Bottom - R>>L
				Bullet_Bone(520, 366, 38, -2, 0);
				break;
			case 1: // Top - R>>L
				Bullet_Bone(520, 274, 38, -2, 0);
				break;
			case 2: // Middle - L>>R
				Bullet_Bone(120, 320, 36, 2, 0);
				break;
		}
		alarm[2] = 30;
		#endregion
		break;
}