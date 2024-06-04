event_inherited();

depth = DEPTH_UI.TEXT;
gui = true;

if (instance_exists(obj_char_player))
{
    _top = (obj_char_player.y - obj_global.cam_y > 130 + obj_char_player.sprite_height);
    obj_char_player._moveable_dialog = false;
}
else
	_top = false;

_initialized = false;
_auto_end = true;
