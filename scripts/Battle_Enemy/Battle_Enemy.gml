#region Miscellaneous
///@func Battle_CallEnemyEvent(enemy_event, [enemy_slot])
///@desc Run the actions or code that has been placed within one of the 14 built-in User Event of the enemy object.
///@param {Real}	enemy_event		The BATTLE_ENEMY_EVENT enum or number of event to call (between 0 and 13).
///@param {Real}	[enemy_slot]	The slot of the enemy in the enemy array.
function Battle_CallEnemyEvent(_enemy_event, _enemy_slot = -1) {
	if (_enemy_slot == -1)
	{
	    var _i = 0; repeat (3)
	    {
	        var _enemy_instance = Battle_GetEnemy(_i);
	        if (instance_exists(_enemy_instance))
	        {
	            with (_enemy_instance)
	                event_user(_enemy_event);
	        }
	        _i++;
	    }
	}
	else if (Battle_IsEnemySlotValid(_enemy_slot))
	{
	    var _enemy_instance = Battle_GetEnemy(_enemy_slot);
	    if (instance_exists(_enemy_instance))
	    {
	        with (_enemy_instance)
	            event_user(_enemy_event);
	    }
	}
}

///@func Battle_SetEnemy(enemy, enemy_slot)
///@desc Assign enemy's object/id instance to the given slot of the enemy array.
///@param {Asset.GMObject, Id.Instance}		enemy			The enemy object (or id instance of the enemy [NOT RECOMMENDED!]) to assign to the enemy array.
///@param {Real}							enemy_slot		The index of the enemy array to assign.
function Battle_SetEnemy(_enemy, _enemy_slot) {
	if (Battle_IsEnemySlotValid(_enemy_slot) && Battle_IsEnemyValid(_enemy))
	{
	    Battle_RemoveEnemy(_enemy_slot);
		
		// If the enemy is an id instance, check for duplication
		// If it finds that the same instance is already assigned, only the latest call retains the enemy instance
		// But seriously why would you supply id instance?
	    if (!object_exists(_enemy) && instance_exists(_enemy))
	    {
	        var _i = 0; repeat (3)
	        {
	            if (Battle_GetEnemy(_i) == _enemy)
	            {
	                Battle_RemoveEnemy(_i);
	                break;
	            }
	            _i++;
	        }
	        obj_battle_controller.__enemy[_enemy_slot] = _enemy;
	    }
		
	    if (object_exists(_enemy))
	    {
	        obj_battle_controller.__enemy[_enemy_slot] = instance_create_depth(160 * (_enemy_slot + 1), 240, DEPTH_BATTLE.ENEMY, _enemy);
	        Battle_SetEnemyCenterPos(_enemy_slot, 160 * (_enemy_slot + 1), 160);
	    }
	    obj_battle_controller.__enemy[_enemy_slot].__enemy_slot = _enemy_slot;
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.INIT, _enemy_slot);
	}
}

///@func Battle_GetEnemy(enemy_slot)
///@desc Return the instance id of the enemy from the given array index.
///@param {Real}			enemy_slot		The index of the enemy array to get the enemy from.	
///@return {Id.Instance}
function Battle_GetEnemy(_enemy_slot) {
	if (Battle_IsEnemySlotValid(_enemy_slot))
	{
		var _enemy_instance = obj_battle_controller.__enemy[_enemy_slot];
		return (instance_exists(_enemy_instance)) ? _enemy_instance : noone;
	}
	return noone;
}

///@func Battle_GetEnemyNumber()
///@desc Return the amount of enemies.
///@return {Real}
function Battle_GetEnemyNumber() {
	var _i = 0, _n = 0; repeat (3)
	{
	    if (instance_exists(Battle_GetEnemy(_i)))
	        _n++;
	    _i++;
	}

	return _n;
}

