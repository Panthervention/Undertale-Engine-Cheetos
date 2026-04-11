// Drawing the board's background and frame surface
Battle_BoardMaskSet(true, false);

// Board's background rendering
var _angle = __transfer_angle,
	_color = __transfer_color,
	_alpha = __transfer_alpha,
	_fx = __frame_x,
	_fy = __frame_y,
	_fw = __frame_width,
	_fh = __frame_height;

draw_sprite_ext(spr_pixel, 0, __bg_x, __bg_y, __bg_width, __bg_height, _angle, __transfer_bg_c, __transfer_bg_a);

// Board's frame rendering
draw_sprite_ext(spr_pixel, 0, _fx[0], _fy[0], _fw[0], _fh[0], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _fx[1], _fy[1], _fw[1], _fh[1], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _fx[2], _fy[2], _fw[2], _fh[2], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _fx[3], _fy[3], _fw[3], _fh[3], _angle, _color, _alpha);

Battle_BoardMaskReset();
