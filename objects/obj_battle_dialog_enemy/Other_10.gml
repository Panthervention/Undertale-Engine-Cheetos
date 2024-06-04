var spike_spr = wide_spike ? spr_battle_dialog_enemy_spike_wide : spr_battle_dialog_enemy_spike;
var corner_spr = spr_battle_dialog_enemy_corner;

var corner_width = sprite_get_width(corner_spr);
var corner_height = sprite_get_height(corner_spr);

var bubble_x = x + left + text_offset_x;
var bubble_y = y + up + text_offset_y;

var left_x = bubble_x - left - corner_width;
var right_x = bubble_x + right + corner_width;
var top_y = bubble_y - up - corner_height;
var bottom_y = bubble_y + down + corner_height;

var horizontal_length = left + right;
var vertical_length = up + down;
var inner_width = 2 * corner_width + left + right - 2;
var inner_height = 2 * corner_height + up + down - 2;

var border_top_x = bubble_x - left;
var border_left_y = bubble_y - up;
var border_bottom_y = bottom_y;
var border_right_x = right_x;

// Draw corners
draw_sprite_ext(corner_spr, 0, left_x, top_y, 1, 1, 0, c_white, 1);
draw_sprite_ext(corner_spr, 0, left_x, bottom_y, 1, -1, 0, c_white, 1);
draw_sprite_ext(corner_spr, 0, right_x, top_y, -1, 1, 0, c_white, 1);
draw_sprite_ext(corner_spr, 0, right_x, bottom_y, -1, -1, 0, c_white, 1);

// Draw borders
draw_sprite_ext(spr_pixel, 0, border_top_x, top_y, horizontal_length, 1, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, left_x, border_left_y, 1, vertical_length, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, border_top_x, border_bottom_y, horizontal_length, 1, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, border_right_x, border_left_y, 1, vertical_length, 0, c_black, 1);

// Draw inner area
draw_sprite_ext(spr_pixel, 0, left_x + 1, border_left_y, inner_width, vertical_length, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, border_top_x, top_y + 1, horizontal_length, inner_height, 0, c_white, 1);

// Draw spikes if needed
if (show_spike)
{
    switch (dir)
	{
        case DIR.LEFT:
            draw_sprite_ext(spike_spr, 0, left_x, bubble_y, 1, 1, 0, c_white, 1);
            break;
        case DIR.RIGHT:
            draw_sprite_ext(spike_spr, 0, right_x, bubble_y, -1, 1, 0, c_white, 1);
            break;
        case DIR.UP:
            draw_sprite_ext(spike_spr, 0, bubble_x, top_y, 1, 1, 90, c_white, 1);
            break;
        case DIR.DOWN:
            draw_sprite_ext(spike_spr, 0, bubble_x, bottom_y, 1, 1, 90, c_white, 1);
            break;
    }
}

event_inherited();
