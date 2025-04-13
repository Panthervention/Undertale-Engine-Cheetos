Flag_Load(FLAG_TYPE.INFO);

__hint = 0;
audio_play_sound(snd_logo, 0, false);
TweenFire(id, "", 0, false, 99, 1, "__hint>", 1); // Wait till the [Press Z or Enter]

__menu = -1;
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

__tween_confirm_name_x = noone;
__tween_confirm_name_y = noone;
__tween_confirm_name_scale = noone;

__naming_name = "";
__naming_length_limit = 6;
__naming_shake_buffer = 0;
__naming_shake_buffer_asign = 1; 

event_user(0); // Initiate text elements
