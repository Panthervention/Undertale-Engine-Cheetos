///@func Battle_End()
///@desc End the battle immediately.
function Battle_End()
{
	var _room_return = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.BATTLE_ROOM_RETURN);
	if (room_exists(_room_return))
	{
	    obj_global.fader_alpha = 1;
	    room_goto(_room_return);
	    Fader_Fade(1, 0, 20);
	}
}
