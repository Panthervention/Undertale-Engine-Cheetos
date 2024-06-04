///@desc Soul Collision
if (image_alpha >= 1)
{
	switch type
	{	
		default: //White
			var white = type == 0,
				blue = type == 1 and Battle_IsSoulMoving(),
				orange = type == 2 and !Battle_IsSoulMoving();
			if white or blue or orange
			{
				Battle_CallSoulEventHurt();
				Player_Hurt(dmg, kr);
				if instance_exists(obj_battle_enemy_sans)
				{
					if kr >= 5 kr = 3;
					else if kr >= 3 kr = 2;
					else if kr >= 2 kr = 1;
				}
			}
			break;
			
		case 3: //Red
			if global.debug = false
			{
				Battle_CallSoulEventHurt();
				Player_SetHp(0);
				Player_SetKr(0);
			}
			else if global.debug = true
			{			
				Battle_CallSoulEventHurt();
				Player_Hurt(dmg, kr);	
				if kr >= 5 kr = 3;
				else if kr >= 3 kr = 2;
				else if kr >= 2 kr = 1;
			}
			break;
		case 4:
			if _timer = 0
			{
				_timer = 60;
				Battle_CallSoulEventHurt();
				Battle_SetSoulMode(SOUL_MODE.BLUE);
			}
			break;
	}
}
