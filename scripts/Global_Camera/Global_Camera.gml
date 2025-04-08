function Global_Camera() constructor {	
	
	Init();
	//__camera = camera_create_view(x, y, (width / scale_x) + 1, (height / scale_y) + 1, angle, target, -1, -1, ((width / scale_x) + 1) / 2, ((height / scale_y) + 1) / 2);

	static Init = function()
	{
		#region	Public Variables
		x = 0;
		y = 0;
		
		width = 640;
		height = 480;
		
		scale_x = 1;
		scale_y = 1;
		
		angle = 0;
		
		target = noone;
		target_previous = noone;

		use_room_limit = true;
		limit_top = 0;
		limit_bottom = 0;
		limit_left = 0;
		limit_right = 0;

		shake_x = 0;
		shake_y = 0;
		shake_speed_x = 0;
		shake_speed_y = 0;
		shake_random_x = false;
		shake_random_y = false;
		shake_decrease_x = -1;
		shake_decrease_y = -1;
		#endregion
	
		#region	Private Variables
		__shake_pos_x = 0;
		__shake_pos_y = 0;
		__shake_time_x = 0;
		__shake_time_y = 0;
		__shake_positive_x = true;
		__shake_positive_y = true;
		#endregion
	}
	
	static Reload = function()
	{
		Init();
		
		view_enabled = true;
		view_visible[0] = true;
	}
	
	static Update = function()
	{
		var _cam = view_camera[0],
		    _cam_to_x = x, _cam_to_y = y,
		    _cam_scale_x = scale_x, _cam_scale_y = scale_y,
		    _cam_width = width / _cam_scale_x, _cam_height = height / _cam_scale_y,
		    _cam_angle = angle,
		    _cam_target = target,
			_cam_shake_x = 0, _cam_shake_y = 0;
    
		// Handle horizontal shake
		if (shake_x > 0)
		{
		    camera_set_view_target(_cam, noone);
        
		    if (__shake_time_x > 0)
		        __shake_time_x -= 1;
		    else
		    {
		        if (!shake_random_x)
		        {
		            if (__shake_positive_x)
		                __shake_pos_x = shake_x;
		            else
		            {
		                shake_x -= shake_decrease_x;
		                __shake_pos_x = -shake_x;
		            }
		            __shake_positive_x = !__shake_positive_x;
		        }
		        else
		        {
		            __shake_pos_x = random_range(-shake_x, shake_x);
		            shake_x -= shake_decrease_x;
		        }
		        __shake_time_x = shake_speed_x;
		    }
		    _cam_shake_x = __shake_pos_x;
		}
		else
		{
		    shake_x = 0;
		    shake_speed_x = 0;
		    shake_decrease_x = 1;
		    shake_random_x = false;
		    __shake_time_x = 0;
		    __shake_pos_x = 0;
		    __shake_positive_x = true;
		}
		
		// Handle vertical shake
		if (shake_y > 0)
		{
		    camera_set_view_target(_cam, noone);
        
		    if (__shake_time_y > 0)
		        __shake_time_y -= 1;
		    else
		    {
		        if (!shake_random_y)
		        {
		            if (__shake_positive_y)
		                __shake_pos_y = shake_y;
		            else
		            {
		                shake_y -= shake_decrease_y;
		                __shake_pos_y = -shake_y;
		            }
		            __shake_positive_y = !__shake_positive_y;
		        }
		        else
		        {
		            __shake_pos_y = random_range(-shake_y, shake_y);
		            shake_y -= shake_decrease_y;
		        }
		        __shake_time_y = shake_speed_y;
		    }
		    _cam_shake_y = __shake_pos_y;
		}
		else
		{
		    shake_y = 0;
		    shake_speed_y = 0;
		    shake_decrease_y = 1;
		    shake_random_y = false;
		    __shake_time_y = 0;
		    __shake_pos_y = 0;
		    __shake_positive_y = true;
		}
    
		// Reset target if shake is done
		if (shake_x <= 0 && shake_y <= 0)
		    camera_set_view_target(_cam, target_previous);
    
		// Handle targeting
		if (_cam_target != target_previous)
		    camera_set_view_target(_cam, _cam_target);
    
		// If the camera has a target, apply camera position to target
		if (target != noone && instance_exists(target))
		{
		    _cam_to_x = target.x - (_cam_width / 2);    
		    _cam_to_y = target.y - (_cam_height / 2);
		}
    
		// Apply shake offset to current position
		camera_set_view_pos(_cam, _cam_to_x + _cam_shake_x, _cam_to_y + _cam_shake_y);
    
		// Assign view size and angle
		camera_set_view_size(_cam, _cam_width, _cam_height);
		camera_set_view_angle(_cam, _cam_angle);
    
		// Update previous target
		target_previous = _cam_target;
    
		// Update stored position (without shake)
		x = _cam_to_x;
		y = _cam_to_y;
	}
}

///@function Camera_Shake(xtensity, ytensity, [xspeed], [yspeed], [xstep], [ystep], [xrandom], [yrandom])
///@desc Creating screen shaking effect.
///@param {Real}	xtensity	Horizontal intensity.
///@param {Real}	ytensity	Vertical intensity.
///@param {Real}	[xspeed]	Horizontal speed. (Default: 0)
///@param {Real}	[yspeed]	Vertical speed. (Default: 0)
///@param {Real}	[xstep]		Horizontal intensity decrement per step. (Default: 1)
///@param {Real}	[ystep]		Vertical intensity decrement per step. (Default: 1)
///@param {Bool}	[xrandom]	Randomize horizontal shake. (Default: false)
///@param {Bool}	[yrandom]	Randomize vertical shake. (Default: false)
function Camera_Shake(_x, _y, _xspeed = 0, _yspeed = 0, _xstep = 1, _ystep = 1, _xrandom = false, _yrandom = false) 
{
	with (camera)
	{
		shake_x = _x;
		shake_y = _y;
		shake_speed_x = _xspeed;
		shake_speed_y = _yspeed;
		shake_random_x = _xrandom;
		shake_random_y = _yrandom;
		shake_decrease_x = _xstep;
		shake_decrease_y = _ystep;
		__shake_pos_x = 0;
		__shake_pos_y = 0;
		__shake_time_x = 0;
		__shake_time_y = 0;
		__shake_positive_x = true;
		__shake_positive_y = true;
	}
	return true;
}