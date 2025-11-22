// Drawing the board's background and frame surface
Battle_BoardMaskSet(true, false);

// Board's background rendering
var _angle = __step_to_draw._angle,
	_color = __step_to_draw._color,
	_alpha = __step_to_draw._alpha,
	_fx = __step_to_draw._fx,
	_fy = __step_to_draw._fy,
	_fw = __step_to_draw._fw,
	_fh = __step_to_draw._fh;

draw_sprite_ext(spr_pixel, 0, __step_to_draw._bg_x, __step_to_draw._bg_y, __step_to_draw._bg_w, __step_to_draw._bg_h, _angle, __step_to_draw._bg_c, __step_to_draw._bg_a);

// Board's frame rendering
draw_sprite_ext(spr_pixel, 0, _fx[0], _fy[0], _fw[0], _fh[0], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _fx[1], _fy[1], _fw[1], _fh[1], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _fx[2], _fy[2], _fw[2], _fh[2], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _fx[3], _fy[3], _fw[3], _fh[3], _angle, _color, _alpha);

Battle_BoardMaskReset();
