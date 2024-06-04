var _color = image_blend;
var _angle = image_angle;
var _alpha = image_alpha;

var _frame_x = frame_x;
var _frame_y = frame_y;
var _frame_w = frame_w;
var _frame_h = frame_h;

#region Arbitrary Clipping via surface
/*
if (!surface_exists(surface_mask))
    surface_mask = surface_create(640, 480);
	
surface_set_target(surface_mask);
draw_clear(c_black);
gpu_set_blendmode(bm_subtract);

// Cut out shapes out of the mask-surface
draw_sprite_ext(spr_pixel, 0, bg_x, bg_y, bg_w, bg_h, _angle, c_white, _alpha);
// 

gpu_set_blendmode(bm_normal);
surface_reset_target();

if (!surface_exists(surface_clip))
	surface_clip = surface_create(640, 480);

// Start drawing
surface_set_target(surface_clip);
draw_clear_alpha(c_black, 0);

// Draw things relative to clip-surface
draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, bg_c, bg_a);
Battle_BoardDraw();
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

if (!surface_exists(surface_mask))
    surface_mask = surface_create(640, 480);
else
{
	surface_set_target(surface_mask);
	draw_clear_alpha(c_white, 0);
	// Cut out shapes out of the mask-surface
	draw_sprite_ext(spr_pixel, 0, bg_x, bg_y, bg_w, bg_h, _angle, c_white, _alpha);
	surface_reset_target();
}
Battle_BoardMaskSet(true, false);
draw_sprite_ext(spr_pixel, 0, bg_x, bg_y, bg_w, bg_h, _angle, bg_c, bg_a);
Battle_BoardMaskReset();

#endregion


draw_sprite_ext(spr_pixel, 0, _frame_x[0], _frame_y[0], _frame_w[0], _frame_h[0], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _frame_x[1], _frame_y[1], _frame_w[1], _frame_h[1], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _frame_x[2], _frame_y[2], _frame_w[2], _frame_h[2], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _frame_x[3], _frame_y[3], _frame_w[3], _frame_h[3], _angle, _color, _alpha);

