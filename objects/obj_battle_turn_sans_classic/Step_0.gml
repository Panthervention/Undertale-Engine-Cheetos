switch (turn)
{
	default: // No attack code
		Battle_EndTurn();
		break;
	case 0: // Intro attack
		// Full of magic numbers thanks Toby Fox
		#region
		if (timer == 15)
			Battle_Flash(off);
		if (timer == 45)
			Battle_SoulSlam(DIR.DOWN);
		else if (timer == 75)
		{
			Bullet_BoneWall(DIR.DOWN, 55, 12, 60);
			Bullet_BoneWaveH(-160, 310, 6, 24, 20, 45, 28, 1/3);
		}
		else if (timer == 115)
			Battle_SetSoulMode(SOUL.RED);
		else if (timer == 136)
			audio_play_sound(snd_gb_charge, 0, false);
		else if (timer == 210 || timer == 310)
		{
			Bullet_Blaster(spr_gb, 0, 0, DIR.RIGHT - 90, 2, 2, 190, 260, DIR.RIGHT, 20, 16, 30);	// Left
			Bullet_Blaster(spr_gb, 0, 0, DIR.DOWN + 90, 2, 2, 260, 180, DIR.DOWN, 20, 16, 30);		// Top
			Bullet_Blaster(spr_gb, 640, 480, DIR.LEFT + 90, 2, 2, 450, 380, DIR.LEFT, 20, 16, 30);	// Right
			Bullet_Blaster(spr_gb, 640, 480, DIR.UP - 90, 2, 2, 380, 460, DIR.UP, 20, 16, 30);		// Bottom
		}
		else if (timer == 260 || timer == 350)
		{
			Bullet_Blaster(spr_gb, 0, 0, DIR.DOWN, 2, 2, 190, 190, DIR.DOWN + 45, 20, 16, 30);
			Bullet_Blaster(spr_gb, 640, 0, DIR.DOWN, 2, 2, 450, 190, DIR.DOWN - 45, 20, 16, 30);
			Bullet_Blaster(spr_gb, 0, 480, DIR.UP, 2, 2, 190, 450, DIR.UP - 45, 20, 16, 30);
			Bullet_Blaster(spr_gb, 640, 480, DIR.UP, 2, 2, 450, 450, DIR.UP + 45, 20, 16, 30);
		}
		else if (timer == 390)
		{
			Bullet_Blaster(spr_gb, 0, 320, DIR.RIGHT + 90, 3, 3, 140, 320, DIR.RIGHT, 40, 30, 30);
			Bullet_Blaster(spr_gb, 640, 320, DIR.LEFT - 90, 3, 3, 500, 320, DIR.LEFT, 40, 30, 30);
		}
		else if (timer == 570)
		{
			timer = 571;
			proceed = false;
			var _dialog = instance_create_depth(420, (obj_battle_enemy_sans.y - 100), 0, obj_battle_dialog_enemy);
		    _dialog.text = $"[voice, voice_sans][font_sans]{lexicon_text("battle.enemy.sans.turn.0.1")}";
		}
		else if (timer == 571 && !instance_exists(obj_battle_dialog_enemy))
			Battle_EndTurn();
		#endregion
		break;
	case 1: // Bone Gap H
		#region
		if (timer == 20)
		{
			var _i = 0; repeat (8)
			{
				Bullet_BoneGapH(120 - (_i * 120), 355, 3, 20);
				Bullet_BoneGapH(520 + (_i++ * 120), 355, -3, 20);
			}
		}
		else if (timer == 450)
			Battle_EndTurn();
		#endregion
		break;
	case 2: // Blaster Spam
		#region
		if (timer == 500)
			Battle_EndTurn();
		#endregion
		break;
	case 3: // Handled by Alarm 0 and 1 already
		break;
	case 4: // Platform
		#region
		if (timer == 500)
			Battle_EndTurn();
		#endregion
		break;
	case 5: // Blaster Circle
		#region
		if (timer == 600)
			Battle_EndTurn();
		#endregion
		break;
}

