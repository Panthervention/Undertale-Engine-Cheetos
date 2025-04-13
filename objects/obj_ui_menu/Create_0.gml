depth = DEPTH_UI.PANEL;

__top = false;
if (instance_exists(obj_char_player))
{
    __top = (obj_char_player.y - camera.y > 130 + obj_char_player.sprite_height);
	obj_char_player.__moveable_menu = false;
}

__color_theme = c_white;

__prefix = "[scale, 2][font_dt_sans]";

__menu = 0;
__choice = 0;
__choice_item = 0;
__choice_item_operation = 0;
__choice_cell = 0;

audio_play_sound(snd_menu_switch, 0, false);

event_user(0); // Stashing text elements
