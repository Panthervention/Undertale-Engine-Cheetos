var _color = sticky ? c_lime : c_fuchsia;	
var	_sprite = spr_battle_platform;
var _angle = image_angle;
var _alpha = image_alpha;
var _length = length / 4;

image_xscale = _length;
image_yscale = 1;

var _image_xscale = image_xscale;
var _image_yscale = image_yscale;


var _x = x;
var _y = y;

Battle_BoardMaskSet(true, !out);
draw_sprite_ext(_sprite,0,_x,_y,_image_xscale,_image_yscale,_angle,c_white,_alpha);
draw_sprite_ext(_sprite,1,_x,_y,_image_xscale,_image_yscale,_angle,_color,_alpha);
Battle_BoardMaskReset();
