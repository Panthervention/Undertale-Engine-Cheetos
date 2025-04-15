#region Configurable
///@func Battle_SetSoulMode([soul_mode], [effect], [angle])
///@desc Set the mode for the soul (red, blue, ...).
///@param {Real}	[soul_mode]		The mode to set to the soul (Default: SOUL_MODE.RED).
///@param {Bool}	[effect]		Whenever there will be effect when the soul mode is set. (Default: true)
///@param {Real}	[angle]			The angle to set to the soul. (Default: DIR.DOWN)
function Battle_SetSoulMode(_soul = SOUL_MODE.RED, _effect = true, _angle = DIR.DOWN)
{
	var _color = c_red;
	
	switch (_soul)
	{
		case SOUL_MODE.BLUE:	_color = c_blue;		break;
	}
	
	with (obj_battle_soul)
	{
		if (_soul > 0) image_blend = _color;
		
		mode = _soul;
		image_angle = _angle % 360;
		
		fall_spd = 0;
		fall_grav = 0;
		if (_effect)
		{
			effect = true;
			effect_angle = _angle;
			event_perform(ev_alarm, 0);
		}
	}
}

///@func Battle_SetSoulPos(x, y, [effect], [effect_angle])
///@desc Set the position of the soul.
///@param {Real}	x					The x coordinate to set to the soul.
///@param {Real}	y					The y coordinate to set to the soul.
///@param {Bool}	[effect]			Whenever there will be effect when the soul position is set. (Default: true)
///@param {Real}	[effect_angle]		The angle of the effect. (Default: DIR.DOWN)
function Battle_SetSoulPos(X, Y, _effect = true, _effect_angle = DIR.DOWN) 
{
	with obj_battle_soul
	{
		x = X;
		y = Y;
		if _effect 
		{
			effect = true;
			effect_angle = _effect_angle;
			event_perform(ev_alarm, 0);
		}
	}
}

///@func Battle_SoulSlam(direction, [slam_power])
///@desc Execute soul slamming (The animation when the soul get dunked down to a side of the board). 
///@param {Real}	direction		The direction of the slam.
///@param {Real}	[slam_power]	The power of the slam. (Default: base on global.slam_power value)
function Battle_SoulSlam(_dir, _slam_power = global.slam_power)
{
	Battle_SetSoulMode(SOUL_MODE.BLUE, false, _dir);
	with (obj_battle_soul)
	{
		on_ground = false;
		on_ceil = false;
		
		slam = true;
		fall_spd = _slam_power;
	}

	with (obj_battle_enemy_sans)
	{
		if		(_dir == DIR.UP)		action = SANS_ACTION.UP;
		else if (_dir == DIR.DOWN)		action = SANS_ACTION.DOWN;
		else if (_dir == DIR.LEFT)		action = SANS_ACTION.LEFT;
		else if (_dir == DIR.RIGHT)		action = SANS_ACTION.RIGHT;

	    __action_step = 0;
	    alarm[0] = 25;
	}
}

#endregion

#region Better not touch
///@func Battle_IsSoulMoving()
///@desc Return whenever the soul is moving or not.
///@return {Bool}
function Battle_IsSoulMoving()
{
	var _soul = obj_battle_soul,
		_check_moving = [abs(_soul.xprevious - _soul.x),
					     abs(_soul.yprevious - _soul.y)];
		
	return (_check_moving[0] > 0 || _check_moving[1] > 0)
}

///@func Battle_CallSoulEventBulletCollision()
///@desc Execute the User Event 0 (Bullet Collision) of the soul if the bullet object where this function executes is valid.
function Battle_CallSoulEventBulletCollision()
{
	if (Battle_IsBulletValid(id))
	{
	    with (obj_battle_soul)
	        event_user(BATTLE_SOUL_EVENT.BULLET_COLLISION);
	}
}

///@func Battle_CallSoulEventHurt()
///@desc Execute the User Event 1 (Hurt) of the soul (play hurt sound, reset invincibility).
function Battle_CallSoulEventHurt()
{
	with (obj_battle_soul)
	    event_user(BATTLE_SOUL_EVENT.HURT);
}
#endregion
