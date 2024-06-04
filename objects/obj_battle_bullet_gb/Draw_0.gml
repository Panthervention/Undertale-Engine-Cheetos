var color = c_white;

if type = 1 color = c_aqua;
if type = 2 color = c_orange;
if type = 3 color = c_red;

var _blaster = [blaster.sprite_index, blaster.image_index, blaster.x, blaster.y, blaster.image_xscale, blaster.image_yscale, blaster.image_angle, blaster.image_alpha];

if (state == 4)
{
	var _beam = [x, y, image_xscale, image_yscale, image_angle, image_alpha],
		_len_x = lengthdir_x(20 * _beam[3], _beam[4]),
		_len_y = lengthdir_y(20 * _beam[3], _beam[4]),
		_beam_x = _beam[0] + _len_x,
		_beam_y = _beam[1] + _len_y,
		_beam_sine = _beam[3] * (sin((timer_blast / pi)) / 4),
		_beam_xscale = _beam[2] - _len_x,
		_beam_yscale = _beam[3] + _beam_sine;
	
	draw_sprite_ext(spr_gb_beam, 0, _beam[0], _beam[1], _blaster[4], _beam_yscale, _beam[4], color, _beam[5]);	
	draw_sprite_ext(spr_gb_beam, 1, _beam_x, _beam_y, _beam_xscale, _beam_yscale, _beam[4], color, _beam[5]);
	
	if (global.show_hitbox)
		draw_sprite_ext(spr_gb_beam, 2, _beam[0], _beam[1], _beam[2], _beam[3], _beam[4], c_green, _beam[5] / 4);
}

draw_sprite_ext(_blaster[0], _blaster[1], _blaster[2], _blaster[3], _blaster[4], _blaster[5], _blaster[6], color, _blaster[7]);
