///@param turn_obj/inst
function Battle_IsTurnValid(turn) {
	if (!object_exists(turn) && instance_exists(turn))
	    turn = turn.object_index;
	if (object_exists(turn))
	    return (turn == obj_battle_turn || object_get_base_parent(turn) == obj_battle_turn);
	else
	    return false;
}

function Battle_GetTurnNumber() {
	return obj_battle_controller.__turn_number;
}

///@param turn_number
function Battle_SetTurnNumber(turn_number) {
	obj_battle_controller.__turn_number = turn_number;
	return true;
}

function Battle_GetTurnTime() {
	return obj_battle_controller.__turn_time;
}

///@param time
function Battle_SetTurnTime(time) {
	obj_battle_controller.__turn_time = time;
	return true;
}

function Battle_EndTurn() {
	if (Battle_GetState() == BATTLE_STATE.IN_TURN)
	{
	    Battle_SetTurnNumber(Battle_GetTurnNumber() + 1);
    
	    /* var LAST=Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
			var proc=0;
			repeat(3){
				if(proc!=LAST){
					Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_END,proc);
				}
				proc+=1;
			}*/
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_END);
    
	    if (instance_exists(obj_battle_turn))
	    {
	        with (obj_battle_turn)
	            event_user(BATTLE_TURN_EVENT.TURN_END);
	    }
    
	    if (instance_exists(obj_battle_bullet))
	    {
	        with (obj_battle_bullet)
	            event_user(BATTLE_BULLET_EVENT.TURN_END);
	    }
    
	    Battle_GotoNextState();
	    return true;
	}
	else
	    return false;
}

///@param info
///@param [default]
function Battle_GetTurnInfo(INFO, DEFAULT = 0) {
	return obj_battle_controller.__turn_info[$ INFO] ?? DEFAULT;
}

///@param info
///@param value
function Battle_SetTurnInfo(INFO, VALUE) {
	obj_battle_controller.__turn_info[$ INFO] = VALUE;
	return true;
}

///@param enabled
function Battle_SetTurnPreparationAutoEnd(enabled) {
	obj_battle_controller.__dialog_enemy_auto_end = enabled;
	return true;
}

function Battle_IsTurnPreparationAutoEnd() {	
	return obj_battle_controller.__dialog_enemy_auto_end;
}

function Battle_EndTurnPreparation() {
	if (Battle_GetState() == BATTLE_STATE.TURN_PREPARATION)
	{
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_PREPARATION_END);
	    if (instance_exists(obj_battle_turn))
	    {
	        with (obj_battle_turn)
	            event_user(BATTLE_TURN_EVENT.TURN_PREPARATION_END);
	    }
	    Battle_GotoNextState();
	    return true;
	}
	else
	    return false;
}
