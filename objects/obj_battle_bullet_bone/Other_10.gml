///@desc Soul Collision
if (image_alpha >= 1)
{
	switch (type)
	{	
		default: //White
			var _white = type != 1 || type != 2,
				_blue = type == 1 && Battle_IsSoulMoving(),
				_orange = type == 2 && !Battle_IsSoulMoving();
			if (_white || _blue || _orange)
			{
				Battle_CallSoulEventHurt();
				Player_Hurt(dmg, kr);
				kr = 1;
			}
			break;
	}
}
