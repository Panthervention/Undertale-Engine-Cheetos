Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_LANDMARK, target_landmark);
if (instance_exists(obj_char_player))
{
    var _player_dir = DIR.DOWN;
    if (player_dir == -1)
        _player_dir = obj_char_player.dir;
    else
        _player_dir = player_dir;
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_DIR, _player_dir);
}

room_goto(target_room);
obj_global.fader_color = fade_out_color;
Fader_Fade(1, 0, fade_out_time);
