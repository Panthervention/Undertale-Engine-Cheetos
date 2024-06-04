image_alpha = 0;
repeat(6)
	instance_create_depth(x, y, 0, obj_gameover_shard);

audio_play_sound(snd_break_1, 0, false);

alarm[2] = 100;