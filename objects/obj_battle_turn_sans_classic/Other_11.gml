///@desc Turn Preparation End
event_inherited();

switch (turn)
{
	case 0: // Intro attack
		Battle_Flash(on);
		global.kr_enable = true;
	    Player_SetLv(19);
	    Player_SetHp(92);
	    Player_SetHpMax(92);
		Player_SetInv(2);
	    Battle_SetSoulPos(320, 320);
	    Battle_SetBoardSize(75, 75, 75, 75, 0);
		break;
}

