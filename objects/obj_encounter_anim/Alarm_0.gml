if (Encounter_IsExists(__encounter) && instance_exists(obj_char_player))
{
    if (__exclam)
    {
        var _inst = instance_create_depth(0, 0, 0, obj_exclamation);
        _inst.x = obj_char_player.x;
        _inst.y = obj_char_player.y - obj_char_player.sprite_height;
        var _time = 30 + irandom(10);
        _inst.time = _time;
        audio_play_sound(snd_exclamation, 0, false);
        alarm[1] = _time;
    }
    else
        alarm[1] = 1;
}
else
    instance_destroy();
