Flag_Clear(FLAG_TYPE.STATIC);
Flag_Clear(FLAG_TYPE.DYNAMIC);
Flag_Define();
Player_SetName(__naming_name);
Fader_Fade(1, 0, 20);
room_goto_next();
