#region Game Over / Debug functionality
if (round(global.hp) <= 0)
{
	if (!global.debug)
	{
		var _camera_x = camera.x,
			_camera_y = camera.y;
			
		Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_X, x - _camera_x);
		Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_Y, y - _camera_y);
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
