///@arg enable
function Border_SetEnabled(enable) 
{
	with obj_global
	{
		if (enable)
		{
		    window_set_size(960, 540);
		    border_enable = true;
		    alarm[0] = 1;
		}
		else
		{
		    window_set_size(640, 480);
		    border_enable = false;
		    alarm[0] = 1;
		
		    if (sprite_exists(border_sprite))
		    {
		        sprite_flush(border_sprite);
		        border_sprite = -1;
		    }
		    if (sprite_exists(border_sprite_previous))
		    {
		        sprite_flush(border_sprite_previous);
		        border_sprite_previous = -1;
		    }
		}
	}
	return true;
}

///@arg sprite
///@arg [fade]
///@arg [time]
function Border_SetSprite(sprite, fade = true, duration = 60)
{
	with (obj_global)
	{
		if (sprite != border_sprite_previous && sprite != border_sprite)
		{
		    if (sprite_exists(border_sprite_previous))
		        sprite_flush(border_sprite_previous);
		}

		border_sprite_previous = border_sprite;
		border_sprite = sprite;

		if (fade)
			TweenFire(id, "", 0, off, 0, duration, "_alpha", 0, 1);
	}

	return true;
}

function Border_IsEnabled()
{
	return obj_global.border_enable;
}

function Border_GetSprite()
{
	return obj_global.border_sprite;
}

