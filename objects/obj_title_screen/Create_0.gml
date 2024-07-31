Player_Load(0)

_hint = 0;
audio_play_sound(snd_logo, 0, false);
TweenFire(id, "", 0, false, 99, 1, "_hint>", 1); // Wait till the [Press Z or Enter]

_menu = -1;
_mode = Flag_Load(FLAG_TYPE.INFO); //registry_exists("SOFTWARE\\" + string(__CHEETOS_GAME_NAME) + "\\" + Flag_GetSavePath(FLAG_TYPE.INFO),Flag_Get(FLAG_TYPE.INFO),"string");

_color_instruction = c_silver;
_color_default = c_white;
_color_chosen = c_yellow;

_choice = 0;
_choice_previous = 0;
_choice_naming = 0;
_choice_naming_letter = 0;
_choice_naming_command = 0;
_choice_confirm = 0;

_confirm_title = "";
_confirm_valid = true;

_confirm_name_x = 280;
_confirm_name_y = 110;
_confirm_name_scale = 2;
_confirm_name_angle = 0;
_confirm_name_update = true;

_confirm_name_offset_x = 0;
_confirm_name_offset_y = 0;
_confirm_name_angle = 0;
_confirm_name_update = true;

_tween_confirm_name_x = noone;
_tween_confirm_name_y = noone;
_tween_confirm_name_scale = noone;

_naming_name = "";
_naming_length_limit = 6;
_naming_shake_buffer = 0;
_naming_shake_buffer_asign = 1; 

event_user(0); // Initiate text elements
