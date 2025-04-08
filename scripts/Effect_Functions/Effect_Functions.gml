///@func Screen_Blur(intensity, duration, [delay])
///@desc Create screen gaussian blurring effect via obj_blur_shader.
///@param {Real}	intensity	The intensity of the blur.
///@param {Real}	duration	The duration of the blur's fading.
///@param {Real}	[delay]		The delay until the blur fades.
///@return {Id.Instance}
function Screen_Blur(_intensity, _duration, _delay = 0)
{
	instance_destroy(obj_blur_shader); // Only 1 can exists at a time!	
	var _blur = instance_create_depth(0, 0, 0, obj_blur_shader);
	with (_blur)
	{
		alarm[0] = _duration; // instance_destroy() for the blur object!
		TweenFire(id, "", 0, off, _delay, _duration, "blur_intensity", _intensity, 0);
	}
	return _blur;
}

///@desc Create screen Kawase blurring effect via obj_blur_kawase.
///@param {Real}	intensity	The intensity of the blur.
///@param {Real}	duration	The duration of the blur's fading.
///@param {Real}	[delay]		The delay until the blur fades.
///@return {Id.Instance}
function Screen_BlurKawase(_intensity, _duration, _delay = 0)
{
	instance_destroy(obj_blur_kawase); // Only 1 can exists at a time!	
	var _blur = instance_create_depth(0, 0, 0, obj_blur_kawase);
	with (_blur)
	{
		blur_intensity_max = _intensity;
		alarm[0] = _duration; // instance_destroy() for the blur object!
		TweenFire(id, EaseInCubic, TWEEN_MODE_ONCE, off, _delay, _duration, "blur_intensity", _intensity, 0);
	}
	return _blur;
}