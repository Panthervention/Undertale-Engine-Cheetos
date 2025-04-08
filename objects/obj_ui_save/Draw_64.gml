if (__state == 0 || __state == 1)
{
	// Background
    draw_sprite_ext(spr_pixel, 0, 108, 118, 424, 174, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 114, 124, 412, 162, 0, c_black, 1);
	
	var _color = (__state == 1) ? __color_saved : __color_default;
	draw_set_format(font_dt_sans, _color);
	draw_text_transformed(140, 140, __name, 2, 2, 0);
	draw_text_transformed(294, 140, __lv  , 2, 2, 0);
	draw_text_transformed(452, 140, __time, 2, 2, 0);
	
	draw_text_transformed(140, 180, __room, 2, 2, 0);
	
	if (__state == 0)
	{	
		draw_text_transformed(170, 240, __save, 2, 2, 0);
		draw_text_transformed(350, 240, __return, 2, 2, 0);
		var _soul_x = (__choice == 0) ? 151 : 331;
		draw_sprite_ext(spr_battle_soul, 0, _soul_x, 255, 1, 1, 0, c_red, 1);
	}
	else
		draw_text_transformed(170, 240, __saved, 2, 2, 0);
	draw_set_color(c_white);
}


