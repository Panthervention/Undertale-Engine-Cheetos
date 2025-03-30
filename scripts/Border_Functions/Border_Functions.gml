///@param enable
///@param [auto_capture]
function Border_SetEnabled(_enable, _auto_capture = false) 
{
	with (border)
	{
		if (_enable)
		{
		    window_set_size(960, 540);
		    enable = true;
			auto_capture = _auto_capture;
			with (obj_global)
				alarm[0] = 1;
		}
		else
		{
		    window_set_size(640, 480);
		    enable = false;
			auto_capture = false;
		    with (obj_global)
				alarm[0] = 1;
		
		    if (sprite_exists(sprite))
		    {
		        sprite_flush(sprite);
		        sprite = -1;
		    }
		    if (sprite_exists(sprite_previous))
		    {
		        sprite_flush(sprite_previous);
		        sprite_previous = -1;
		    }
		}
	}
	return true;
}

///@param sprite
///@param [fade]
///@param [time]
function Border_SetSprite(_sprite, _fade = true, _duration = 60)
{
	with (border)
	{
		if (_sprite != sprite_previous && _sprite != sprite)
		{
		    if (sprite_exists(sprite_previous))
		        sprite_flush(sprite_previous);
		}

		sprite_previous = sprite;
		sprite = _sprite;

		if (_fade)
			TweenFire(self, "", 0, off, 0, _duration, "alpha", 0, 1);
	}

	return true;
}

function Border_IsEnabled()
{
	return border.enable;
}

function Border_GetSprite()
{
	return border.sprite;
}

