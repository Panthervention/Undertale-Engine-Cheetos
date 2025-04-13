if (__menu == -1) // Logo
{
	draw_sprite_ext(spr_logo, 0, 320, 240, 2, 2, 0, c_white, 1);
	if (__hint)
	{
		draw_set_format(font_crypt_of_tomorrow, c_gray);
		draw_set_align(fa_center, fa_middle);
	    draw_text_transformed(320, 360, __info_input_request, 2, 2, 0);
		draw_set_align(); // No input >> reset align to default
		draw_set_color(c_white);
	}
}
else if (__menu == 0) // Instruction - Main menu
{
	draw_set_format(font_crypt_of_tomorrow, c_gray);
	draw_set_align(fa_center, fa_middle);
    draw_text_transformed(320, 475, __info_copyright, 2, 2, 0);
	draw_set_align();
	draw_set_color(c_white);
	
	draw_set_format(font_dt_sans, __color_default);
	if (__mode == 0) // Instruction Page
	{
		var _info_instruction_col = __color_instruction,
			_info_begin_col = __choice == 0 ? __color_chosen : __color_default,
			_info_settings_col = __choice == 1 ? __color_chosen : __color_default;
			
		draw_text_transformed_color(170, 40, __info_instruction, 2, 2, 0, _info_instruction_col, _info_instruction_col, _info_instruction_col, _info_instruction_col, 1);
		draw_text_transformed_color(170, 344, __info_begin, 2, 2, 0, _info_begin_col, _info_begin_col, _info_begin_col, _info_begin_col, 1);
		draw_text_transformed_color(170, 384, __info_settings, 2, 2, 0, _info_settings_col, _info_settings_col, _info_settings_col, _info_settings_col, 1);
	}
	else // Main Menu
	{
		// The Ruins Entrance background
		draw_sprite_ext(spr_bg_area_1, 0, 320, -240, 2, 2, 0, c_white, 1);
		
		var _info_continue_col  = __choice == 0 ? __color_chosen : __color_default,
			_info_reset_col		= __choice == 1 ? __color_chosen : __color_default,
			_info_settings_col	= __choice == 2 ? __color_chosen : __color_default;
		draw_text_transformed(140, 124, __info_name, 2, 2, 0);
		draw_text_transformed(308, 124, __info_lv, 2, 2, 0);
		draw_text_transformed(452, 124, __info_timer, 2, 2, 0);
		draw_text_transformed(140, 160, __info_room, 2, 2, 0);
		
		draw_text_transformed_color(170, 210, __info_continue, 2, 2, 0, _info_continue_col, _info_continue_col, _info_continue_col, _info_continue_col, 1);
		draw_text_transformed_color(390, 210, __info_reset, 2, 2, 0, _info_reset_col, _info_reset_col, _info_reset_col, _info_reset_col, 1);
		draw_text_transformed_color(264, 250, __info_settings, 2, 2, 0, _info_settings_col, _info_settings_col, _info_settings_col, _info_settings_col, 1);
	}
	draw_set_color(c_white);
}
else if (__menu == 1)
{
	draw_set_format(font_dt_sans, __color_default);
	__menu_label_naming_title.draw(180, 60);
	
	#region Drawing Alphabet
	var char_index = 0,
	    total_chars = 52; // 26 uppercase + 26 lowercase letters

	repeat (total_chars)
	{
	    var is_uppercase = char_index < 26 ? 0 : 1,
	        local_char_index = char_index - (26 * is_uppercase),
	        draw_x = __naming_letter_x[# local_char_index, is_uppercase],
	        draw_y = __naming_letter_y[# local_char_index, is_uppercase],
	        shake_x = __naming_letter_shake_x[# local_char_index, is_uppercase],
	        shake_y = __naming_letter_shake_y[# local_char_index, is_uppercase],
	        color = __choice_naming == 0 && (__choice_naming_letter - (26 * is_uppercase)) == local_char_index ? __color_chosen : __color_default;

	    var letter = __naming_letter[# local_char_index, is_uppercase];
	    draw_text_transformed_color(draw_x + shake_x, draw_y + shake_y, letter, 2, 2, 0, color, color, color, color, 1);
	    char_index++;
	}
	#endregion

	var _info_quit_col		= __choice_naming != 0 && __choice_naming_command == 0 ? __color_chosen : __color_default,
		_info_backspace_col	= __choice_naming != 0 && __choice_naming_command == 1 ? __color_chosen : __color_default,
		_info_done_col		= __choice_naming != 0 && __choice_naming_command == 2 ? __color_chosen : __color_default;
	draw_text_transformed_color(120, 400, __info_quit, 2, 2, 0, _info_quit_col, _info_quit_col, _info_quit_col, _info_quit_col, 1); 
	draw_text_transformed_color(240, 400, __info_backspace, 2, 2, 0, _info_backspace_col, _info_backspace_col, _info_backspace_col, _info_backspace_col, 1);
	draw_text_transformed_color(440, 400, __info_done, 2, 2, 0, _info_done_col, _info_done_col, _info_done_col, _info_done_col, 1);
	draw_set_color(c_white);
}
else if (__menu == 2)
{
	draw_set_format(font_dt_sans, __color_default);
	__menu_label_confirm_title.draw(180, 60);
	
	var _info_nope_col	= __choice_confirm == 0 ? __color_chosen : __color_default,
		_info_yeso_col	= __confirm_valid ? (__choice_confirm ? __color_chosen : __color_default) : c_dkgray;
	draw_text_transformed_color(146, 400, __info_nope, 2, 2, 0, _info_nope_col, _info_nope_col, _info_nope_col, _info_nope_col, 1);
	draw_text_transformed_color(460, 400, __info_yeso, 2, 2, 0, _info_yeso_col, _info_yeso_col, _info_yeso_col, _info_yeso_col, 1);
	draw_set_color(c_white);
}
else if (__menu == 4) // Settings
{
	// Such emptiness... Maybe you can cook one up?
}

if (__menu >= 1 && __menu <= 3)
	__menu_label_naming_name.transform(__confirm_name_scale, __confirm_name_scale, __confirm_name_angle).draw(__confirm_name_x + __confirm_name_offset_x, __confirm_name_y + __confirm_name_offset_y);