///@func Battle_RemoveEnemy(enemy_slot)
///@desc Remove the enemy from the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to remove the desired enemy.
function Battle_RemoveEnemy(_enemy_slot) {
	if (Battle_IsEnemySlotValid(_enemy_slot))
	{
	    var _enemy_instance = Battle_GetEnemy(_enemy_slot);
	    if (instance_exists(_enemy_instance))
	        _enemy_instance.__enemy_slot = -1;

	    with (obj_battle_controller)
	    {
	        __enemy[_enemy_slot] = noone;
	        __enemy_name[_enemy_slot] = "";
	        __enemy_spareable[_enemy_slot] = false;
	        __enemy_action_number[_enemy_slot] = 0;
	        __enemy_action_name[_enemy_slot] = ["", "", "", "", "", ""];
	        __enemy_center_pos_x[_enemy_slot] = 0;
	        __enemy_center_pos_y[_enemy_slot] = 0;
	        __enemy_def[_enemy_slot] = 0;
	    }
	}
}

///@func Battle_IsEnemyValid(enemy)
///@desc Return the validation state of the enemy object.
///@param {Asset.GMObject}	enemy	The (enemy) object that need validation check.  
///@return {Bool}
function Battle_IsEnemyValid(_enemy) {
	if (!object_exists(_enemy))
	{
	    if (!instance_exists(_enemy))
	        _enemy = _enemy.object_index;
	}

	if (object_exists(_enemy))
	    return (_enemy == obj_battle_enemy || object_get_base_parent(_enemy) == obj_battle_enemy);
	
	return false;
}

///@func Battle_IsEnemySlotValid(enemy_slot)
///@desc Return the valiation state of the supplied slot number.
///@param {Real}	enemy_slot		The index of the enemy array to check for validation (between 0 and 2).	
///@return {Bool}
function Battle_IsEnemySlotValid(_enemy_slot) {
	return (_enemy_slot >= 0 && _enemy_slot <= 2);
}
#endregion

#region Name
///@func Battle_GetEnemyName(enemy_slot)
///@desc Return the enemy's name from the chosen index of the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to get the enemy's name.	
///@return {String}
function Battle_GetEnemyName(_enemy_slot) {
	return (instance_exists(Battle_GetEnemy(_enemy_slot))) ? obj_battle_controller.__enemy_name[_enemy_slot] : "";
}

///@func Battle_SetEnemyName(enemy_slot, enemy_name)
///@desc Assign the enemy's name from the chosen index of the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to assign the enemy's name.
///@param {String}	enemy_name		The name you want to set to the enemy.
function Battle_SetEnemyName(_enemy_slot, _enemy_name) {
	if (instance_exists(Battle_GetEnemy(_enemy_slot)))
	    obj_battle_controller.__enemy_name[_enemy_slot] = _enemy_name;
}
#endregion

#region Action
///@func Battle_GetEnemyActionName(enemy_slot, action_slot)
///@desc Return the enemy's action name from given [enemy, action] index.
///@param {Real}	enemy_slot		The index of the enemy array to get the enemy's action array.
///@param {Real}	action_slot		The index of the enemy's action array to get the action name.
///@param {String}
function Battle_GetEnemyActionName(_enemy_slot, _action_slot) {
	return (instance_exists(Battle_GetEnemy(_enemy_slot)) && _action_slot >= 0 && _action_slot <= 5)
			? obj_battle_controller.__enemy_action_name[_enemy_slot, _action_slot] : "";
}

///@func Battle_SetEnemyActionName(enemy_slot, action_slot, action_name)
///@desc Set the action's name for specified [enemy, action] index.
///@param {Real}	enemy_slot		The index of the enemy array to get the enemy's action array.
///@param {Real}	action_slot		The index of the enemy's action array to get the action name (between 0 and 5).
///@param {String}	action_name		The name you want to set to the action.
function Battle_SetEnemyActionName(_enemy_slot, _action_slot, _action_name) {
	if (instance_exists(Battle_GetEnemy(_enemy_slot)) && _action_slot >= 0 && _action_slot <= 5)
	    obj_battle_controller.__enemy_action_name[_enemy_slot, _action_slot] = _action_name;
}

///@func Battle_GetEnemyActionNumber(enemy_slot)
///@desc Return the amount of action from the specified enemy array index.
///@param {Real}	enemy_slot		The index of the enemy array to get the enemy's amount of action.
///@return {Real}
function Battle_GetEnemyActionNumber(_enemy_slot) {
	return (instance_exists(Battle_GetEnemy(_enemy_slot))) ? obj_battle_controller.__enemy_action_number[_enemy_slot] : 0;
}

