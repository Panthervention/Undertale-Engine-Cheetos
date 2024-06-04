///@desc Hurt
global.inv = Player_GetInvTotal();
if (Player_GetInv() > 10)
	Camera_Shake(2, 2, 4, 4);

audio_stop_sound(snd_hurt);
repeat (2)
	audio_play_sound(snd_hurt, 50, false);
