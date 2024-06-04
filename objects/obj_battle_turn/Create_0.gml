Battle_SetTurnInfo(BATTLE_TURN.TIME, -1);
proceed = false;
timer = 0;
turn = Battle_GetTurnNumber();
if (instance_exists(obj_battle_soul))
{
    obj_battle_soul.visible = false;
    obj_battle_soul.moveable = false;
}


