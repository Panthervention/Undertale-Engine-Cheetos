depth = DEPTH_UI.PANEL;

_state = -1;
_choice = 0;

_color_default = c_white;
_color_saved = c_yellow;

_prefix = "[scale, 2][font_dt_sans]";

_timer = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.TIME);
_minute = _timer div 60;
_second = _timer mod 60;

if (instance_exists(obj_char_player))
    obj_char_player._moveable_save = false;

event_user(0); // Stashing text elements
