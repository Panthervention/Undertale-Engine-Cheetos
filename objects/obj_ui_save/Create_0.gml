depth = DEPTH_UI.PANEL;

__state = -1;
__choice = 0;

__color_default = c_white;
__color_saved = c_yellow;

__prefix = "[scale, 2][font_dt_sans]";

__timer = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.TIME);
__minute = __timer div 60;
__second = __timer mod 60;

if (instance_exists(obj_char_player))
    obj_char_player.__moveable_save = false;

event_user(0); // Stashing text elements
