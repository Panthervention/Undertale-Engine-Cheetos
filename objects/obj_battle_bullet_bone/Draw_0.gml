var _color = c_white;
if (type == 1) _color = c_aqua;
if (type == 2) _color = c_orange;

var _x = x;
var _y = y;

var _angle = image_angle;
var _alpha = image_alpha;
var _length_hitbox = length > 0 ? (length / 2) - (sprite_get_width(bone_index) / 2) : 0;
var _length_sprite = length / sprite_get_width(bone_index);

image_xscale = _length_hitbox;
image_yscale = 1;

var _xscale = image_xscale;
var _yscale = image_yscale;
			
var _color_outline = _color;
Battle_BoardMaskSet(true, mask);
draw_sprite_ext(bone_index, bone_sub, _x, _y, _length_sprite, 1, _angle, _color, _alpha);
draw_sprite_ext(bone_index_outline, bone_sub, _x, _y, _length_sprite, 1, _angle, _color_outline, _alpha);

if (global.show_hitbox)
	draw_sprite_ext(sprite_index, 0, _x, _y, _xscale, _yscale, _angle, c_green, _alpha / 4);
Battle_BoardMaskReset();