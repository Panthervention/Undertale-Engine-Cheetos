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

///@arg val1
///@arg val2
function posmod(a, b) {
	// Always return positive modulo.
	var value = a % b;
	
	if (value < 0 and b > 0) or (value > 0 and b < 0)
		value += b;
	
	return value;
}
	
///@arg obj
function object_get_base_parent(obj) {
	if (object_exists(obj))
	{
	    var parent = object_get_parent(obj);
	    if (object_exists(parent))
	    {
	        var new_parent = -1;
	        do
	        {
	            new_parent = object_get_parent(parent);
	            if (object_exists(new_parent))
	                parent = new_parent;
	        } until (!object_exists(new_parent))
	        return parent;
	    }
	    else
	        return -1;
	}
	else
	    return -1;
}

///@arg [halign]
///@arg [valign]
function draw_set_align(halign = fa_left, valign = fa_top) {
	draw_set_halign(halign);
	draw_set_valign(valign);
}

///@arg [font]
///@arg [col]
function draw_set_format(font = font_dt_mono, color = c_white) {
	draw_set_font(font);
	draw_set_color(color);
}

///@arg start
///@arg target
///@arg duration
///@arg [delay]
function Fader_Fade(start, target, duration, delay = 0) 
{
	with obj_global
	{	
		if (TweenExists(fader_tween))
			TweenDestroy(fader_tween);
		fader_tween = TweenFire(id, "", 0, off, delay, duration, "fader_alpha", start, target);
	}
	return true;
}


