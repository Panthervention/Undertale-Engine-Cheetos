if (state == 0)
{
	var _blaster = [blaster.x, blaster.y, blaster.image_angle];
	var _target = [target_x, target_y, target_angle];
	var _timer = timer_move;
	
	// Play charge sound
	if (charge_sound)
	{
		audio_stop_sound(snd_gb_charge);
		var blaster_sfx = audio_play_sound(snd_gb_charge, 0, 0);
		audio_sound_pitch(blaster_sfx, 1.2);
	
		charge_sound = 0;
	}
	
	// Move blaster to assigned destination
	if (_timer < time_move)
	{
		for (var i = 0; i < 3; i++)
		{
			_blaster[i] += (_target[i] - _blaster[i]) * (5 / time_move);
			_blaster[i] += sign(_target[i] - _blaster[i]) / 2;
			if (abs(_blaster[i] - _target[i]) < 1.5) _blaster[i] = _target[i];
		}
		_timer ++;
	}
	
	if ((_timer = time_move) || (!time_move))
	{
		// Wait till blast
		state = 1;
		_timer = 0;
		for (var i = 0; i < 3; i++)
			_blaster[i] = _target[i];
		
		alarm[0] = max(1, time_pause);
	}
	
	with (blaster)
	{
		x = _blaster[0];
		y = _blaster[1];
		image_angle = _blaster[2];
	}
	
	target_x = _target[0];
	target_y = _target[1];
	target_angle = _target[2];
	
	timer_move = _timer;
}

if (state == 2)
{
	state = 3;
	alarm[0] = 8;
	alarm[1] = 9;
}

if (state == 3)
	blaster.image_index += 0.5;


if (state == 4)
{
	var _blaster = [blaster.x, blaster.y, blaster.image_angle, blaster.image_xscale, blaster.image_yscale, blaster.direction, blaster.speed],
		_beam = [x, y, image_angle, image_xscale, image_yscale, image_alpha];
	
	var _timer = [timer_blast, timer_exit];
	
	_blaster[5] = _blaster[2] - 180;
	with (blaster)
	{
		var rx = 0;
		var ry = 0;
		
		if (_blaster[6] != 0)
		{
			_blaster[0] += lengthdir_x(_blaster[6], _blaster[5]);
			_blaster[1] += lengthdir_y(_blaster[6], _blaster[5]);
		}
		
		var spr_width = (sprite_get_width(sprite_index) / 2);
		_beam[2] = _blaster[2];
		_beam[0] = _blaster[0] + lengthdir_x(spr_width * _blaster[3], _beam[2]) + rx;
		_beam[1] = _blaster[1] + lengthdir_y(spr_width * _blaster[3], _beam[2]) + ry;
	}
	
	if (_timer[0] == 0)
	{	
		if (_blaster[4] >= 2)
		{
			Camera_Shake(5, 5, 1, 1, 1, 1, 0.5, 0.5);
			if (blurring)
				Screen_Blur(_blaster[4], time_blast);
		}
		if (release_sound)
		{
			audio_stop_sound(snd_gb_release);
			var beam_up_sfx = audio_play_sound(snd_gb_release, 0, 0);
			audio_sound_pitch(beam_up_sfx, 1.2);
	
			audio_stop_sound(snd_gb_release2);
			var beam_sfx_a = audio_play_sound(snd_gb_release2, 0, 0);
			audio_sound_pitch(beam_sfx_a, 1.2);
			audio_sound_gain(beam_sfx_a, 0.8, 0);
	
			release_sound = 0;
		}
	}
	
	for (var i = 0; i < 2; i++) _timer[i] ++;
	_beam[3] += _blaster[6] / 20;
	
	if (_timer[1] >= time_stay && _timer[1] < (time_stay + 10)) _blaster[6] += 0.5;
	else if (_timer[1] > (time_stay + 10)) _blaster[6] += 2;
	
	if (_timer[0] < 10)
		_beam[4] += (_blaster[4]) / 10;
	
	if (_timer[0] >= 10 + time_blast)
	{
		_beam[4] *= sqrt(0.8);
		_beam[5] -= 0.05;
		
		if _beam[4] <= 0.05 destroy = 1;
	}
	
	if ((_beam[5] >= 0.8 and _beam[4] > 0.05) && place_meeting(x, y, obj_battle_soul))
		Battle_CallSoulEventBulletCollision();
	
	auto_destroy();
		
	#region Reassign variable value back from local vars
	with (blaster)
	{
		x = _blaster[0];
		y = _blaster[1];
		image_angle = _blaster[2];
		image_xscale = _blaster[3];
		image_yscale = _blaster[4];
		direction = _blaster[5];
		speed = _blaster[6];
	}
	
	x = _beam[0];
	y = _beam[1];
	image_angle = _beam[2];
	image_xscale = _beam[3];
	image_yscale = _beam[4];
	image_alpha = _beam[5];
	
	timer_blast = _timer[0];
	timer_exit = _timer[1];
	#endregion
}
