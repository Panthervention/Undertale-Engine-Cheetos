/// @description UI (vital bars, _name, LV)
var _hp_x = ui_x; //global.kr_enable != true ? ui_x : (ui_x - 20); (UT Mechanic, but I don't feel like using this)
var _hp_y = ui_y;
	
var _name_x = ui_x - 245;
var _name_y = ui_y;
	
var _col_default = c_white;
	
var _name = Player_GetName();
var _col_name = c_white;
	
var _lv = Player_GetLv();
var _col_lv = c_white;
var _col_lv_counter = c_white;
	
var _hp = global.hp;
var _hp_max = global.hp_max;
var _kr = global.kr;
	
if (_kr > _hp - 1)
	_kr = _hp - 1;
	
var _bar_multiplier = 1.2; // Default multiplier from UNDERTALE
var _bar_hp = _hp * _bar_multiplier;
var _bar_hp_max = _hp_max * _bar_multiplier;
var _bar_kr = -(_kr * _bar_multiplier);

var _col_hp = c_yellow;
var _col_hp_max = merge_color(c_red, c_maroon, 0.5); // Smh not red :lmao:
var _col_kr = c_fuchsia;
	
var _col_hp_icon = c_white;
var _hp_icon = "HP";
var _kr_icon = "KR";

draw_set_font(font_mars_needs_cunnilingus); // Name - LV Font
draw_set_alpha(ui_alpha);
// Name
draw_text_color(_name_x, _name_y, _name, _col_name, _col_name, _col_name, _col_name, ui_alpha);
// LV Icon
draw_text_color(_name_x + string_width(_name), _name_y, "   LV ", _col_lv, _col_lv, _col_lv, _col_lv, ui_alpha);
// LV Counter
draw_text_color(_name_x + string_width(_name + "   LV "), _name_y, string(_lv), _col_lv_counter, _col_lv_counter, _col_lv_counter, _col_lv_counter, ui_alpha);

// Background bar
draw_sprite_ext(spr_pixel, 0, _hp_x, _hp_y, _bar_hp_max, 20, 0, _col_hp_max, ui_alpha);

// HP bar
draw_sprite_ext(spr_pixel, 0, _hp_x, _hp_y, _bar_hp, 20, 0, _col_hp, ui_alpha);
	
draw_set_font(font_ut_hp); // Icon Font
// HP Icon
draw_text_color((_hp_x - 31), _hp_y + 5, _hp_icon, _col_default, _col_default, _col_default, _col_default, ui_alpha);

// KR bar
if (global.kr_enable)
{
	if (round(_kr) > 0)
	{
		_col_hp_icon = _col_kr;
		// Draw the bar
		draw_sprite_ext(spr_pixel, 0, _hp_x + _bar_hp, _hp_y, _bar_kr, 20, 0, _col_kr, ui_alpha);
	}
	else _col_hp_icon = c_white;
		
	// Draw icon
	draw_text_color((_hp_x + 10) + (_hp_max * _bar_multiplier), _hp_y + 5, _kr_icon, _col_hp_icon, _col_hp_icon, _col_hp_icon, _col_hp_icon, ui_alpha);
}

// Zeropadding
var _hp_counter = $"{(round(_hp) < 10) ? "0" : ""}{round(_hp)}";
var _hp_max_counter = $"{(round(_hp_max) < 10) ? "0" : ""}{round(_hp_max)}";

// This line below supports multiple digits for Zeropadding, but I just personally don't like it. 
// var hp_counter = string_replace_all(string_format(round(_hp), string_length(string(_hp_max)), 0), " ", "0");

// Draw the health counter
draw_set_color(_col_hp_icon);
draw_set_font(font_mars_needs_cunnilingus); // Counter Font
var _offset = (!global.kr_enable) ? 15 : (20 + string_width(_kr_icon));
draw_text((_hp_x + _offset) + (_hp_max * _bar_multiplier), _hp_y, $"{_hp_counter} / {_hp_max_counter}");

draw_set_alpha(1);
draw_set_color(c_white);
