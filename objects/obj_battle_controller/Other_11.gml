/// @description UI (vital bars, name, LV)
var hp_x = ui_x; //global.kr_enable != true ? ui_x : (ui_x - 20); (UT Mechanic, but I don't feel like using this)
var hp_y = ui_y;
	
var name_x = ui_x - 245;
var name_y = ui_y;
	
var default_col = c_white;
	
var name = Player_GetName();
var col_name = c_white;
	
var lv = Player_GetLv();
var col_lv = c_white;
var col_lv_counter = c_white;
	
var hp = global.hp;
var hp_max = global.hp_max;
var kr = global.kr;
	
if kr > hp - 1
	kr = hp - 1;
	
var bar_multiplier = 1.2; // Default multiplier from UNDERTALE
var bar_hp = hp * bar_multiplier;
var bar_hp_max = hp_max * bar_multiplier;
var bar_kr = -(kr * bar_multiplier);

var col_hp = c_yellow;
var col_hp_max = merge_color(c_red, c_maroon, 0.5); // Smh not red :lmao:
var col_kr = c_fuchsia;
	
var hp_text_col = c_white;
var hp_text = "HP";
var kr_text = "KR";

draw_set_font(font_mars_needs_cunnilingus); // Name - LV Font
draw_set_alpha(ui_alpha);
// Name
draw_text_color(name_x, name_y, name, col_name, col_name, col_name, col_name, ui_alpha);
// LV Icon
draw_text_color(name_x + string_width(name), name_y, "   LV ", col_lv, col_lv, col_lv, col_lv, ui_alpha);
// LV Counter
draw_text_color(name_x + string_width(name + "   LV "), name_y, string(lv), col_lv_counter, col_lv_counter, col_lv_counter, col_lv_counter, ui_alpha);

// Background bar
CleanRectangle(hp_x, hp_y, hp_x + bar_hp_max, hp_y + 20)
.Blend(col_hp_max, ui_alpha)
.Draw();
// HP bar
CleanRectangle(hp_x, hp_y, hp_x + bar_hp, hp_y + 20)
.Blend(col_hp, ui_alpha)
.Draw();
	
draw_set_font(font_ut_hp); // Icon Font
// HP Icon
draw_text_color((hp_x - 31), hp_y + 5, hp_text, default_col, default_col, default_col, default_col, ui_alpha);

// KR bar
if global.kr_enable = true
{
	if round(kr) > 0
	{
		hp_text_col = col_kr;
		// Draw the bard
		CleanRectangle(hp_x + (hp * bar_multiplier) + 1, hp_y, (hp_x + (bar_hp + bar_kr)), hp_y + 20)
		.Blend(col_kr, ui_alpha)
		.Draw();
	}
	else hp_text_col = c_white;
		
	// Draw icon
	draw_text_color((hp_x + 10) + (hp_max * bar_multiplier), hp_y + 5, kr_text, hp_text_col, hp_text_col, hp_text_col, hp_text_col, ui_alpha);
}

// Zeropadding
var hp_counter = string(round(hp));
var hp_max_counter = string(round(hp_max));
if round(hp) < 10 hp_counter = "0" + string(round(hp));
if round(hp_max) < 10 hp_max_counter = "0" + string(round(hp_max));

// This line below supports multiple digits for Zeropadding, but I just personally don't like it. 
// var hp_counter = string_replace_all(string_format(round(hp), string_length(string(hp_max)), 0), " ", "0");

// Draw the health counter
draw_set_color(hp_text_col);
draw_set_font(font_mars_needs_cunnilingus); // Counter Font
var offset = global.kr_enable <= false ? 15 : (20 + string_width(kr_text));
draw_text((hp_x + offset) + (hp_max * bar_multiplier), hp_y, hp_counter + " / " + hp_max_counter);

draw_set_alpha(1);
draw_set_color(c_white);
