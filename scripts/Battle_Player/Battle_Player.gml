function Battle_GetPlayerTempAtk()
{
	var atk = obj_battle_controller.__player_temp_atk;
	return atk;
}

function Battle_GetPlayerTempDef()
{
	var def = obj_battle_controller.__player_temp_def;
	return def;
}

function Battle_GetPlayerTempSpd()
{
	var spd = obj_battle_controller.__player_temp_spd;
	return spd;
}

function Battle_GetPlayerTempInv()
{
	var inv = obj_battle_controller.__player_temp_inv;
	return inv;
}

///@param atk
function Battle_SetPlayerTempAtk(atk)
{
	obj_battle_controller.__player_temp_atk = atk;
	return true;
}

///@param def
function Battle_SetPlayerTempDef(def)
{
	obj_battle_controller.__player_temp_def = def;
	return true;
}

///@param spd
function Battle_SetPlayerTempSpd(spd)
{
	obj_battle_controller.__player_temp_spd = spd;
	return true;
}

///@param inv
function Battle_SetPlayerTempInv(inv)
{
	obj_battle_controller.__player_temp_inv = inv;
	return true;
}

