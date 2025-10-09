///@func Battle_ConvertEnemySlotToMenuChoiceEnemy(enemy_slot)
///@desc Convert the given enemy slot to the menu choice enemy value.
///@param {Real}	enemy_slot		The number of enemy slot (between 0 and 2) to convert.
///@return {Real}
function Battle_ConvertEnemySlotToMenuChoiceEnemy(_enemy_slot) {
	if (instance_exists(Battle_GetEnemy(_enemy_slot)))
	{
		var _result = -1;
		var _i = 0, _j = 0; repeat (3)
		{
			if (instance_exists(Battle_GetEnemy(_i)))
			{
				if (_i == _enemy_slot)
				{
					_result = _j;
					break;
				}
				_j++;
			}
			_i++;
		}
		return _result;
	}
	else
		return -1;
}

///@func Battle_ConvertMenuChoiceEnemyToEnemySlot(menu_choice_enemy)
///@desc Convert the given menu choice enemy value to enemy slot.
///@param {Real}	menu_choice_enemy	The number of menu choice enemy (between 0 and 2).
///@return {Real}
function Battle_ConvertMenuChoiceEnemyToEnemySlot(_menu_choice_enemy) {
	if (_menu_choice_enemy < Battle_GetEnemyNumber())
	{
		var _result = -1;
		var _i = 0, _j = 0; repeat (3)
		{
			if (instance_exists(Battle_GetEnemy(_i)))
			{
				if (_j == _menu_choice_enemy)
				{
					_result = _i;
					break;
				}
				_j++;
			}
			_i++;
		}
		return _result;
	}
	else
		return -1;
}

