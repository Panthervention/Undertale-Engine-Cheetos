function Battle_SetSansAction(_action)
{
	with (obj_battle_enemy_sans)
	{
		action = _action;
		__action_step = 0;
	}
}
