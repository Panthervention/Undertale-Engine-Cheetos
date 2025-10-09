if (__flash < 3)
{
    __draw_soul ^= true;
    if (__draw_soul)
    {
        __flash++;
        audio_play_sound(snd_noise, 0, false);
    }
    
    alarm[2] = 2 * (__quick ? 1 : 2);
}
else
{
    __draw_player = false;
    __draw_soul = true;
    
    var _duration = 15 * (__quick ? 1 : 2);
	TweenFire(id, "", 0, off, 0, _duration, "__draw_soul_x>", __soul_x, "__draw_soul_y>", __soul_y);	
    audio_play_sound(snd_encounter_soul_move, 0, false);
    
    alarm[3] = 20 * (__quick ? 1 : 2);
}
