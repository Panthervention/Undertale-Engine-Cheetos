///@param enemy_slot
function Battle_ConvertEnemySlotToMenuChoiceEnemy(ENEMY) {
	if (instance_exists(Battle_GetEnemy(ENEMY)))
	{
	    var proc = 0;
	    var proc2 = 0;
	    var result = -1;
	    repeat (3)
	    {
	        if (instance_exists(Battle_GetEnemy(proc)))
	        {
	            if (proc == ENEMY)
	            {
	                result = proc2;
	                break;
	            }
	            proc2 += 1;
	        }
	        proc += 1;
	    }
	    return result;
	}
	else
	    return -1;
}

///@param menu_choice_enemy
function Battle_ConvertMenuChoiceEnemyToEnemySlot(CHOICE_ENEMY) {
	if (CHOICE_ENEMY < Battle_GetEnemyNumber())
	{
	    var proc = 0;
	    var proc2 = 0;
	    var result = -1;
	    repeat (3)
	    {
	        if (instance_exists(Battle_GetEnemy(proc)))
	        {
	            if (proc2 == CHOICE_ENEMY)
	            {
	                result = proc;
	                break;
	            }
	            proc2 += 1;
	        }
	        proc += 1;
	    }
	    return result;
	}
	else
	    return -1;
}

