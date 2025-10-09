///@func Battle_Flash(enable)
///@desc With this function, you can trigger (sans's) flash effect (screen go dark with noise then go back to normal with noise).
///@param {Bool}	enabled		Set to enable (true/on) or disable (false/off) the (sans) flash effect.
function Battle_Flash(_enabled)
{
	with (obj_global)
	{
		if (_enabled)
		{
			fader_color = c_black;
			fader_alpha = 1;
			audio_pause_all();
			instance_destroy(obj_battle_bullet);
		}
		else
		{
			fader_alpha = 0;
			audio_resume_all();
		}
		audio_play_sound(snd_noise, 1, false);
	}
}
