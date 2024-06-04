function Battle_End() 
{
	var room_return = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.BATTLE_ROOM_RETURN);
	if (room_exists(room_return))
	{
	    obj_global.fader_alpha = 1;
	    room_goto(room_return);
	    Fader_Fade(-1, 0, 20);
	}
	return true;
}
