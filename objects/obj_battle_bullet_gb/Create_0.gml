event_inherited();
depth = DEPTH_BATTLE.BULLET_HIGH;
dmg = global.beam_dmg;
kr = global.beam_kr;

image_xscale = 800;
image_yscale = 0;

blaster = {
	direction: DIR.DOWN, speed: 0,
	sprite_index: spr_gb, image_index: 0, x: 0, y: 0, image_xscale: 1, image_yscale: 1, image_angle: 0, image_blend: c_white, image_alpha: 1,
};

target_x = 0;
target_y = 0;
target_angle = 0;

state = 0;
timer_move = 0;
timer_blast = 0;
timer_exit = 0;

time_move = 30;
time_pause = 16;
time_blast = 10;
time_stay = 0

charge_sound = 1;
release_sound = 1;
destroy = 0;

function auto_destroy()
{
	var cam = view_camera[0],
		view_x = camera_get_view_x(cam),
		view_y = camera_get_view_y(cam),
		view_w = camera_get_view_width(cam),
		view_h = camera_get_view_height(cam);
	
	var bb_u = sprite_get_bbox_top(blaster.sprite_index),
		bb_d = sprite_get_bbox_bottom(blaster.sprite_index),
		bb_l = sprite_get_bbox_left(blaster.sprite_index),
		bb_r = sprite_get_bbox_right(blaster.sprite_index);
//	if (point_in_rectangle(x, y, view_x - bb_l, view_y - bb_u, view_w + bb_r, view_h + bb_d) && !destroy)
//		destroy = true;
	if (!point_in_rectangle(x, y, view_x - bb_l, view_y - bb_u, view_w + bb_r, view_h + bb_d) && destroy)
	{
		speed = 0;
		if (timer_exit >= time_stay and destroy)
			instance_destroy();
	}	

}

