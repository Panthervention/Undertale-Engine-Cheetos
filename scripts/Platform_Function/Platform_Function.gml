///@func Bullet_Platform(x, y, hspeed, vspeed, lenngth, [mask], [angle], [sticky])
///@param {Real}	x			The x coordinate the platform will be created at.
///@param {Real}	y			The y coordinate the platform will be created at.
///@param {Real}	length		The length of the bone (in pixel).
///@param {Real}	hspeed		The horizontal speed of the platform.
///@param {Real}	vspeed		The vertical speed of the platform.
///@param {Bool}	[mask]		Whenever the platform will only be drawn within the board or not. (Default: true)
///@param {Real}	[angle]		The initial angle of the platform. (Default: 0)
///@param {Bool}	[sticky]	Whenever the platform will be sticky or not (green or pink platform). (Default: true)
///@return {Id.Instance<obj_battle_platform>}
function Bullet_Platform(_x, _y, _length, _hspeed, _vspeed, _mask = true, _angle = 0, _sticky = true)
{
	var _depth = DEPTH_BATTLE.BULLET_LOW;
	
	var _platform = instance_create_depth(_x, _y, _depth, obj_battle_platform)
	with (_platform)
	{
		x = _x;
		y = _y;
		depth = _depth;
		hspeed = _hspeed;
		vspeed = _vspeed;
		image_angle = _angle;
		
		length = _length;
		sticky = _sticky;
		mask = _mask;
	}
	return _platform;
}