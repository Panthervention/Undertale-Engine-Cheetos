function Battle_SetSansAction(action)
{
	obj_battle_enemy_sans.action = action;
	obj_battle_enemy_sans._action_step=0;
	return true;
}
