///@desc Update Text Elements
_info_instruction = $"{lexicon_text("menu.instruction.title")}";
for (var i = 0; i < 6; i++)
	_info_instruction += lexicon_text($"menu.instruction.line.{i}");
	
_info_time = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.TIME);
_info_minute = _info_time div 60;
_info_second = _info_time mod 60;

_info_input_request	= lexicon_text("menu.input");
_info_copyright		= lexicon_text("copyright", $"2015 - {current_year}", __CHEETOS_ENGINE_VERSION);
_info_begin			= lexicon_text("menu.begin");
_info_settings		= lexicon_text("menu.settings");
_info_name			= Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, lexicon_text("ui.save.name.empty"));
_info_lv			= $"LV {Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.LV)}";
_info_timer			= $"{_info_minute}:{_info_second < 10 ? "0" : ""}{_info_second}";
_info_room			= $"{Player_GetRoomName(Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.ROOM))}";
_info_continue		= lexicon_text("menu.continue");
_info_reset			= lexicon_text("menu.reset.default");
_info_naming_title	= lexicon_text("menu.naming.title");
_info_quit			= lexicon_text("menu.naming.quit");
_info_backspace		= lexicon_text("menu.naming.backspace");
_info_done			= lexicon_text("menu.naming.done");
_info_nope			= lexicon_text("menu.confirm.no");
_info_yeso			= lexicon_text("menu.confirm.yes");

_menu_label_naming_title	= scribble(_info_naming_title)	.starting_format("font_dt_sans", c_white).transform(2, 2, 0);
_menu_label_confirm_title	= scribble(_confirm_title)		.starting_format("font_dt_sans", c_white).transform(2, 2, 0);
_menu_label_naming_name		= scribble(_naming_name)		.starting_format("font_dt_mono", c_white).transform(_confirm_name_scale, _confirm_name_scale, _confirm_name_angle);

_naming_letter			= ds_grid_create(26, 2);
_naming_letter_x		= ds_grid_create(26, 2);
_naming_letter_y		= ds_grid_create(26, 2);
_naming_letter_shake_x	= ds_grid_create(26, 2);
_naming_letter_shake_y	= ds_grid_create(26, 2);

var	letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ", i = 0;
	
repeat (26)
{
	var char_count_x = i mod 7,
	    char_count_y = i div 7;

	_naming_letter[# i, 0] = string_char_at(letters, i + 1);
	_naming_letter[# i, 1] = string_lower_buffer(string_char_at(letters, i + 1));
	_naming_letter_x[# i, 0] = 120 + (char_count_x * 64);
	_naming_letter_x[# i, 1] = 120 + (char_count_x * 64);
	_naming_letter_y[# i, 0] = 152 + (char_count_y * 28);
	_naming_letter_y[# i, 1] = 272 + (char_count_y * 28);
	_naming_letter_shake_x[# i, 0] = random_range(-1, 1);
	_naming_letter_shake_x[# i, 1] = random_range(-1, 1);
	_naming_letter_shake_y[# i, 0] = random_range(-1, 1);
	_naming_letter_shake_y[# i, 1] = random_range(-1, 1);
	i++;
}
