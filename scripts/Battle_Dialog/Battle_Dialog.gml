#region Menu Dialog

///@return {String}
function Battle_GetMenuDialog() {
	return obj_battle_controller.__menu_dialog;
}

///@param {String}	 text
function Battle_SetMenuDialog(text) {
	obj_battle_controller.__menu_dialog = text;
	return true;
}

#endregion

#region Battle Dialog

///@param {String}	[text]
function Battle_SetDialog(_text = "") {
	with (obj_battle_textwriter)
	{
		var _prefix = menu_string_prefix + menu_dialog_prefix;
		text = _prefix + _text;
	}
}

///@param enabled
function Battle_SetDialogAutoEnd(enabled) {
	obj_battle_controller.__dialog_auto_end = enabled;
}

function Battle_IsDialogAutoEnd() {
	return obj_battle_controller.__dialog_auto_end;
}

function Battle_EndDialog() {
	if (Battle_GetState() == BATTLE_STATE.DIALOG)
	{
	    Dialog_Clear();
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.DIALOG_END);
	    Battle_GotoNextState();
	}
}

#endregion
