function Battle_IsMenuMercyFleeEnabled() {
	return obj_battle_controller.__menu_mercy_flee_enabled;
}

///@param flee_enabled
function Battle_SetMenuMercyFleeEnabled(ENABLED) {
	obj_battle_controller.__menu_mercy_flee_enabled = ENABLED;
	return true;
}

function Battle_IsFleeable() {
	return obj_battle_controller.__menu_fleeable;
}

///@param fleeable
function Battle_SetFleeable(FLEEABLE) {
	obj_battle_controller.__menu_fleeable = FLEEABLE;
	return true;
}


