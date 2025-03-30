depth = DEPTH_UI.PANEL;

if (instance_exists(obj_char_player))
{
    _top = (obj_char_player.y - camera.y > 130 + obj_char_player.sprite_height);
	obj_char_player._moveable_menu = false;
}
else
    _top = false;

_color_theme = c_white;

_prefix = "[scale, 2][font_dt_sans]";

__menu = 0;
_choice = 0;
_choice_item = 0;
_choice_item_operation = 0;
_choice_cell = 0;

audio_play_sound(snd_menu_switch, 0, false);

event_user(0); // Stashing text elements
