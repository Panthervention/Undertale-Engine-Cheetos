/// @description Update Text Elements

_name	= Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, lexicon_text("ui.save.name_empty"));
_lv		= $"LV  {Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.LV)}";
_time	= $"{_minute}:{_second < 10 ? "0" : ""}{_second}";
_room	= Player_GetRoomName(Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.ROOM, -1));
_saved	= lexicon_text("ui.save.saved");
_save	= lexicon_text("ui.save.save");
_return = lexicon_text("ui.save.return");
