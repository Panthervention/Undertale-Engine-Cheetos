///@func Battle_SetSansAction(action)
///@desc Set sans's current action.
///@param {Enum.SANS_ACTION, Real}		action		The action to assign (base on SANS_ACTION enum or between -1 to 5).
function Battle_SetSansAction(_action)
{
	with (obj_battle_enemy_sans)
	{
		action = _action;
		__action_step = 0;
	}
}
