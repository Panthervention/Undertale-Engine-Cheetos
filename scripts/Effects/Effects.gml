///@arg intensity
///@arg duration
///@arg [delay]
function Screen_Blur(intensity, duration, delay = 0)
{
	instance_destroy(obj_blur_shader); // Only 1 can exists at a time!	
	var blur = instance_create_depth(0, 0, 0, obj_blur_shader);
	with blur
	{
		alarm[0] = duration; // instance_destroy() for the blur object!
		TweenFire(id, "", 0, off, delay, duration, "blur_intensity", intensity, 0);
	}
	return blur;
}

///@arg intensity
///@arg duration
///@arg [delay]
function Screen_BlurKawase(intensity, duration, delay = 0)
{
	instance_destroy(obj_blur_kawase); // Only 1 can exists at a time!	
	var blur = instance_create_depth(0, 0, 0, obj_blur_kawase);
	with blur
	{
		blur_intensity_max = intensity;
		alarm[0] = duration; // instance_destroy() for the blur object!
		TweenFire(id, "", 0, off, delay, duration, "blur_intensity", intensity, 0);
	}
	return blur;
}