if (__state == 0 || __state == 1)
{
	// Background
    draw_sprite_ext(spr_pixel, 0, 108, 118, 424, 174, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 114, 124, 412, 162, 0, c_black, 1);
	
	var _color = (__state == 1) ? _color_saved : _color_default;
	draw_set_format(font_dt_sans, _color);
	draw_text_transformed(140, 140, _name, 2, 2, 0);
	draw_text_transformed(294, 140, _lv  , 2, 2, 0);
	draw_text_transformed(452, 140, _time, 2, 2, 0);
	
	draw_text_transformed(140, 180, _room, 2, 2, 0);
	
	if (__state == 0)
	{	
		draw_text_transformed(170, 240, _save, 2, 2, 0);
		draw_text_transformed(350, 240, _return, 2, 2, 0);
		var soul_x = (_choice == 0) ? 151 : 331;
		draw_sprite_ext(spr_battle_soul, 0, soul_x, 255, 1, 1, 0, c_red, 1);
	}
	else
		draw_text_transformed(170, 240, _saved, 2, 2, 0);
	draw_set_color(c_white);
}


