	#region Miscellaneous

///@arg event
///@arg [enemy_slot]
function Battle_CallEnemyEvent(event, enemy = -1) {
	if (enemy == -1)
	{
	    var proc = 0;
	    repeat (3)
	    {
	        var INST = Battle_GetEnemy(proc);
	        if (instance_exists(INST))
	        {
	            with (INST)
	                event_user(event);
	        }
	        proc += 1;
	    }
	    return true;
	}
	else if (Battle_IsEnemySlotValid(enemy))
	{
	    var INST = Battle_GetEnemy(enemy);
	    if (instance_exists(INST))
	    {
	        with (INST)
	            event_user(event);
	    }
	    return true;
	}
	else
	    return false;
}

///@arg enemy_obj/inst
///@arg enemy_slot
function Battle_SetEnemy(enemy, slot) {
	if (Battle_IsEnemySlotValid(slot) && Battle_IsEnemyValid(enemy))
	{
	    Battle_RemoveEnemy(slot);
	    if (!object_exists(enemy) && instance_exists(enemy))
	    {
	        if (enemy == id)
	            enemy = id;
	        var proc = 0;
	        repeat (3)
	        {
	            if (Battle_GetEnemy(proc) == enemy)
	            {
	                Battle_RemoveEnemy(proc);
	                break;
	            }
	            proc += 1;
	        }
	        obj_battle_controller._enemy[slot] = enemy;
	    }
	    if (object_exists(enemy))
	    {
	        obj_battle_controller._enemy[slot] = instance_create_depth(160 * (slot + 1), 240, DEPTH_BATTLE.ENEMY, enemy);
	        Battle_SetEnemyCenterPos(slot, 160 * (slot + 1), 160);
	    }
	    obj_battle_controller._enemy[slot]._enemy_slot = slot;
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.INIT, slot);
	    return true;
	}
	else
	    return false;
}

///@arg enemy_slot
function Battle_GetEnemy(enemy) {
	if (Battle_IsEnemySlotValid(enemy))
	{
	    var inst = obj_battle_controller._enemy[enemy];
	    if (instance_exists(inst))
	        return inst;
	    else
	        return noone;
	}
	else
	    return noone;
}

function Battle_GetEnemyNumber() {
	var num = 0;
	var proc = 0;

	repeat (3)
	{
	    if (instance_exists(Battle_GetEnemy(proc)))
	        num += 1;
	    proc += 1;
	}

	return num;
}

///@arg enemy_slot
function Battle_RemoveEnemy(enemy) {
	if (Battle_IsEnemySlotValid(enemy))
	{
	    var INST = Battle_GetEnemy(enemy);
	    if (instance_exists(INST))
	        INST._enemy_slot = -1;

	    with (obj_battle_controller)
	    {
	        _enemy[enemy] = noone;
	        _enemy_name[enemy] = "";
	        _enemy_spareable[enemy] = false;
	        _enemy_action_number[enemy] = 0;
	        _enemy_action_name[enemy, 0] = "";
	        _enemy_action_name[enemy, 1] = "";
	        _enemy_action_name[enemy, 2] = "";
	        _enemy_action_name[enemy, 3] = "";
	        _enemy_action_name[enemy, 4] = "";
	        _enemy_action_name[enemy, 5] = "";
	        _enemy_center_pos_x[enemy] = 0;
	        _enemy_center_pos_y[enemy] = 0;
	        _enemy_def[enemy] = 0;
	    }
	    return true;
	}
	else
	    return false;
}

///@arg enemy_obj/inst
function Battle_IsEnemyValid(enemy) {
	if (!object_exists(enemy))
	{
	    if (!instance_exists(enemy))
	        enemy = enemy.object_index;
	}

	if (object_exists(enemy))
	{
	    if (enemy == obj_battle_enemy || object_get_base_parent(enemy) == obj_battle_enemy)
	        return true;
	    else
	        return false;
	}
}

