#region Menu Dialog

function Battle_GetMenuDialog() {
	return obj_battle_controller._menu_dialog;
}

///@arg text
function Battle_SetMenuDialog(text) {
	obj_battle_controller._menu_dialog = text;
	return true;
}

#endregion

#region Battle Dialog

///@arg [text]
function Battle_SetDialog(_text = "") {
	with obj_battle_textwriter
	{
		var prefix = menu_string_prefix + menu_dialog_prefix;
		text = prefix + _text;
	}
}

///@arg enabled
function Battle_SetDialogAutoEnd(enabled) {
	obj_battle_controller._dialog_auto_end = enabled;
	return true;
}

function Battle_IsDialogAutoEnd() {
	return obj_battle_controller._dialog_auto_end;
}

function Battle_EndDialog() {
	if (Battle_GetState() == BATTLE_STATE.DIALOG)
	{
	    Dialog_Clear();
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.DIALOG_END);
	    Battle_GotoNextState();
	    return true;
	}
	else
	    return false;
}

#endregion
