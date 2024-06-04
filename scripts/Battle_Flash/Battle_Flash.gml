function Battle_Flash(mode)
{
	with obj_global
	{
		switch mode
		{
			case true:
				fader_color = c_black;
				fader_alpha = 1;
				audio_pause_all();
				audio_play_sound(snd_noise, 1, false);
				instance_destroy(obj_battle_bullet);
				break;
			
			case false:
				fader_alpha = 0;
				audio_play_sound(snd_noise, 1, false);
				audio_resume_all();
				break;
		}
	}
}


