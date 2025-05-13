#region Most basic bone function
///@func Bullet_Bone(x, y, length, hspeed, vspeed, [type], [mask], [mode], [angle], [rotate], [auto_destroy], [duration])
///@desc Create a bone.
///@param {Real}	x					The x coordinate the bone will be created at.
///@param {Real}	y					The y coordinate the bone will be created at.
///@param {Real}	length				The length of the bone (in pixel).
///@param {Real}	hspeed				The horizontal speed of the bone.
///@param {Real}	vspeed				The vertical speed of the bone.
///@param {Real}	[type]				The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]				Whenever the bone will only be drawn within the board or not. (Default: true)
///@param {Real}	[mode]				The operation mode of the bone. (Default: 0)
///@param {Real}	[angle]				The initial angle of the bone. (Default: 90)
///@param {Real}	[rotate]			The rotation speed of the bone. (Default: 0)
///@param {Bool}	[auto_destroy]		Whenever the bone will automatically destroy itself if it goes outside the screen or not. (Default: true)
///@param {Real}	[duration]			The duration the bone will stay before getting destroyed. (Default: -1)
///@return {Id.Instance<obj_battle_bullet_bone>}
function Bullet_Bone(_x, _y, _length, _hspeed, _vspeed, _type = 0, _mask = true, _mode = 0, _angle = 90, _rotate = 0, _auto_destroy = true, _duration = -1)
{
	var _depth = DEPTH_BATTLE.BULLET_MID;
	
	var _bone = instance_create_depth(_x, _y, _depth, obj_battle_bullet_bone);
	with (_bone)
	{
		x = _x;
		y = _y;
		depth = _depth;
		hspeed = _hspeed;
		vspeed = _vspeed;
		image_angle = _angle;
		
		length = _length;
		rotate = _rotate;
		type = _type;
		duration = _duration;
		mode = _mode;
		out = !_mask;
		
		destroyable = _auto_destroy;
	}
	return _bone;
}
#endregion

#region Stick to board's side
///@func Bullet_BoneTop(x, length, hspeed, [type], [mask], [rotate], [auto_destroy], [duration])
///@desc Create a bone at the top side of the board.
///@param {Real}	x					The x coordinate the bone will be created at.
///@param {Real}	length				The length of the bone (in pixel).
///@param {Real}	hspeed				The horizontal speed of the bone.
///@param {Real}	[type]				The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]				Whenever the bone will only be drawn within the board or not. (Default: true)
///@param {Real}	[rotate]			The rotation speed of the bone. (Default: 0)
///@param {Bool}	[auto_destroy]		Whenever the bone will automatically destroy itself if it goes outside the screen or not. (Default: true)
///@param {Real}	[duration]			The duration the bone will stay before getting destroyed. (Default: -1)
///@return {Id.Instance<obj_battle_bullet_bone>}
function Bullet_BoneTop(_x, _length, _hspeed, _type = 0, _mask = true, _rotate = 0, _auto_destroy = true, _duration = -1)
{
	var _y = (obj_battle_board.y - obj_battle_board.up) + (_length / 2),
		_vspeed = 0,
		_angle = 90,
		_mode = 0;
	return Bullet_Bone(_x, _y, _length, _hspeed, _vspeed, _type, _mask, _mode, _angle, _rotate, _auto_destroy, _duration);
}

///@func Bullet_BoneBottom(x, length, hspeed, [type], [mask], [rotate], [auto_destroy], [duration])
///@desc Create a bone at the bottom side of the board.
///@param {Real}	x					The x coordinate the bone will be created at.
///@param {Real}	length				The length of the bone (in pixel).
///@param {Real}	hspeed				The horizontal speed of the bone.
///@param {Real}	[type]				The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]				Whenever the bone will only be drawn within the board or not. (Default: true)
///@param {Real}	[rotate]			The rotation speed of the bone. (Default: 0)
///@param {Bool}	[auto_destroy]		Whenever the bone will automatically destroy itself if it goes outside the screen or not. (Default: true)
///@param {Real}	[duration]			The duration the bone will stay before getting destroyed. (Default: -1)
///@return {Id.Instance<obj_battle_bullet_bone>}
function Bullet_BoneBottom(_x, _length, _hspeed, _type = 0, _mask = true, _rotate = 0, _auto_destroy = true, _duration = -1)
{	var _y = (obj_battle_board.y + obj_battle_board.down) - (_length / 2),
		_vspeed = 0,
		_angle = 90,
		_mode = 0;
	return Bullet_Bone(_x, _y, _length, _hspeed, _vspeed, _type, _mask, _mode, _angle, _rotate, _auto_destroy, _duration);
}

