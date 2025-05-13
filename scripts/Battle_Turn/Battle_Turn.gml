///@func Battle_IsTurnValid(turn)
///@desc Return whenever the specified turn object/instance id is a valid one.
///@param {Asset.GMObject, Id.Instance}		turn	The turn object/instance id to check whenever it's a valid one.
///@return {Bool}
function Battle_IsTurnValid(_turn) {
	if (!object_exists(_turn) && instance_exists(_turn))
	    _turn = _turn.object_index;
	return (object_exists(_turn)) ? (_turn == obj_battle_turn || object_get_base_parent(_turn) == obj_battle_turn) : false;
}

///@func Battle_GetTurnNumber() 
///@desc Return the current turn number.
///@return {Real}
function Battle_GetTurnNumber() {
	return obj_battle_controller.__turn_number;
}

///@func Battle_SetTurnNumber(turn_number)
///@desc Set the number of the current turn.
///@param {Real}	turn_number		The turn number to set.
function Battle_SetTurnNumber(_turn_number) {
	obj_battle_controller.__turn_number = _turn_number;
}

///@func Battle_GetTurnTime()
///@desc Return the timer value of the turn.
///@return {Real}
function Battle_GetTurnTime() {
	return obj_battle_controller.__turn_time;
}

///@func Battle_SetTurnTime(time)
///@desc Set the timer value of the turn.
///@param {Real}	time	The timer value to set.
function Battle_SetTurnTime(_time) {
	obj_battle_controller.__turn_time = _time;
}

///@func Battle_EndTurn()
///@desc End the currently active turn.
function Battle_EndTurn() {
	if (Battle_GetState() == BATTLE_STATE.IN_TURN)
	{
	    Battle_SetTurnNumber(Battle_GetTurnNumber() + 1);
    
		//var LAST=Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
		//var proc=0;
		//repeat(3){
		//	if(proc!=LAST){
		//		Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_END,proc);
		//	}
		//	proc+=1;
		//}
		
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
	}
}

///@func Battle_GetTurnInfo(turn_info, [val_default])
///@desc Return turn's property base on specified turn info.
///@param {Enum.BATTLE_TURN, Real}	turn_info		The turn info to get the value (base on BATTLE_TURN enum or between 0 and 31).
///@param {Real}					[val_default]	The default value to return in case the specified turn info is not set. (Default: 0)	
///@return {Real}
function Battle_GetTurnInfo(_turn_info, _val_default = 0) {
	return obj_battle_controller.__turn_info[$ _turn_info] ?? _val_default;
}

///@func Battle_SetTurnInfo(turn_info, turn_value)
///@desc Set turn's property base on specified turn info.
///@param {Enum.BATTLE_TURN, Real}	turn_info		The turn info to set the value (base on BATTLE_TURN enum or between 0 and 31).
///@param {Real}					turn_value		The value to set to the specified turn info.
function Battle_SetTurnInfo(_turn_info, _turn_value) {
	obj_battle_controller.__turn_info[$ _turn_info] = _turn_value;
}

///@func Battle_SetTurnPreparationAutoEnd(enabled)
///@desc Enable or disable auto end for Turn Preparation.
///@param {Bool}	enabled		Set to enable (true/on) or disable (false/off) the auto end for Turn Preparation.
function Battle_SetTurnPreparationAutoEnd(_enabled) {
	obj_battle_controller.__dialog_enemy_auto_end = _enabled;
}

///@func Battle_IsTurnPreparationAutoEnd()
///@desc Return whenever the Turn Preparation auto end is enable or not.
///@return {Bool}
function Battle_IsTurnPreparationAutoEnd() {	
	return obj_battle_controller.__dialog_enemy_auto_end;
}

///@func Battle_EndTurnPreparation()
///@desc As the name suggests, end Turn Preparation.
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
	}
}
