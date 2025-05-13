///@func Bullet_Blaster(sprite, x0, y0, angle0, xscale, yscale, x1, y1, angle1, delay, blast, duration, [type], [blur], [sound_charge], [sound_blast])
///@desc Create a (gaster) blaster.
///@param {Asset.GMSprite}		sprite				The sprite of the blaster.
///@param {Real}				x0					The x coordinate the blaster will be created at.
///@param {Real}				y0					The y coordinate the blaster will be created at.
///@param {Real}				angle0				The initial angle of the blaster.
///@param {Real}				xscale				The horizontal scaling of the blaster, as a multiplier.
///@param {Real}				yscale				The vertical scaling of the blaster, as a multiplier.
///@param {Real}				x1					The x coordinate the blaster will move toward to.
///@param {Real}				y1					The y coordinate the blaster will move toward to.
///@param {Real}				angle1				The angle which the blaster will rotate to.
///@param {Real}				[delay]				The delay duration before the blaster blast. (Default: 16)
///@param {Real}				[blast]				The duration the blast stay. (Default: 10)
///@param {Real}				[duration]			The duration it take to move from x/y/angle0 to x/y/angle1. (Default: 30)
///@param {Real}				[type]				The type (color) of the blaster (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}				[blur]				Whenever there will be blur when the blaster blast. (Default: false)
///@param {Bool}				[sound_charge]		Whenever there will be the charging sound of the blaster. (Default: true)
///@param {Bool}				[sound_blast]		Whenever there will be the blasting sound of the blaster. (Default: true)
///@return {Id.Instance<obj_battle_bullet_gb>}
function Bullet_Blaster(_sprite, _x0, _y0, _angle0, _xscale, _yscale, _x1, _y1, _angle1, _delay = 16, _blast = 10, _duration = 30, _type = 0, _blur = false, _snd_charge = true, _snd_blast = true) 
{	
	var _depth = DEPTH_BATTLE.BULLET_HIGH;
	
	var _gb = instance_create_depth(0, 0, _depth, obj_battle_bullet_gb);
	var _blaster = _gb.blaster;
	with (_blaster)
	{
		sprite_index = _sprite;
		x = _x0;
		y = _y0;
		image_angle = _angle0;
		image_xscale = _xscale;
		image_yscale = _yscale;
	}
	with (_gb)
	{
		depth = _depth;
		
		target_x = _x1;
		target_y = _y1;
		target_angle = _angle1;
		
		time_delay = _delay;
		time_blast = _blast;
		time_move = _duration;
		
		type = _type;
		
		charge_sound = _snd_charge;
		blast_sound = _snd_blast;
		blurring = _blur;
	}
	return _gb;
}

///@func Bullet_BlasterCircle()
///@desc Create a (gaster) blaster in a circular manner.
///@param {Asset.GMSprite}		sprite				The sprite of the blaster.
///@param {Real}				x					The x coordinate of the circle's center.
///@param {Real}				y					The y coordinate of the circle's center.
///@param {Real}				len_start			The initial distance away from the center.
///@param {Real}				len_end				The target distance away from the center which the blaster will move toward to.
///@param {Real}				dir					The rotation direction (either -1 or 1).
///@param {Real}				angle				The angle in the circle of the blaster.
///@param {Real}				xscale				The horizontal scaling of the blaster, as a multiplier.
///@param {Real}				yscale				The vertical scaling of the blaster, as a multiplier.
///@param {Real}				[delay]				The delay duration before the blaster blast. (Default: 16)
///@param {Real}				[blast]				The duration the blast stay. (Default: 10)
///@param {Real}				[duration]			The duration it take to move from x/y/angle0 to x/y/angle1. (Default: 30)
///@param {Real}				[type]				The type (color) of the blaster (between 0 and 2 which is white, blue and orange respectively). (Default: 0)
///@param {Bool}				[blur]				Whenever there will be blur when the blaster blast. (Default: false)
///@param {Bool}				[sound_charge]		Whenever there will be the charging sound of the blaster. (Default: true)
///@param {Bool}				[sound_blast]		Whenever there will be the blasting sound of the blaster. (Default: true)
///@return {Id.Instance<obj_battle_bullet_gb>}
function Bullet_BlasterCircle(_sprite, _len_x, _len_y, _len0, _len1, _rot, _angle, _xscale, _yscale, _delay = 16, _blast = 10, _duration = 30, _type = 0, _blur = false, _snd_charge = true, _snd_blast = true) 
{
	var _x0 = (_len_x + lengthdir_x(_len0, _angle)),
		_y0 = (_len_y + lengthdir_y(_len0, _angle)),
		_x1 = (_len_x + lengthdir_x(_len1, _angle)),
		_y1 = (_len_y + lengthdir_y(_len1, _angle)),
		_angle0 = point_direction(_x0, _y0, _x1, _y1) - (270 * _rot),
		_angle1 = point_direction(_x0, _y0, _x1, _y1),
		_gb = Bullet_Blaster(_sprite, _x0, _y0, _angle0, _xscale, _yscale, _x1, _y1, _angle1, _delay, _blast, _duration, _type, _blur, _snd_charge, _snd_blast);
	return _gb;
}