///@func Bullet_BoneLeft(y, length, vspeed, [type], [mask], [rotate], [auto_destroy], [duration])
///@desc Create a bone at the left side of the board.
///@param {Real}	y					The y coordinate the bone will be created at.
///@param {Real}	length				The length of the bone (in pixel).
///@param {Real}	vspeed				The vertical speed of the bone.
///@param {Real}	[type]				The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]				Whenever the bone will only be drawn within the board or not. (Default: true)
///@param {Real}	[rotate]			The rotation speed of the bone. (Default: 0)
///@param {Bool}	[auto_destroy]		Whenever the bone will automatically destroy itself if it goes outside the screen or not. (Default: true)
///@param {Real}	[duration]			The duration the bone will stay before getting destroyed. (Default: -1)
///@return {Id.Instance<obj_battle_bullet_bone>}
function Bullet_BoneLeft(_y, _length, _vspeed, _type = 0, _mask = true, _rotate = 0, _auto_destroy = true, _duration = -1)
{
	var _x = (obj_battle_board.x - obj_battle_board.left) + (_length / 2),
		_hspeed = 0,
		_angle = 0,
		_mode = 0;
	return Bullet_Bone(_x, _y, _length, _hspeed, _vspeed, _type, _mask, _mode, _angle, _rotate, _auto_destroy, _duration);
}

///@func Bullet_BoneRight(y, length, vspeed, [type], [mask], [rotate], [auto_destroy], [duration])
///@desc Create a bone at the right side of the board.
///@param {Real}	y					The y coordinate the bone will be created at.
///@param {Real}	length				The length of the bone (in pixel).
///@param {Real}	vspeed				The vertical speed of the bone.
///@param {Real}	[type]				The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]				Whenever the bone will only be drawn within the board or not. (Default: true)
///@param {Real}	[rotate]			The rotation speed of the bone. (Default: 0)
///@param {Bool}	[auto_destroy]		Whenever the bone will automatically destroy itself if it goes outside the screen or not. (Default: true)
///@param {Real}	[duration]			The duration the bone will stay before getting destroyed. (Default: -1)
///@return {Id.Instance<obj_battle_bullet_bone>}
function Bullet_BoneRight(_y, _length, _vspeed, _type = 0, _mask = true, _rotate = 0, _auto_destroy = true, _duration = -1)
{
	var _x = (obj_battle_board.x + obj_battle_board.right) - (_length / 2),
		_hspeed = 0,
		_angle = 0,
		_mode = 0;
	return Bullet_Bone(_x, _y, _length, _hspeed, _vspeed, _type, _mask, _mode, _angle, _rotate, _auto_destroy, _duration);
}
#endregion

#region Bone in Sine Wave
///@func Bullet_BoneWaveV(y, x_gap, vspeed, space, amount, gap, amplitude, frequency, [type], [mask])
///@desc Create vertical bone gaps in sine wave pattern.
///@param {Real}	y			The original y coordinate of the wave.
///@param {Real}	x_gap		The base x coordinate of the gap.
///@param {Real}	vspeed		The vertical speed of the bone wave.
///@param {Real}	space		The space between each bone gap.
///@param {Real}	amount		The amount of bone gaps in the wave.
///@param {Real}	gap			The size of the gap (in pixel).
///@param {Real}	amplitude	The amplitude of the bone wave.
///@param {Real}	frequency	The frequency of the bone wave.
///@param {Real}	[type]		The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]		Whenever the bone will only be drawn within the board or not. (Default: true)
///@return {Array<Array<Id.Instance<obj_battle_bullet_bone>>>}
function Bullet_BoneWaveV(_y, _x_gap, _vspeed, _space, _amount, _gap, _amplitude, _frequency, _type = 0, _mask = false)
{
	var _sine = 0,
		_direction = sign(_vspeed),
		_bone = [];
	var _i = 0; repeat (_amount)
	{
		_sine += _frequency;
		_y -= (_space * _direction);
		
		var _x = _x_gap + (sin(_sine) * _amplitude);
		_bone[_i] = Bullet_BoneGapV(_x, _y, _vspeed, _gap, _type, _mask);
		_i++;
	}
	return _bone;
}

///@func Bullet_BoneWaveH(x, y_gap, hspeed, space, amount, gap, amplitude, frequency, [type], [mask])
///@desc Create horizontal bone gaps in sine wave pattern.
///@param {Real}	x			The original x coordinate of the wave.
///@param {Real}	y_gap		The base y coordinate of the gap.
///@param {Real}	hspeed		The horizontal speed of the bone wave.
///@param {Real}	space		The space between each bone gap.
///@param {Real}	amount		The amount of bone gaps in the wave.
///@param {Real}	gap			The size of the gap (in pixel).
///@param {Real}	amplitude	The amplitude of the bone wave.
///@param {Real}	frequency	The frequency of the bone wave.
///@param {Real}	[type]		The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]		Whenever the bone will only be drawn within the board or not. (Default: true)
///@return {Array<Array<Id.Instance<obj_battle_bullet_bone>>>}
function Bullet_BoneWaveH(_x, _y_gap, _hspeed, _space, _amount, _gap, _amplitude, _frequency, _type = 0, _mask = true)
{
	var _sine = 0,
		_direction = sign(_hspeed),
		_bone = [];
	var _i = 0; repeat (_amount)
	{
		_sine += _frequency;
		_x -= (_space * _direction);
		
		var _y = _y_gap + (sin(_sine) * _amplitude);
		_bone[_i] = Bullet_BoneGapH(_x, _y, _hspeed, _gap, _type, _mask);
	}
	return _bone;
}
#endregion

