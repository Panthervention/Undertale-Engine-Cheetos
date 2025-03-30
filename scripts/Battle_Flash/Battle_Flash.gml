///@func Battle_Flash(enable)
///@desc With this function, you can trigger (sans's) flash effect (screen go dark with noise then go back to normal with noise).
///@param {Bool}	enable		Set to enable (true/on) or disable (false/off) the (sans) flash effect.
function Battle_Flash(_enable)
{
	with (obj_global)
	{
		switch (_enable)
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
