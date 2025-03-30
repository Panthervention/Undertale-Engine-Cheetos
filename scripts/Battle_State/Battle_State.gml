function Battle_GetState() {
    return obj_battle_controller.__state;
}

function Battle_SetState(STATE) {
    obj_battle_controller.__state = STATE;

    switch (STATE) {
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
            obj_battle_soul.x = obj_battle_board.x + Battle_GetTurnInfo(BATTLE_TURN.SOUL_X, 0);
            obj_battle_soul.y = obj_battle_board.y + Battle_GetTurnInfo(BATTLE_TURN.SOUL_Y, 0);
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

function Battle_GetNextState() {
    return obj_battle_controller.__state_next;
}

function Battle_SetNextState(next_state) {
    obj_battle_controller.__state_next = next_state;
    return true;
}

function Battle_GotoNextState() {
    var next_state = Battle_GetNextState();
    Battle_SetState(next_state);
}


function Battle_BoardTransform(_type, _old_values, _target_values, _ease, _mode, _speed, _duration)
{
    var properties = (_type == "move") ? ["x>", "y>"] : ["up>", "down>", "left>", "right>"];
    var _durations = [];
    var i;

    for (i = 0; i < array_length_1d(properties); i++)
        _durations[i] = (_mode == BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED) ? round(abs((_target_values[i] - _old_values[i]) / _speed)) : _duration;

    with (obj_battle_board)
	{
        for (i = 0; i < array_length_1d(properties); i++) 
            TweenFire(id, _ease, 0, off, 0, _durations[i], properties[i], _target_values[i]);
    }
}

function Battle_BoardTransforming(state_prefix)
{
	switch (string_lower(state_prefix))
	{
		case "set":
		    var move_old = [obj_battle_board.x, obj_battle_board.y];
		    var move_target = [Battle_GetTurnInfo(BATTLE_TURN.BOARD_X, BATTLE_BOARD.X),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_Y, BATTLE_BOARD.Y)];
		    var size_old = [obj_battle_board.up, obj_battle_board.down, obj_battle_board.left, obj_battle_board.right];
		    var size_target = [Battle_GetTurnInfo(BATTLE_TURN.BOARD_UP, BATTLE_BOARD.UP),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_DOWN, BATTLE_BOARD.DOWN),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_LEFT, BATTLE_BOARD.LEFT),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_RIGHT, BATTLE_BOARD.RIGHT)];
		    var move_ease = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_EASE, ""); // Linear
		    var move_mode = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var move_speed = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_SPEED, 10);
		    var move_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_MOVE_DURATION, 30);
		    var size_ease = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_EASE, ""); // Linear
		    var size_mode = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var size_speed = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_SPEED, 10);
		    var size_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_SIZE_DURATION, 30);
			
		    Battle_BoardTransform("move", move_old, move_target, move_ease, move_mode, move_speed, move_duration);
		    Battle_BoardTransform("size", size_old, size_target, size_ease, size_mode, size_speed, size_duration);
			break;
		
		case "reset":
		    var move_old = [obj_battle_board.x, obj_battle_board.y];
		    var move_target = [Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_X, BATTLE_BOARD.X),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_Y, BATTLE_BOARD.Y)];
		    var size_old = [obj_battle_board.up, obj_battle_board.down, obj_battle_board.left, obj_battle_board.right];
		    var size_target = [Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_UP, BATTLE_BOARD.UP),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_DOWN, BATTLE_BOARD.DOWN),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_LEFT, BATTLE_BOARD.LEFT),
		                       Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_RIGHT, BATTLE_BOARD.RIGHT)];
		    var move_ease = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_EASE, ""); // Linear
		    var move_mode = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var move_speed = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_SPEED, 10);
		    var move_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_MOVE_DURATION, 30);
		    var size_ease = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_EASE, ""); // Linear
		    var size_mode = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_MODE, BATTLE_TURN_BOARD_TRANSFORM_MODE.SPEED);
		    var size_speed = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_SPEED, 10);
		    var size_duration = Battle_GetTurnInfo(BATTLE_TURN.BOARD_RESET_SIZE_DURATION, 30);
		    
			Battle_BoardTransform("move", move_old, move_target, move_ease, move_mode, move_speed, move_duration);
		    Battle_BoardTransform("size", size_old, size_target, size_ease, size_mode, size_speed, size_duration);
			break;
	}
}


