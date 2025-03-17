/// @description Game Display
var _display_width = display_get_width(),
	_display_height = display_get_height();

var _window_width = window_get_width(),
	_window_height = window_get_height(),
	_window_width_target = (border_enable ? 960 : 640),
	_window_height_target = (border_enable ? 540 : 480),
	_window_ratio = min(_window_width / _window_width_target, _window_height / _window_height_target);

if (border_enable)
{
	var _border_x = (_window_width - (960 * _window_ratio)) / 2,
		_border_y = (_window_height - (540 * _window_ratio)) / 2;
	display_set_gui_maximize(_window_ratio, _window_ratio, _border_x + (160 * _window_ratio), _border_y + (30 * _window_ratio));
    
	// Previous border sprite
	if (sprite_exists(border_sprite_previous))
		draw_sprite_stretched_ext(border_sprite_previous, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_white, 1);
	else
		draw_sprite_stretched_ext(spr_pixel, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_black, 1);
    
	// If there is currently a border sprite
	// OR the border is the screen itself
	if (sprite_exists(border_sprite))
		draw_sprite_stretched_ext(border_sprite, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_white, border_alpha);   
	else if (border_auto_capture)
	{
		draw_surface_ext(application_surface, _border_x, _border_y, (960 * _window_ratio) / 640, (540 * _window_ratio) / 480, 0, c_white, border_alpha);
		draw_sprite_stretched_ext(spr_border_outline, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_white, border_alpha);
	}
	else
		draw_sprite_stretched_ext(spr_pixel, 0, _border_x, _border_y, 960 * _window_ratio, 540 * _window_ratio, c_black, border_alpha);
    
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

