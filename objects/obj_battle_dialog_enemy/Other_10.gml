var _spike_spr = wide_spike ? spr_battle_dialog_enemy_spike_wide : spr_battle_dialog_enemy_spike;
var _corner_spr = spr_battle_dialog_enemy_corner;

var _corner_width = sprite_get_width(_corner_spr);
var _corner_height = sprite_get_height(_corner_spr);

var _bubble_x = x + left + text_offset_x;
var _bubble_y = y + up + text_offset_y;

var _left_x = _bubble_x - left - _corner_width;
var _right_x = _bubble_x + right + _corner_width;
var _top_y = _bubble_y - up - _corner_height;
var _bottom_y = _bubble_y + down + _corner_height;

var _horizontal_length = left + right;
var _vertical_length = up + down;
var _inner_width = (2 * _corner_width) + left + right - 2;
var _inner_height = (2 * _corner_height) + up + down - 2;

var _border_top_x = _bubble_x - left;
var _border_left_y = _bubble_y - up;
var _border_bottom_y = _bottom_y;
var _border_right_x = _right_x;

// Draw corners
draw_sprite_ext(_corner_spr, 0, _left_x, _top_y, 1, 1, 0, c_white, 1);
draw_sprite_ext(_corner_spr, 0, _left_x, _bottom_y, 1, -1, 0, c_white, 1);
draw_sprite_ext(_corner_spr, 0, _right_x, _top_y, -1, 1, 0, c_white, 1);
draw_sprite_ext(_corner_spr, 0, _right_x, _bottom_y, -1, -1, 0, c_white, 1);

// Draw borders
draw_sprite_ext(spr_pixel, 0, _border_top_x, _top_y, _horizontal_length, 1, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, _left_x, _border_left_y, 1, _vertical_length, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, _border_top_x, _border_bottom_y, _horizontal_length, 1, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, _border_right_x, _border_left_y, 1, _vertical_length, 0, c_black, 1);

// Draw inner area
draw_sprite_ext(spr_pixel, 0, _left_x + 1, _border_left_y, _inner_width, _vertical_length, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, _border_top_x, _top_y + 1, _horizontal_length, _inner_height, 0, c_white, 1);

// Draw spikes if needed
if (show_spike)
{
    switch (dir)
	{
        case DIR.LEFT:
            draw_sprite_ext(_spike_spr, 0, _left_x, _bubble_y, 1, 1, 0, c_white, 1);
            break;
        case DIR.RIGHT:
            draw_sprite_ext(_spike_spr, 0, _right_x, _bubble_y, -1, 1, 0, c_white, 1);
            break;
        case DIR.UP:
            draw_sprite_ext(_spike_spr, 0, _bubble_x, _top_y, 1, 1, 90, c_white, 1);
            break;
        case DIR.DOWN:
            draw_sprite_ext(_spike_spr, 0, _bubble_x, _bottom_y, 1, 1, 90, c_white, 1);
            break;
    }
}

event_inherited();