#region Bone Gap
///@func Bullet_BoneGapV(x_gap, y, vspeed, gap, [type], [mask], [auto_destroy], [duration])
///@desc Create a vertical bone gap.
///@param {Real}	x_gap				The base x coordinate of the gap.
///@param {Real}	y					The y coordinate the bone gap will be created at.
///@param {Real}	vspeed				The vertical speed of the bone gap.
///@param {Real}	gap					The size of the gap (in pixel).
///@param {Real}	[type]				The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]				Whenever the bone will only be drawn within the board or not. (Default: true)
///@param {Bool}	[auto_destroy]		Whenever the bone will automatically destroy itself if it goes outside the screen or not. (Default: true)
///@param {Real}	[duration]			The duration the bone will stay before getting destroyed. (Default: -1)
///@return {Array<Id.Instance<obj_battle_bullet_bone>>}
function Bullet_BoneGapV(_x_gap, _y, _vspeed, _gap, _type = 0, _mask = true, _auto_destroy = true, _duration = -1)
{
	var _bone = [],
		_board = obj_battle_board,
		_board_x = _board.x,
		_board_margin = [_board.left, _board.right],
		_x = _gap / 2,
		_length_left = _x_gap - _board_x + _board_margin[0] - _x,
		_length_right = _board_x + _board_margin[1] - _x - _x_gap;
	
	_bone[0] = Bullet_BoneLeft(_y, _length_left, _vspeed, _type, _mask, 0, _auto_destroy, _duration);
	_bone[1] = Bullet_BoneRight(_y, _length_right, _vspeed, _type, _mask, 0, _auto_destroy, _duration);
	return _bone;
}

///@func Bullet_BoneGapH(x, y_gap, hspeed, gap, [type], [mask], [auto_destroy], [duration])
///@desc Create a horizontal bone gap.
///@param {Real}	x					The x coordinate the bone gap will be created at.
///@param {Real}	y_gap				The base y coordinate of the gap.
///@param {Real}	hspeed				The horizontal speed of the bone gap.
///@param {Real}	gap					The size of the gap (in pixel).
///@param {Real}	[type]				The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}	[mask]				Whenever the bone will only be drawn within the board or not. (Default: true)
///@param {Bool}	[auto_destroy]		Whenever the bone will automatically destroy itself if it goes outside the screen or not. (Default: true)
///@param {Real}	[duration]			The duration the bone will stay before getting destroyed. (Default: -1)		
///@return {Array<Id.Instance<obj_battle_bullet_bone>>}
function Bullet_BoneGapH(_x, _y_gap, _hspeed, _gap, _type = 0, _mask = true, _auto_destroy = true, _duration = -1)
{
	var _bone = [],
		_board = obj_battle_board,
		_board_y = _board.y,
		_board_margin = [_board.up, _board.down],
		_y = _gap / 2,
		_length_top = _y_gap - _board_y + _board_margin[0] - _y,
		_length_bottom = _board_y + _board_margin[1] - _y - _y_gap;

	_bone[0] = Bullet_BoneTop(_x, _length_top, _hspeed, _type, _mask, 0, _auto_destroy, _duration);
	_bone[1] = Bullet_BoneBottom(_x, _length_bottom, _hspeed, _type, _mask, 0, _auto_destroy, _duration);
	return _bone;
}
#endregion

#region Bone Wall
///@func Bullet_BoneWall(dir, height, delay, stay, [type], [stab], [warning])
///@desc Create a bone wall at the specified direction of the board.
///@param {Enum.DIR, Real}	dir			The direction of the bone wall (base on DIR enum or either 0, 90, 180 and 270).
///@param {Real}			height		The height of the bone wall.
///@param {Real}			delay		The delay duration until the bone wall stab.
///@param {Real}			stay		The duration which the bone wall stay before going away.
///@param {Real}			[type]		The type (color) of the bone (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Real}			[stab]		The duration it takes for the stabbing/unstabbing animation.
///@param {Bool}			[warning]	Whenever there will be a warning sound or not. (Default: true)
///@return {Id.Instance<obj_battle_bullet_bonewall>}
function Bullet_BoneWall(_direction, _height, _delay_duration, _stay_duration, _type = 0, _stab_duration = 5, _warning_sound = true)
{
	var _depth = DEPTH_BATTLE.BULLET_MID;
	
	var _wall = instance_create_depth(0, 0, _depth, obj_battle_bullet_bonewall);
	with (_wall)
	{
		dir = _direction;
		target_height = _height;
		time_warn = _delay_duration;
		time_stay = _stay_duration;
		time_stab = _stab_duration;
		type = _type;
		sound_warn = _warning_sound;
	}	
	return _wall;
}
#endregion
