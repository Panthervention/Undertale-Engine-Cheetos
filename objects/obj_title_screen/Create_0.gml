Flag_Load(FLAG_TYPE.INFO);

__hint = 0;
audio_play_sound(snd_logo, 0, false);
TweenFire(id, "", 0, false, 99, 1, "__hint>", 1); // Wait till the [Press Z or Enter]

__fun = 0;

__menu = -1;
__menu_bgm = bgm_title_screen_0;
__mode = file_exists(Flag_GetSavePath(FLAG_TYPE.INFO));

__color_instruction = c_silver;
__color_default = c_white;
__color_chosen = c_yellow;

__choice = 0;
__choice_previous = 0;
__choice_naming = 0;
__choice_naming_letter = 0;
__choice_naming_command = 0;
__choice_confirm = 0;
__choice_setting = 0;

__confirm_title = "";
__confirm_valid = true;

__confirm_name_x = 280;
__confirm_name_y = 110;
__confirm_name_scale = 2;
__confirm_name_angle = 0;
__confirm_name_update = true;

__confirm_name_offset_x = 0;
__confirm_name_offset_y = 0;
__confirm_name_angle = 0;
__confirm_name_update = true;

__naming_name = "";
__naming_length_limit = 6;
__naming_shake_buffer = 0;
__naming_shake_buffer_asign = 1; 

__season = ((current_month % 12) div 3);

var _season_names = ["winter", "spring", "summer", "fall"],
	_season_to_string = _season_names[__season];

__season_converted = Lexicon($"setting.season.{_season_to_string}").Get();
__season_bgm = ((__season == 0) ? bgm_option_winter : ((__season == 2) ? bgm_option_summer : bgm_option_fall));

__tween = 0;
event_user(0); // Initiate text elements
