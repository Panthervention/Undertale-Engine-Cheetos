///@func Battle_GetState()
///@desc Return the current state of the battle.
///@return {Real}
function Battle_GetState() {
    return obj_battle_controller.__state;
}

///@func Battle_SetState(state)
///@desc Set the current state for the battle.
///@param {Enum.BATTLE_STATE, Real}		state		The state to assign for the battle (base on BATTLE_STATE enum or between 0 and 5).
function Battle_SetState(_state) {
    obj_battle_controller.__state = _state;

    switch (_state) {
        case BATTLE_STATE.MENU:
            Battle_SetNextState(BATTLE_STATE.DIALOG);
            Battle_SetMenuChoiceEnemy(0, false);
            Battle_SetMenuChoiceAction(0, false);
            Battle_SetMenu(BATTLE_MENU.BUTTON, false);
            Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_START);
            break;

        case BATTLE_STATE.DIALOG:
            Battle_SetNextState(BATTLE_STATE.TURN_PREPARATION);
            Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.DIALOG_START);
            break;

        case BATTLE_STATE.TURN_PREPARATION:
            Battle_SetNextState(BATTLE_STATE.IN_TURN);
            Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_PREPARATION_START);
            if (instance_exists(obj_battle_turn))
			{
                with (obj_battle_turn)
                    event_user(BATTLE_TURN_EVENT.TURN_PREPARATION_START);
            }
            Battle_SetTurnTime(Battle_GetTurnInfo(BATTLE_TURN.TIME, 0));
			with (obj_battle_soul)
			{
				x = obj_battle_board.x + Battle_GetTurnInfo(BATTLE_TURN.SOUL_X, 0);
				y = obj_battle_board.y + Battle_GetTurnInfo(BATTLE_TURN.SOUL_Y, 0);
			}
            Battle_BoardTransforming("SET");
            break;

        case BATTLE_STATE.IN_TURN:
            Battle_SetNextState(BATTLE_STATE.BOARD_RESETTING);
            Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.TURN_START);
            if (instance_exists(obj_battle_turn))
			{
                with (obj_battle_turn)
                    event_user(BATTLE_TURN_EVENT.TURN_START);
            }
            break;

        case BATTLE_STATE.BOARD_RESETTING:
            Battle_SetNextState(BATTLE_STATE.MENU);
            Battle_BoardTransforming("RESET");
            Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.BOARD_RESETTING_START);
            break;
    }

    return true;
}

///@func Battle_GetNextState()
///@desc Return the next state of the battle.
///@return {Real}
function Battle_GetNextState() {
    return obj_battle_controller.__state_next;
}

///@func Battle_SetNextState(state_next)
///@desc Set the current state for the battle.
///@param {Enum.BATTLE_STATE, Real}		state_next		The next state to assign for the battle (base on BATTLE_STATE enum or between 0 and 5).
function Battle_SetNextState(_state_next) {
    obj_battle_controller.__state_next = _state_next;
}

///@func Battle_GotoNextState()
///@desc Proceed to the next state of the battle.
function Battle_GotoNextState() {
    Battle_SetState(Battle_GetNextState());
}

///@func Battle_BoardTransform(type, old_values, target_values, ease, mode, speed, duration)
///@desc Transforms specified properties of the battle board (either position or size) from their current values to target values.
///@param {String}		type				The type of transformation; "move" for position or any other value for size.
///@param {Array}		old_values			An array of the current property values.
///@param {Array}		target_values		An array of the target property values.
///@param {String}		ease				The easing function to use for the tween.
///@param {Real}		mode				The mode of transformation (e.g., speed-based or fixed duration).
///@param {Real}		speed				The speed factor to use when in speed-based mode.
///@param {Real}		duration			The fixed duration to use when not in speed-based mode.
function Battle_BoardTransform(_type, _old_values, _target_values, _ease, _mode, _speed, _duration)
{
    var _properties = (_type == "move") ? ["x>", "y>"] : ["up>", "down>", "left>", "right>"];
    var _durations = [];

    for (var _i = 0, _j = array_length(_properties); _i < _j; _i++)
        _durations[_i] = (_mode == BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED) ? round(abs((_target_values[_i] - _old_values[_i]) / _speed)) : _duration;

    with (obj_battle_board)
	{
        for (var _i = 0, _j = array_length(_properties); _i < _j; _i++)
            TweenFire(id, _ease, 0, off, 0, _durations[_i], _properties[_i], _target_values[_i]);
    }
}

///@func Battle_BoardTransforming(state_prefix)
///@desc Applies board transformation effects based on the given state prefix.
///		 For the "set" state, it transforms the board to new target coordinates and size, 
///		 while for the "reset" state, it restores the board to its original configuration.
///@param {String}		state_prefix		Specifies the transformation type: "set" for applying new transformations or "reset" for reverting to defaults.
function Battle_BoardTransforming(_state_prefix)
{
	switch (string_lower(_state_prefix))
	{
		case "set":
		    var _move_old     = [obj_battle_board.x, obj_battle_board.y];
		    var _move_target  = [
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_X, BATTLE_BOARD.X),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_Y, BATTLE_BOARD.Y)
                              ];
		    var _size_old     = [obj_battle_board.up, obj_battle_board.down, obj_battle_board.left, obj_battle_board.right];
		    var _size_target  = [
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_UP,   BATTLE_BOARD.UP),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_DOWN, BATTLE_BOARD.DOWN),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_LEFT, BATTLE_BOARD.LEFT),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_RIGHT,BATTLE_BOARD.RIGHT)
                              ];
		    var _move_ease     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_EASE, ""); // Linear easing by default
		    var _move_mode     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var _move_speed    = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_SPEED, 10);
		    var _move_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_DURATION, 30);
		    var _size_ease     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_EASE, ""); // Linear easing by default
		    var _size_mode     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var _size_speed    = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_SPEED, 10);
		    var _size_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_DURATION, 30);
			
		    Battle_BoardTransform("move", _move_old, _move_target, _move_ease, _move_mode, _move_speed, _move_duration);
		    Battle_BoardTransform("size", _size_old, _size_target, _size_ease, _size_mode, _size_speed, _size_duration);
			break;
		
		case "reset":
		    var _move_old     = [obj_battle_board.x, obj_battle_board.y];
		    var _move_target  = [
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_X, BATTLE_BOARD.X),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_Y, BATTLE_BOARD.Y)
                              ];
		    var _size_old     = [obj_battle_board.up, obj_battle_board.down, obj_battle_board.left, obj_battle_board.right];
		    var _size_target  = [
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_UP,   BATTLE_BOARD.UP),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_DOWN, BATTLE_BOARD.DOWN),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_LEFT, BATTLE_BOARD.LEFT),
                                Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_RIGHT,BATTLE_BOARD.RIGHT)
                              ];
		    var _move_ease     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_EASE, ""); // Linear easing by default
		    var _move_mode     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var _move_speed    = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_SPEED, 10);
		    var _move_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_DURATION, 30);
		    var _size_ease     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_EASE, ""); // Linear easing by default
		    var _size_mode     = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var _size_speed    = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_SPEED, 10);
		    var _size_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_DURATION, 30);
		    
		    Battle_BoardTransform("move", _move_old, _move_target, _move_ease, _move_mode, _move_speed, _move_duration);
		    Battle_BoardTransform("size", _size_old, _size_target, _size_ease, _size_mode, _size_speed, _size_duration);
			break;
	}
}