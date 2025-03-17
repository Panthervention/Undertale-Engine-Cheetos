#region Game Over / Debug functionality
if (round(global.hp) <= 0)
{
	if (!global.debug)
	{
		var camera_x = camera.x,
			camera_y = camera.y;
			
		Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_X, x - camera_x);
		Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_Y, y - camera_y);
		room_goto(room_gameover);
	}
	else
	{
		Player_SetHp(Player_GetHpMax());
		Player_SetKr(0);
		audio_play_sound(snd_item_heal, 0, false);
	}
}
#endregion