///@arg enemy_slot
function Battle_IsEnemySlotValid(enemy) {
	return (enemy >= 0 && enemy <= 2);
}

#endregion

#region Name

///@arg enemy_slot
function Battle_GetEnemyName(enemy) {
	return (instance_exists(Battle_GetEnemy(enemy))) ? obj_battle_controller._enemy_name[enemy] : "";
}

///@arg enemy_slot
///@arg name
function Battle_SetEnemyName(enemy, name) {
	if (instance_exists(Battle_GetEnemy(enemy)))
	{
	    obj_battle_controller._enemy_name[enemy] = name;
	    return true;
	}
	else
	    return false;
}

#endregion

#region Action

///@arg enemy_slot
///@arg action_slot
function Battle_GetEnemyActionName(enemy, action) {
	return (instance_exists(Battle_GetEnemy(enemy)) && action >= 0 && action <= 6)
			? obj_battle_controller._enemy_action_name[enemy, action] : "";
}

///@arg enemy_slot
///@arg action_slot
///@arg text
function Battle_SetEnemyActionName(enemy, action, text) {
	if (instance_exists(Battle_GetEnemy(enemy)) && action >= 0 && action <= 6)
	{
	    obj_battle_controller._enemy_action_name[enemy, action] = text;
	    return true;
	}
	else
	    return false;
}

///@arg enemy_slot
function Battle_GetEnemyActionNumber(enemy) {
	return (instance_exists(Battle_GetEnemy(enemy))) ? obj_battle_controller._enemy_action_number[enemy] : 0;
}

///@arg enemy_slot
///@arg action_number
function Battle_SetEnemyActionNumber(enemy, num) {
	if (instance_exists(Battle_GetEnemy(enemy)) && num >= 0 && num <= 6)
	{
	    obj_battle_controller._enemy_action_number[enemy] = num;
	    return true;
	}
	else
	    return false;
}

#endregion

#region Spareable

///@arg enemy_slot
function Battle_IsEnemySpareable(enemy) {
	return (instance_exists(Battle_GetEnemy(enemy))) ? obj_battle_controller._enemy_spareable[enemy] : false;
}

///@arg enemy_slot
///@arg spareable
function Battle_SetEnemySpareable(enemy, spareable) {
	if (instance_exists(Battle_GetEnemy(enemy)))
	{
	    obj_battle_controller._enemy_spareable[enemy] = spareable;
	    return true;
	}
	else
	    return false;
}

#endregion

#region Center Position

///@arg enemy_slot
///@arg x
///@arg y
function Battle_SetEnemyCenterPos(enemy, X, Y) {
	if (instance_exists(Battle_GetEnemy(enemy)))
	{
	    obj_battle_controller._enemy_center_pos_x[enemy] = X;
	    obj_battle_controller._enemy_center_pos_y[enemy] = Y;
	    return true;
	}
	else
	    return false;
}

///@arg enemy_slot
function Battle_GetEnemyCenterPosX(enemy) {
	return (instance_exists(Battle_GetEnemy(enemy))) ? obj_battle_controller._enemy_center_pos_x[enemy] : 0;
}

///@arg enemy_slot
function Battle_GetEnemyCenterPosY(enemy) {
	return (instance_exists(Battle_GetEnemy(enemy))) ? obj_battle_controller._enemy_center_pos_y[enemy] : 0;
}

#endregion

#region Def

///@arg enemy_slot
function Battle_GetEnemyDEF(enemy) {
	return (instance_exists(Battle_GetEnemy(enemy))) ? obj_battle_controller._enemy_def[enemy] : 0;
}


///@arg enemy_slot
///@arg def
function Battle_SetEnemyDEF(enemy, def) {
	if (instance_exists(Battle_GetEnemy(enemy)))
	{
	    obj_battle_controller._enemy_def[enemy] = def;
	    return true;
	}
	else
	    return false;
}

#endregion