///@func Battle_SetEnemyActionNumber(enemy_slot, action_number)
///@desc Assign the amount of action for the specified enemy array index.
///@param {Real}	enemy_slot		The index of the enemy array to set the enemy's amount of action (between 1 and 6).
///@param {Real}	action_number	The amount of action you want to set to the enemy.
function Battle_SetEnemyActionNumber(_enemy_slot, _action_number) {
	if (instance_exists(Battle_GetEnemy(_enemy_slot)) && _action_number >= 0 && _action_number <= 6)
	    obj_battle_controller.__enemy_action_number[_enemy_slot] = _action_number;
}
#endregion

#region Spareable
///@func Battle_IsEnemySpareable(enemy_slot)
///@desc Return whenever the enemy at the specified index of the enemy array is spareable.
///@param {Real}	enemy_slot		The index of the enemy array to get the spareability.
///@return {Bool}
function Battle_IsEnemySpareable(_enemy_slot) {
	return (instance_exists(Battle_GetEnemy(_enemy_slot))) ? obj_battle_controller.__enemy_spareable[_enemy_slot] : false;
}

///@func Battle_SetEnemySpareable(enemy_slot, enemy_spareable)
///@desc Set spareability for the enemy at the specified index of the enemy array.
///@param {Real}	enemy_slot			The index of the enemy array to set the spareability.
///@param {Bool}	enemy_spareable		Set to enable (true/on) or disable (false/off) the spareability.
function Battle_SetEnemySpareable(_enemy_slot, _enemy_spareable) {
	if (instance_exists(Battle_GetEnemy(_enemy_slot)))
	    obj_battle_controller.__enemy_spareable[_enemy_slot] = _enemy_spareable;
}
#endregion

#region Center Position
///@func Battle_SetEnemyCenterPos(enemy_slot, x, y)
///@desc Set the center position for the specified index of the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to set the center position.
///@param {Real}	x				The x coordinate of the enemy's center.
///@param {Real}	y				The y coordinate of the enemy's center.
function Battle_SetEnemyCenterPos(_enemy_slot, _x, _y) {
	if (instance_exists(Battle_GetEnemy(_enemy_slot)))
	{
		with (obj_battle_controller)
	    {
			__enemy_center_pos_x[_enemy_slot] = _x;
			__enemy_center_pos_y[_enemy_slot] = _y;
		}
	}
}

///@func Battle_GetEnemyCenterPosX(enemy_slot)
///@desc Return the x coordinate of the center for the specified index of the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to get the x coordinate of the center.
///@return {Real}
function Battle_GetEnemyCenterPosX(_enemy_slot) {
	return (instance_exists(Battle_GetEnemy(_enemy_slot))) ? obj_battle_controller.__enemy_center_pos_x[_enemy_slot] : 0;
}

///@func Battle_GetEnemyCenterPosY(enemy_slot)
///@desc Return the y coordinate of the center for the specified index of the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to get the y coordinate of the center.
///@return {Real}
function Battle_GetEnemyCenterPosY(_enemy_slot) {
	return (instance_exists(Battle_GetEnemy(_enemy_slot))) ? obj_battle_controller.__enemy_center_pos_y[_enemy_slot] : 0;
}
#endregion

#region Def
///@func Battle_GetEnemyDEF(enemy_slot)
///@desc Return the defense value from the specified index of the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to get the defense value.
///@return {Real}
function Battle_GetEnemyDEF(_enemy_slot) {
	return (instance_exists(Battle_GetEnemy(_enemy_slot))) ? obj_battle_controller.__enemy_def[_enemy_slot] : 0;
}

///@func Battle_SetEnemyDEF(enemy_slot, def)
///@desc Set the defense value for the specified index of the enemy array.
///@param {Real}	enemy_slot		The index of the enemy array to set the defense value.
///@param {Real}	def				The defense value you want to set to the enemy.
function Battle_SetEnemyDEF(_enemy_slot, _def) {
	if (instance_exists(Battle_GetEnemy(_enemy_slot)))
	    obj_battle_controller.__enemy_def[_enemy_slot] = _def;
}
#endregion
