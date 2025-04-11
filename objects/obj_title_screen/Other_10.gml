/* Feather ignore all */
///@desc Update Text Elements
__info_instruction = $"{lexicon_text("menu.instruction.title")}";
for (var _i = 0; _i < 6; _i++)
	__info_instruction += lexicon_text($"menu.instruction.line.{_i}");
	
__info_time = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.TIME);
__info_minute = __info_time div 60;
__info_second = __info_time mod 60;

__info_input_request	= lexicon_text("menu.input");
__info_copyright		= lexicon_text("copyright", $"2015 - {current_year}", __CHEETOS_ENGINE_VERSION);
__info_begin			= lexicon_text("menu.begin");
__info_settings			= lexicon_text("menu.settings");
__info_name				= Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, lexicon_text("ui.save.name.empty"));
__info_lv				= $"LV {Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.LV)}";
__info_timer			= $"{__info_minute}:{__info_second < 10 ? "0" : ""}{__info_second}";
__info_room				= $"{Player_GetRoomName(Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.ROOM))}";
__info_continue			= lexicon_text("menu.continue");
__info_reset			= lexicon_text("menu.reset.default");
__info_naming_title		= lexicon_text("menu.naming.title");
__info_quit				= lexicon_text("menu.naming.quit");
__info_backspace		= lexicon_text("menu.naming.backspace");
__info_done				= lexicon_text("menu.naming.done");
__info_nope				= lexicon_text("menu.confirm.no");
__info_yeso				= lexicon_text("menu.confirm.yes");

__menu_label_naming_title	= scribble(__info_naming_title) .starting_format("font_dt_sans", c_white).transform(2, 2, 0);
__menu_label_confirm_title	= scribble(__confirm_title)		.starting_format("font_dt_sans", c_white).transform(2, 2, 0);
__menu_label_naming_name	= scribble(__naming_name)		.starting_format("font_dt_mono", c_white).transform(__confirm_name_scale, __confirm_name_scale, __confirm_name_angle);

__naming_letter			= ds_grid_create(26, 2);
__naming_letter_x		= ds_grid_create(26, 2);
__naming_letter_y		= ds_grid_create(26, 2);
__naming_letter_shake_x	= ds_grid_create(26, 2);
__naming_letter_shake_y	= ds_grid_create(26, 2);

var	_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var _i = 0; repeat (26)
{
	var _char_count_x = _i mod 7,
	    _char_count_y = _i div 7;

	__naming_letter[# _i, 0] = string_char_at(_letters, _i + 1);
	__naming_letter[# _i, 1] = string_lower_buffer(string_char_at(_letters, _i + 1));
	__naming_letter_x[# _i, 0] = 120 + (_char_count_x * 64);
	__naming_letter_x[# _i, 1] = 120 + (_char_count_x * 64);
	__naming_letter_y[# _i, 0] = 152 + (_char_count_y * 28);
	__naming_letter_y[# _i, 1] = 272 + (_char_count_y * 28);
	__naming_letter_shake_x[# _i, 0] = random_range(-1, 1);
	__naming_letter_shake_x[# _i, 1] = random_range(-1, 1);
	__naming_letter_shake_y[# _i, 0] = random_range(-1, 1);
	__naming_letter_shake_y[# _i, 1] = random_range(-1, 1);
	_i++;
}
