active = true;
state = 1;

if sound_warn
{
	audio_play_sound(snd_warning, 0, false);
	sound_warn = false;
}
