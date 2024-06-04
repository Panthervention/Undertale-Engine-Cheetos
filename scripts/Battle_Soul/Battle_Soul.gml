#region Config these

///@arg soul_mode
///@arg [effect]
///@arg [angle]
function Battle_SetSoulMode(SOUL = SOUL_MODE.RED, EFFECT = true, ANGLE = SOUL_DIR.DOWN)
{
	var color = c_red;
	
	switch SOUL
	{
		case SOUL_MODE.BLUE:	color = c_blue;		break;
	}
	with obj_battle_soul
	{
		if SOUL > 0 image_blend = color;
		
		mode = SOUL;
		image_angle = ANGLE;
		
		fall_spd = 0;
		fall_grav = 0;
		if EFFECT
		{
			effect = true;
			effect_angle = ANGLE;
			event_perform(ev_alarm, 0);
		}
	}
}

///@arg x
///@arg y
///@arg [effect]
///@arg [effect_angle]
function Battle_SetSoulPos(X, Y, EFFECT = true, EFFECT_ANGLE = DIR.DOWN) 
{
	with obj_battle_soul
	{
		x = X;
		y = Y;
		if EFFECT 
		{
			effect = true;
			effect_angle = EFFECT_ANGLE;
			event_perform(ev_alarm, 0);
		}
	}
}

///@arg direction
///@arg [slam_power]
function Battle_SoulSlam(dir, slam_power = global.slam_power) 
{
	Battle_SetSoulMode(SOUL_MODE.BLUE, false, dir);
	with obj_battle_soul
	{
		on_ground = false;
		on_ceil = false;
		
		slam = true;
		fall_spd = slam_power;
	}
	
	var TARGET = obj_battle_enemy_sans;
	with (TARGET)
	{
		if dir == SOUL_DIR.UP     action = SANS_ACTION.UP;
		if dir == SOUL_DIR.DOWN   action = SANS_ACTION.DOWN;
		if dir == SOUL_DIR.LEFT   action = SANS_ACTION.LEFT;
		if dir == SOUL_DIR.RIGHT  action = SANS_ACTION.RIGHT;

	    _action_step = 0;
	    alarm[0] = 25;
	}
}

#endregion

#region Better not touch

function Battle_IsSoulMoving()
{
	var soul = obj_battle_soul,
		is_moving = false,
		check_moving = [abs(soul.xprevious - soul.x),
					    abs(soul.yprevious - soul.y)];
		
	if check_moving[0] > 0 or check_moving[1] > 0 is_moving = true;
	return is_moving;
}

function Battle_CallSoulEventBulletCollision()
{
	if (Battle_IsBulletValid(id))
	{
	    with (obj_battle_soul)
	        event_user(BATTLE_SOUL_EVENT.BULLET_COLLISION);
	    return true;
	}
	else
	    return false;
}

function Battle_CallSoulEventHurt()
{
	with (obj_battle_soul)
	    event_user(BATTLE_SOUL_EVENT.HURT);
	return true;
}

#endregion
