#region Board's Attributes calculation
var _angle = image_angle,
	_alpha = image_alpha,
	_color = image_blend;

// Up - Down - Left - Right
var _u = up, _d = down, _l = left, _r = right;

// Frame
var _fx = __frame_x,
	_fy = __frame_y,
	_fw = __frame_width,
	_fh = __frame_height,
	_ft = frame_thickness;

// Board measures (Width - Height)
var	_bg_x = __bg_x,
	_bg_y = __bg_y,
	_bg_w = __bg_width,
	_bg_h = __bg_height,
	_bg_c = bg_color,
	_bg_a = bg_alpha,
	_bg_dw = (_l + _r) + (_ft * 2),
	_bg_dh = (_u + _d) + (_ft * 2);

// Background
__point_xy(x - _l, y - _u);
_bg_x = __point_x;
_bg_y = __point_y;
_bg_w = _l + _r;
_bg_h = _u + _d;

// Up
__point_xy(x - _l - _ft, y - _u - _ft);
_fx[0] = __point_x;
_fy[0] = __point_y;
_fw[0] = _bg_dw;
_fh[0] = _ft;

// Down
__point_xy(x - _l - _ft, y + _d);
_fx[1] = __point_x;
_fy[1] = __point_y;
_fw[1] = _bg_dw;
_fh[1] = _ft;

// Left
__point_xy(x - _l - _ft, y - _u - _ft);
_fx[2] = __point_x;
_fy[2] = __point_y;
_fw[2] = _ft;
_fh[2] = _bg_dh;

// Right
__point_xy(x + _r, y - _u - _ft);
_fx[3] = __point_x;
_fy[3] = __point_y;
_fw[3] = _ft;
_fh[3] = _bg_dh;

__frame_x = _fx;
__frame_y = _fy;
__frame_width = _fw;
__frame_height = _fh;

__bg_x = _bg_x;
__bg_y = _bg_y;
__bg_width = _bg_w;
__bg_height = _bg_h;
bg_color = _bg_c;
bg_alpha = _bg_a;
#endregion

#region Clipping Logic handling
#region Arbitrary Clipping via surface
/*
if (!surface_exists(surface_mask))
    surface_mask = surface_create(640, 480); // surface_mask has surface_r8unorm, so idk if this code would work if readded
	
surface_set_target(surface_mask);
draw_clear(c_black);
gpu_set_blendmode(bm_subtract);

// Cut out shapes out of the mask-surface
draw_sprite_ext(spr_pixel, 0, _bg_x, _bg_y, _bg_w, _bg_h, _angle, c_white, 1);
// 

gpu_set_blendmode(bm_normal);
surface_reset_target();

if (!surface_exists(surface_clip))
	surface_clip = surface_create(640, 480);

// Start drawing
surface_set_target(surface_clip);
draw_clear_alpha(c_black, 0);

// Draw things relative to clip-surface
draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, _bg_c, _bg_a);

/
	This is where you draw everything you want inside the board...
/

//

// Cut out the mask-surface from it
gpu_set_blendmode(bm_subtract);
draw_surface(surface_mask, 0, 0);
gpu_set_blendmode(bm_normal);

// Finish and draw the clip-surface itself
surface_reset_target();
draw_surface(surface_clip, 0, 0);
*/
#endregion

#region Arbitrary Clipping via shader
if (!surface_exists(surface_mask)) {
	var _depth_setting = surface_get_depth_disable();
	surface_depth_disable(true);
    surface_mask = surface_create(640, 480, surface_r8unorm);
	surface_depth_disable(_depth_setting);
}
surface_set_target(surface_mask);
draw_clear(c_black);
// Cut the shape(s) out of the mask-surface
draw_sprite_ext(spr_pixel, 0, _bg_x, _bg_y, _bg_w, _bg_h, _angle, c_red, 1);
surface_reset_target();

__transfer_angle = _angle;
__transfer_bg_c = _bg_c;
__transfer_bg_a = _bg_a;
__transfer_color = _color;
__transfer_alpha = _alpha;
#endregion
#endregion