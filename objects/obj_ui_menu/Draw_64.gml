var _is_top = (__top ? 270 : 0),
	_color = __color_theme;

draw_set_format(font_dt_sans, _color);
#region Quick Stats
draw_sprite_ext(spr_pixel, 0, 32, 52 + _is_top, 142, 110, 0, _color, 1);
draw_sprite_ext(spr_pixel, 0, 38, 58 + _is_top, 130, 98, 0, c_black, 1);

draw_text_transformed(46, 60 + _is_top, __player_name, 2, 2, 0);

draw_set_format(font_crypt_of_tomorrow, _color);
draw_text_transformed(46, 100 + _is_top, __label_lv, 2, 2, 0);
draw_text_transformed(46, 118 + _is_top, __label_hp, 2, 2, 0);
draw_text_transformed(46, 136 + _is_top, __label_g, 2, 2, 0);
draw_text_transformed(90, 136 + _is_top, __player_gold, 2, 2, 0);
draw_set_format(font_dt_sans, _color);
#endregion

#region Navigation
draw_sprite_ext(spr_pixel, 0, 32, 168, 142, 148, 0, _color, 1);
draw_sprite_ext(spr_pixel, 0, 38, 174, 130, 136, 0, c_black, 1);

var _item_col = __label_item_count > 0 ? _color : c_dkgray;
draw_text_transformed_color(84, 190, __label_item, 2, 2, 0, _item_col, _item_col, _item_col, _item_col, 1);
draw_text_transformed(84, 222, __label_stat, 2, 2, 0);
if (__label_address_count > 0)
	draw_text_transformed(84, 254, __label_cell, 2, 2, 0);

if (__menu == 0) // Main Menu Navigation
{
	var _soul_y = 205 + 32 * __choice;
    draw_sprite_ext(spr_battle_soul, 0, 65, _soul_y, 1, 1, 0, c_red, 1);
}
#endregion

#region Item
else if (__menu == 1 || __menu == 2)
{
    draw_sprite_ext(spr_pixel, 0, 188, 52, 346, 362, 0, _color, 1);
    draw_sprite_ext(spr_pixel, 0, 194, 58, 334, 350, 0, c_black, 1);
		
	__draw_item_name.draw(232, 80); // All items are drawn in 1 instance
	draw_text_transformed(232, 360, __label_item_use, 2, 2, 0);
	draw_text_transformed(328, 360, __label_item_info, 2, 2, 0);
	draw_text_transformed(442, 360, __label_item_drop, 2, 2, 0);
	
	// Soul Navigation
	if (__menu == 1)
	{
		var _soul_y = 97 + 32 * __choice_item;
		draw_sprite_ext(spr_battle_soul, 0, 217, _soul_y, 1, 1, 0, c_red, 1);
	}

	if (__menu == 2)
	{
	    var _xpreset = [23, 119, 233],
			_soul_x = 194 + _xpreset[__choice_item_operation];
	    draw_sprite_ext(spr_battle_soul, 0, _soul_x, 377, 1, 1, 0, c_red, 1);
	}
}
#endregion

#region Full Stats
else if (__menu == 3)
{
    draw_sprite_ext(spr_pixel, 0, 188, 52, 346, 418, 0, _color, 1);
    draw_sprite_ext(spr_pixel, 0, 194, 58, 334, 406, 0, c_black, 1);
	
	draw_text_transformed(216, 84, __label_stats_name, 2, 2, 0);
	draw_text_transformed(216, 147, __label_stats_vitality, 2, 2, 0);
	draw_text_transformed(216, 338, __label_stats_equipment, 2, 2, 0);
	draw_text_transformed(216, 406, __label_stats_gold, 2, 2, 0);
	
	draw_text_transformed(384, 242, __label_stats_xp, 2, 2, 0);
	draw_text_transformed(384, 406, __label_stats_kill_count, 2, 2, 0);
}
#endregion

#region Cell
else if (__menu == 4)
{
    draw_sprite_ext(spr_pixel, 0, 188, 52, 346, 270, 0, _color, 1);
    draw_sprite_ext(spr_pixel, 0, 194, 58, 334, 258, 0, c_black, 1);
	
	__draw_cell_address.draw(232, 80); // All cells are drawn in 1 instance
	
	// Soul Navigation
	var _soul_y = 97 + 32 * __choice_cell;
	draw_sprite_ext(spr_battle_soul, 0, 217, _soul_y, 1, 1, 0, c_red, 1);
}
#endregion
draw_set_color(c_white);
