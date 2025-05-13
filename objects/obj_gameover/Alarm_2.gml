///@desc Game Over UI Activate
__soul_shard_render = false;
delete __soul_shard;
__state = 1;
__gameover_bgm = audio_play_sound(bgm_gameover, 0, true);
