///@desc Soul Collision
if (image_alpha >= 1)
{
	switch (type)
	{	
		default: //White
			var _white = type == 0,
				_blue = type == 1 && Battle_IsSoulMoving(),
				_orange = type == 2 && !Battle_IsSoulMoving();
			if (_white || _blue || _orange)
			{
				Battle_CallSoulEventHurt();
				Player_Hurt(dmg, kr);
				if (instance_exists(obj_battle_enemy_sans))
				{
					if (kr >= 5) kr = 3;
					else if (kr >= 3) kr = 2;
					else if (kr >= 2) kr = 1;
				}
			}
			break;
	}
}
