function Battle_IsMenuMercyFleeEnabled() {
	return obj_battle_controller._menu_mercy_flee_enabled;
}

///@arg flee_enabled
function Battle_SetMenuMercyFleeEnabled(ENABLED) {
	obj_battle_controller._menu_mercy_flee_enabled = ENABLED;
	return true;
}

function Battle_IsFleeable() {
	return obj_battle_controller._menu_fleeable;
}

///@arg fleeable
function Battle_SetFleeable(FLEEABLE) {
	obj_battle_controller._menu_fleeable = FLEEABLE;
	return true;
}


