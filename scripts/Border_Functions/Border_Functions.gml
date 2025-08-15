///@func Border_SetEnabled(enable, [auto_capture])
///@desc Enable of disable the display border.
///@param {Bool}	enable				Set to enable (true/on) or disable (false/off) the display border.	
///@param {Bool}	[auto_capture]		Set to enable (true/on) or disable (false/off) the auto capture feature. (Default: false)
function Border_SetEnabled(_enable, _auto_capture = false) {
	with (border)
	{
		if (_enable)
		{
		    window_set_size(960, 540);
		    enable = true;
			auto_capture = _auto_capture;
			obj_global.alarm[0] = 1;
		}
		else
		{
		    window_set_size(640, 480);
		    enable = false;
			auto_capture = false;
		    obj_global.alarm[0] = 1;
		
		    if (sprite_exists(sprite))
		    {
		        sprite_flush(sprite);
		        sprite = -1;
				index = 0;
		    }
		    if (sprite_exists(sprite_previous))
		    {
		        sprite_flush(sprite_previous);
		        sprite_previous = -1;
				index_previous = 0;
		    }
		}
	}
}

///@func Border_IsEnabled()
///@desc Return whenever the display border is enable or not.
///@return {Bool}
function Border_IsEnabled() {
	return border.enable;
}

///@func Border_SetSprite(sprite, [fade], [duration])
///@desc Set the sprite for the display border.
///@param {Asset.GMSprite}		sprite		The index of the sprite to use as the border sprite.
///@param {Real}				[index]		The sub-image (frame) of the sprite to draw. (Default: 0)
///@param {Bool}				[fade]		Whenever there should be fading effect. (Default: true)
///@param {Real}				[time]		The duration of the fading effect if available. (Default: 60)
function Border_SetSprite(_sprite, _index = 0, _fade = true, _duration = 60) {
	with (border)
	{
		if (_sprite != sprite_previous && _sprite != sprite)
		{
		    if (sprite_exists(sprite_previous))
		        sprite_flush(sprite_previous);
		}
		
		sprite_previous = sprite;
		sprite = _sprite;
		
		index_previous = index;
		index = _index;
		
		alpha = 0;
		
		if (_fade)
			TweenFire(self, "", 0, off, 0, _duration, "alpha", 0, 1);
	}
}

///@func Border_GetSprite()
///@desc Return the currently set sprite of the display border.
///@return {Asset.GMSprite}
function Border_GetSprite() {
	return border.sprite;
}

///@func Border_GetIndex()
///@desc Return the currently sub-image (frame) of the display border.
///@return {Real}
function Border_GetIndex() {
	return border.index;
}



