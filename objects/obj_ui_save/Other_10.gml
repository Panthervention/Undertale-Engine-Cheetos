/// @description Update Text Elements
/* Feather ignore all */
__name	= Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, Lexicon("ui.save.name_empty").Get());
__lv	= $"LV  {Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.LV)}";
__time	= $"{__minute}:{__second < 10 ? "0" : ""}{__second}";
__room	= Player_GetRoomName(Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.ROOM, -1));
__saved	= Lexicon("ui.save.saved").Get();
__save	= Lexicon("ui.save.save").Get();
__return = Lexicon("ui.save.return").Get();
