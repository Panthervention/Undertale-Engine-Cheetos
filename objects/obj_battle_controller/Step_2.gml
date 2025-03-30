///@desc KR Drain
if (global.kr_enable)
{
	var _hp = Player_GetHp();
	var _kr = Player_GetKr(),
		_kr_limit = 40,
		_kr_clamp = clamp(_kr, 0, _kr_limit),
		_kr_drain = (kr_timer >= 2  && _kr >= 40) ||
					(kr_timer >= 4  && _kr >= 30) || 
					(kr_timer >= 10 && _kr >= 20) ||
					(kr_timer >= 30 && _kr >= 10) ||
					(kr_timer >= 60);
					
	Player_SetKr(_kr_clamp);
	if (_kr >= (_hp - 1))
		Player_SetKr(_hp - 1);

	if (_kr > 0 && _hp > 1)
	{
		kr_timer++;
		
		if (_kr_drain)
		{
			kr_timer = 0;
			Player_SetKr(_kr - 1);
			Player_SetHp(_hp - 1);
		}
		if (_hp <= 0)
			Player_SetHp(1);
	}
	else kr_timer = 0;
}
else
{
	kr_timer = 0;
	Player_SetKr(0);
}

