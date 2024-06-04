///@desc KR Drain
if global.kr_enable
{
	var kr_limit = 40,
		kr_clamp = clamp(Player_GetKr(), 0, kr_limit),
		kr_drain =  kr_timer >= 2  and Player_GetKr() >= 40 or
					kr_timer >= 4  and Player_GetKr() >= 30 or 
					kr_timer >= 10 and Player_GetKr() >= 20 or
					kr_timer >= 30 and Player_GetKr() >= 10 or
					kr_timer >= 60;
					
	Player_SetKr(kr_clamp);
	if (Player_GetKr() >= (Player_GetHp() - 1))
		Player_SetKr(Player_GetHp() - 1);

	if Player_GetKr() > 0 and Player_GetHp() > 1
	{
		kr_timer++;
		
		if kr_drain
		{
			kr_timer = 0;
			Player_SetKr(Player_GetKr() - 1);
			Player_SetHp(Player_GetHp() - 1);
		}
		if Player_GetHp() <= 0
			Player_SetHp(1);
	}
	else kr_timer = 0;
}
else
{
	kr_timer = 0;
	Player_SetKr(0);
}

