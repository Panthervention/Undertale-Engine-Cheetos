///@desc Trigger
event_inherited();

if (room_exists(target_room))
{
    obj_global.fader_color = fade_in_color;
    Fader_Fade(0, 1, fade_in_time);
    if (instance_exists(obj_char_player))
        obj_char_player._moveable_warp = false;
    alarm[0] = fade_in_time + warp_wait + 1;
}
else
	show_debug_message($"CHEETOS: Attempt to warp to non-existing room {target_room}!");
