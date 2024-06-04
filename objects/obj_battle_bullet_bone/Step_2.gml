event_inherited();

var cam = view_camera[0];
var view_x = camera_get_view_x(cam);
var view_y = camera_get_view_y(cam);
var view_w = camera_get_view_width(cam);
var view_h = camera_get_view_height(cam);

if (!destroyable) exit;

if (point_in_rectangle(x, y, view_x, view_y, view_w, view_h) && !destroy)
	destroy = true;
if (!point_in_rectangle(x, y, view_x, view_y, view_w, view_h) && destroy)
	instance_destroy();
