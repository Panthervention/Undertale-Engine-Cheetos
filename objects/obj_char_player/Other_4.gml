alarm[0] = 1;

var _warp_landmark = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_LANDMARK),
	_warp_dir = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_DIR);

if (_warp_landmark != -1 && instance_exists(obj_hint_landmark))
{
    var _landmark_x = x,
		_landmark_y = y;
    with (obj_hint_landmark)
    {
        if (landmark_id == _warp_landmark)
        {
            _landmark_x = x;
            _landmark_y = y;
        }
    }
    x = _landmark_x;
    y = _landmark_y;
}
if (_warp_dir != -1)
    dir = _warp_dir;

Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_LANDMARK, -1);
Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_DIR, -1);
