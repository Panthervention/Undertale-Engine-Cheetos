///@func __game_restart()
///@desc A replacement for GameMaker's game_restart() to restart the game.
function __game_restart() {
	// Source: https://tabularelf.com/custom-game-restart/

	// This will destroy all instances that are not persistent. 
	// Yes, this will run their cleanup events as well as their destroy event.
	with (all)
	{
		// Not like we actually need to destroy those persistencies.
		if (!persistent)
			instance_destroy();
	}

	// Reload Flag_Custom
	//Flag_Custom();

	// Cleaning all time sources just in case.
	var i = 0;
	while (time_source_exists(i))
		time_source_destroy(i++); 
		// When current time source dies the next time source become 0.

	audio_stop_all();
	draw_texture_flush();

	// Go to the very first room, as per room order
	room_goto(room_first);
	
	with (obj_global) // Re-initiate the obj_global
	{
		TweenDestroy({target: all});
		event_perform(ev_other, ev_game_end);
		event_perform(ev_other, ev_game_start);
		event_perform(ev_create, 0);
	}
}

///@func posmod(a, b)
///@desc Returns a POSITIVE Quotient of the 2 values.
///		 Do not confuse this with a % b!
///@param {Real}	a	The number to be divided.
///@param {Real}	b	The number to divide.
///@return {Real}
function posmod(_a, _b) {
	// Always return positive modulo.
	var _value = _a % _b;
	
	while ((_value < 0 && _b > 0) || (_value > 0 && _b < 0))
		_value += _b;
	
	return _value;
}

///@func object_get_base_parent(obj)
///@desc Return the object index of the root parent that has been assigned to the
///		 specified object, or else return -100 if the specified object has no assigned parent, or else return -1 if 
///		 the object being checked does not exist.
///@param {Asset.GMObject}		obj		The index of the object to check.
///@return {Asset.GMObject}
function object_get_base_parent(_obj) {
	if (object_exists(_obj))
	{
	    var _parent = object_get_parent(_obj);
	    if (object_exists(_parent))
	    {
	        var _new_parent = -1;
	        do
	        {
	            _new_parent = object_get_parent(_parent);
	            if (object_exists(_new_parent))
	                _parent = _new_parent;
	        } until (!object_exists(_new_parent))
	        return _parent;
	    }
	    else
	        return -1;
	}
	else
	    return -1;
}

///@func draw_set_align([halign], [valign])
///@desc Align text both horizontally and vertically. Changing alignment will change the position
///		 and direction in which all further text is drawn with the default value being fa_left and fa_top.
///@param {Constant.HAlign}		[halign]	Horizontal alignment. (Default: fa_left)
///@param {Constant.VAlign}		[valign]	Vertical alignment. (Default: fa_top)
function draw_set_align(_halign = fa_left, _valign = fa_top) {
	draw_set_halign(_halign);
	draw_set_valign(_valign);
}

///@func draw_set_format([font], [color])
///@desc Set the font to be used for all further text drawing and the base draw color for the game.
///@param {Asset.GMFont}		[font]		The name of the font to use.
///@param {Constant.Color}		[col]		The color to set for drawing.
function draw_set_format(font = font_dt_mono, color = c_white) {
	draw_set_font(font);
	draw_set_color(color);
}

///@func Fader_Fade(start, target, duration, [delay])
///@desc Create screen fade (in/out) effect.
///@param {Real}	start		The initial alpha value (between 0 and 1).
///@param {Real}	target		The target alpha value (between 0 and 1).
///@param {Real}	duration	The duration of the fading effect.
///@param {Real}	[delay]		The delay before the fading effect start. (Default: 0)
function Fader_Fade(_start, _target, _duration, _delay = 0) 
{
	with (obj_global)
	{	
		if (TweenExists(fader_tween))
			TweenDestroy(fader_tween);
		fader_tween = TweenFire(id, "", 0, off, _delay, _duration, "fader_alpha", _start, _target);
	}
}


