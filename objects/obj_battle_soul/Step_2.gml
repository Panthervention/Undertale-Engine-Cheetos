#region Sticky platform
var STATE = Battle_GetState();
if (STATE == BATTLE_STATE.TURN_PREPARATION or STATE == BATTLE_STATE.IN_TURN)
{	
	if (mode == SOUL_MODE.BLUE)
	{
		if (instance_exists(platform_check))
		{
			var soul_x = x,
				soul_y = y;
			with (platform_check)
			{
				if (sticky)
				{
					soul_x += x - xprevious;
					soul_y += y - yprevious;
				}
			}
			x = soul_x;
			y = soul_y;
		}
	}
}
#endregion

#region Game Over / Debug functionality
if (round(global.hp) <= 0)
{
	if (!global.debug)
	{
		var camera_x = obj_global.cam_x,
			camera_y = obj_global.cam_y;
			
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
