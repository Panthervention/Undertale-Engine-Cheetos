instance_create_depth(320, 320, 0, obj_battle_board);
instance_create_depth(320, 320, 0, obj_battle_soul);

var ENCOUNTER = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.ENCOUNTER);

var proc = 0;
repeat (3)
{
    Battle_SetEnemy(__enemy_object[proc], proc);
    proc += 1;
}

Battle_SetNextState(BATTLE_STATE.MENU);

Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.BATTLE_START);

Battle_GotoNextState();

show_debug_message($"Battle Controller: Battle initialized. Encounter ID {ENCOUNTER}.");
