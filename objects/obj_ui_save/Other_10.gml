/// @description Update Text Elements
/* Feather ignore all */
__name	= Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, lexicon_text("ui.save.name_empty"));
__lv	= $"LV  {Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.LV)}";
__time	= $"{__minute}:{__second < 10 ? "0" : ""}{__second}";
__room	= Player_GetRoomName(Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.ROOM, -1));
__saved	= lexicon_text("ui.save.saved");
__save	= lexicon_text("ui.save.save");
__return = lexicon_text("ui.save.return");
