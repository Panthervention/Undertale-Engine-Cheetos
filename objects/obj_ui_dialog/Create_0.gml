event_inherited();

depth = DEPTH_UI.TEXT;
gui = true;

__top = false;
if (instance_exists(obj_char_player))
{
    __top = (obj_char_player.y - camera.y > 130 + obj_char_player.sprite_height);
    obj_char_player.__moveable_dialog = false;
}

__initialized = false;
__auto_end = true;
