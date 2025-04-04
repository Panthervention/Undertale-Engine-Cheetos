Battle_SetTurnInfo(BATTLE_TURN.TIME, -1);
proceed = false;
timer = 0;
turn = Battle_GetTurnNumber();
with (obj_battle_soul)
{
	visible = false;
	moveable = false;
}
