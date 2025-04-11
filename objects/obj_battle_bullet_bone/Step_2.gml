event_inherited();

var _cam = view_camera[0],
	_view_x = camera_get_view_x(_cam),
	_view_y = camera_get_view_y(_cam),
	_view_w = camera_get_view_width(_cam),
	_view_h = camera_get_view_height(_cam);

if (!destroyable) exit;

if (point_in_rectangle(x, y, _view_x, _view_y, _view_w, _view_h) && !destroy)
	destroy = true;
if (!point_in_rectangle(x, y, _view_x, _view_y, _view_w, _view_h) && destroy)
	instance_destroy();
