///@func Battle_IsMenuMercyFleeEnabled()
///@desc Return whenever the player can access flee ability in the battle.
///@return {Bool}
function Battle_IsMenuMercyFleeEnabled() {
	return obj_battle_controller.__menu_mercy_flee_enabled;
}

///@func Battle_SetMenuMercyFleeEnabled(flee_enabled)
///@desc Enable or disable the accessibility to flee in the battle.
///@param {Bool}	flee_enabled	Set to enable (true/on) or disable (false/off) the accessibility to flee.
function Battle_SetMenuMercyFleeEnabled(_flee_enabled) {
	obj_battle_controller.__menu_mercy_flee_enabled = _flee_enabled;
}

///@func Battle_IsFleeable()
///@desc Return whenever the player can flee in the battle.
///@return {Bool}
function Battle_IsFleeable() {
	return obj_battle_controller.__menu_fleeable;
}

///@func Battle_SetFleeable(fleeable)
///@desc Enable or disable the ability to flee in the battle.
///@param {Bool}	fleeable	Set to enable (true/on) or disable (false/off) the ability to flee.
function Battle_SetFleeable(_fleeable) {
	obj_battle_controller.__menu_fleeable = _fleeable;
}


