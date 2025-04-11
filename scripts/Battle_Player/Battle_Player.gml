///@func Battle_GetPlayerTempAtk()
///@desc Return the temporary ATK (attack) in the battle.
///@return {Real}
function Battle_GetPlayerTempAtk() {
	return obj_battle_controller.__player_temp_atk;
}

///@func Battle_GetPlayerTempDef()
///@desc Return the temporary DEF (defense) in the battle.
///@return {Real}
function Battle_GetPlayerTempDef() {
	return obj_battle_controller.__player_temp_def;
}

///@func Battle_GetPlayerTempSpd()
///@desc Return the temporary SPD (speed) in the battle.
///@return {Real}
function Battle_GetPlayerTempSpd() {
	return obj_battle_controller.__player_temp_spd;
}

///@func Battle_GetPlayerTempInv()
///@desc Return the temporary INV (invincibility) in the battle.
///@return {Real}
function Battle_GetPlayerTempInv() {
	return obj_battle_controller.__player_temp_inv;
}

///@func Battle_SetPlayerTempAtk(atk)
///@desc Set the temporary ATK (attack) in the battle.
///@param {Real}	atk		The amount of ATK (attack) to set.
function Battle_SetPlayerTempAtk(_atk) {
	obj_battle_controller.__player_temp_atk = _atk;
}

///@func Battle_SetPlayerTempDef(def)
///@desc Set the temporary DEF (defense) in the battle.
///@param {Real}	def		The amount of DEF (defense) to set.
function Battle_SetPlayerTempDef(_def) {
	obj_battle_controller.__player_temp_def = _def;
}

///@func Battle_SetPlayerTempSpd(spd)
///@desc Set the temporary SPD (speed) in the battle.
///@param {Real}	spd		The amount of SPD (speed) to set.
function Battle_SetPlayerTempSpd(_spd) {
	obj_battle_controller.__player_temp_spd = _spd;
}

///@func Battle_SetPlayerTempInv(inv)
///@desc Set the temporary INV (invincibility) in the battle.
///@param {Real}	inv		The amount of INV (invincibility) to set.
function Battle_SetPlayerTempInv(_inv) {
	obj_battle_controller.__player_temp_inv = _inv;
}

