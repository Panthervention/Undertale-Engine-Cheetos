/* Feather ignore GM2016 */
///@desc Update Text Elements
__info_instruction = $"{Lexicon("menu.instruction.title").Get()}";
for (var _i = 0; _i < 6; _i++)
	__info_instruction += Lexicon($"menu.instruction.line.{_i}").Get();
	
__info_time = Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.TIME);
__info_minute = __info_time div 60;
__info_second = __info_time mod 60;

__info_input_request	= Lexicon("menu.input").Get();
__info_copyright		= Lexicon("copyright", $"2015 - {current_year}", __CHEETOS_ENGINE_VERSION).Get();
__info_begin			= Lexicon("menu.begin").Get();
__info_settings			= Lexicon("menu.settings").Get();
__info_name				= Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.NAME, Lexicon("ui.save.name.empty"));
__info_lv				= $"LV {Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.LV)}";
__info_timer			= $"{__info_minute}:{__info_second < 10 ? "0" : ""}{__info_second}";
__info_room				= $"{Player_GetRoomName(Flag_Get(FLAG_TYPE.INFO, FLAG_INFO.ROOM))}";
__info_continue			= Lexicon("menu.continue").Get();
__info_reset			= Lexicon("menu.reset.default").Get();
__info_naming_title		= Lexicon("menu.naming.title").Get();
__info_quit				= Lexicon("menu.naming.quit").Get();
__info_backspace		= Lexicon("menu.naming.backspace").Get();
__info_done				= Lexicon("menu.naming.done").Get();
__info_nope				= Lexicon("menu.confirm.no").Get();
__info_yeso				= Lexicon("menu.confirm.yes").Get();

__menu_label_naming_title	= scribble(__info_naming_title) .starting_format("font_dt_sans", c_white).transform(2, 2, 0);
__menu_label_confirm_title	= scribble(__confirm_title)		.starting_format("font_dt_sans", c_white).transform(2, 2, 0);
__menu_label_naming_name	= scribble(__naming_name)		.starting_format("font_dt_sans", c_white).transform(__confirm_name_scale, __confirm_name_scale, __confirm_name_angle);

__naming_letter			= ds_grid_create(26, 2);
__naming_letter_x		= ds_grid_create(26, 2);
__naming_letter_y		= ds_grid_create(26, 2);
__naming_letter_shake_x	= ds_grid_create(26, 2);
__naming_letter_shake_y	= ds_grid_create(26, 2);

var	_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var _i = 0; repeat (26)
{
	var _char_x = (_i mod 7) * 64,
	    _char_y = (_i div 7) * 28;

	__naming_letter[# _i, 0] = string_char_at(_letters, _i + 1);
	__naming_letter[# _i, 1] = string_lower(string_char_at(_letters, _i + 1));
	__naming_letter_x[# _i, 0] = 120 + _char_x;
	__naming_letter_x[# _i, 1] = 120 + _char_x;
	__naming_letter_y[# _i, 0] = 152 + _char_y;
	__naming_letter_y[# _i, 1] = 272 + _char_y;
	__naming_letter_shake_x[# _i, 0] = random_range(-1, 1);
	__naming_letter_shake_x[# _i, 1] = random_range(-1, 1);
	__naming_letter_shake_y[# _i, 0] = random_range(-1, 1);
	__naming_letter_shake_y[# _i, 1] = random_range(-1, 1);
	_i++;
}

__setting_label = Lexicon("setting.label").Get();
__setting_exit = Lexicon("setting.exit").Get();
__setting_instruction = Lexicon("setting.instruction").Get();

__setting_label_season = Lexicon("setting.season.label", __season_converted).Get();

__setting_label_language = Lexicon("setting.language.label").Get();
__setting_language = Lexicon("setting.language.option").Get();

__setting_label_mastervolume = Lexicon("setting.mastervolume.label").Get();
 // If data exists, load. Else return 100.
__setting_mastervolume = Flag_Get(FLAG_TYPE.SETTINGS, FLAG_SETTINGS.VOLUME, 100);

__setting_label_border = Lexicon("setting.border.label").Get();
__setting_border_option = [];
 // If data exists, load. Else return 0.
__setting_border = Flag_Get(FLAG_TYPE.SETTINGS, FLAG_SETTINGS.BORDER, 0);
_i = 0; repeat (9)
	array_push(__setting_border_option, Lexicon($"setting.border.option.{_i++}").Get());

