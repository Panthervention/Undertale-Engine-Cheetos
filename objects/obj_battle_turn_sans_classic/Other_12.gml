///@desc Turn Start
event_inherited();
proceed = true;

switch (turn)
{	
	case 0: // Intro attack
		obj_battle_enemy_sans._head_image = 5;
		break;
	case 1: // Bone Gap attack
	case 4: // Platform attack
		obj_battle_enemy_sans._head_image = 0;
		Player_SetKr(0);
	    Player_SetHp(92);
	    Battle_SetSoulPos(320, 385);
		Battle_SetSoulMode(SOUL_MODE.BLUE);
	    Battle_SetBoardSize(65, 65, 180, 180); // A preset by Toby
		if (turn == 4)
		{
			alarm[0] = 25;
			alarm[1] = 25;
			alarm[2] = 25;
		}
		break;
	case 2: // Blaster spam
		Player_SetKr(0);
	    Player_SetHp(92);
	    Battle_SetBoardSize(135, 65, 195, 195); // Also a preset by Toby
		obj_battle_enemy_sans._head_image = 0;
		alarm[0] = 30;
		break;
	case 3: // Bone Stab
	case 5: // Blaster Circle
		Player_SetKr(0);
	    Player_SetHp(92);
	    Battle_SetSoulPos(320, 320, false);
	    audio_play_sound(snd_ding, 50, false);
	    Battle_SetBoardSize(65, 65, 65, 65, 20, "oCirc");
	    alarm[0] = 20;
		break;
}




