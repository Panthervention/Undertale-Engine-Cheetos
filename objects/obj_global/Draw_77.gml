/// @description Game Display
with (border)
{
	var _display_width = display_get_width(),
		_display_height = display_get_height();

	var _window_width = window_get_width(),
		_window_height = window_get_height(),
		_window_width_target = (enable ? 960 : 640),
		_window_height_target = (enable ? 540 : 480),
		_window_ratio = min(_window_width / _window_width_target, _window_height / _window_height_target);

	if (enable)
	{
		var _border_x = (_window_width - (960 * _window_ratio)) / 2,
			_border_y = (_window_height - (540 * _window_ratio)) / 2;
		display_set_gui_maximize(_window_ratio, _window_ratio, _border_x + (160 * _window_ratio), _border_y + (30 * _window_ratio));
    
		// Previous border sprite
		if (sprite_exists(sprite_previous))
			draw_sprite_stretched_ext(sprite_previous, index_previous, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_white, 1);
		else
			draw_sprite_stretched_ext(spr_pixel, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_black, 1);
    
		// If there is currently a border sprite
		// OR the border is the screen itself
		if (sprite_exists(sprite))
			draw_sprite_stretched_ext(sprite, index, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_white, alpha);   
		else if (auto_capture)
		{
			shader_set(shd_gaussian_horizontal);
			shader_set_uniform_f(blur_uni_resolution_hoz, blur_resolution_x, blur_resolution_y);
			shader_set_uniform_f(blur_uni_amount_hoz, blur_intensity);
			draw_surface_ext(application_surface, _border_x, _border_y, (960 * _window_ratio) / 640, (540 * _window_ratio) / 480, 0, c_white, alpha);
			shader_reset();
			
			if (instance_exists(obj_encounter_anim)) then if (obj_encounter_anim.__draw_black)
				draw_sprite_stretched_ext(spr_pixel, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_black, 1);
			
			draw_sprite_stretched_ext(spr_pixel, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, obj_global.fader_color, obj_global.fader_alpha);
			draw_sprite_stretched_ext(spr_pixel, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_black, 1 - (alpha * 0.5));
			draw_sprite_stretched_ext(spr_border, 1, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_white, alpha);
		}
		else
			draw_sprite_stretched_ext(spr_pixel, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_black, alpha);
    
		// Disable blending to avoid unintended behavior
		// (ex: Blaster's beam gets black when fading...)
		gpu_set_blendenable(false);
		draw_surface_ext(application_surface, _border_x + 160 * _window_ratio, _border_y + 30 * _window_ratio, _window_ratio, _window_ratio, 0, c_white, 1);
		gpu_set_blendenable(true); // Re-enable blending for the rest
	}
	else
	{
		display_set_gui_maximize(_window_ratio, _window_ratio, (_window_width - (640 * _window_ratio)) / 2, (_window_height - (480 * _window_ratio)) / 2);
    
		gpu_set_blendenable(false);
		draw_surface_ext(application_surface, (_window_width - (640 * _window_ratio)) / 2, (_window_height - (480 * _window_ratio)) / 2, _window_ratio, _window_ratio, 0, c_white, 1);
		gpu_set_blendenable(true);
	}
}

