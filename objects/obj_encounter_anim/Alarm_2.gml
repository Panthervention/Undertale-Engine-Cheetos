if (_flash < 3)
{
    _draw_soul = !_draw_soul;
    if (_draw_soul)
    {
        _flash += 1;
        audio_play_sound(snd_noise, 0, false);
    }
    
    alarm[2] = 2 * (!_quick ? 2 : 1);
}
else
{
    _draw_player = false;
    _draw_soul = true;
    
    var duration = 15 * (!_quick ? 2 : 1);
	TweenFire(id, "", 0, off, 0, duration, "_draw_soul_x>", _soul_x);
	TweenFire(id, "", 0, off, 0, duration, "_draw_soul_y>", _soul_y);	
    audio_play_sound(snd_encounter_soul_move, 0, false);
    
    alarm[3] = 20 * (!_quick ? 2 : 1);
}
