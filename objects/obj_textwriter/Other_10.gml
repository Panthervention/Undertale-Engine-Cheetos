///@desc Draw code
var text_x = x, text_y = y;

var finished = (text_typist.get_state() == 1);

#region Portrait drawing
if (sprite_exists(portrait))
{
	var portrait_x = x,
		portrait_y = y,
		portrait_w = sprite_get_width(portrait),
		portrait_h = sprite_get_height(portrait);
	
	switch (portrait_side)
	{
		case PORTRAIT_SIDE.LEFT:
			portrait_x += (portrait_w * (portrait_xscale * 0.4));
			text_x += portrait_w * portrait_xscale;			
			break;
		case PORTRAIT_SIDE.RIGHT:
			portrait_x = x + text_wrapwidth;
			break;
	}
	portrait_y += (portrait_h * (portrait_yscale * 0.4));
	var portrait_subimg = portrait_index;
	// If the portrait does support animate when typing
	if (!finished && portrait_speed > 0)
	{
		portrait_index += portrait_speed;
		portrait_index = clamp(portrait_index, 0, array_length(portrait_index_array) - 1)
		portrait_subimg = portrait_index_array[portrait_index];
		
		if (portrait_index >= array_length(portrait_index_array) - 1)
			portrait_index = 0;
	}
	draw_sprite_ext(portrait, portrait_subimg, portrait_x, portrait_y, portrait_xscale, portrait_yscale, 0, c_white, 1);
}
#endregion

#region Option Dialog (Dialog Branching)
if (option_exist && text_typist.get_state() == 1)
	draw_sprite_ext(spr_battle_soul, 0, 36 + option_x[option], text_y + option_y[option], 1, 1, 0, c_red, 1);

#endregion

// Text drawing. This is all it took.
text_writer.draw(text_x, text_y, text_typist);
