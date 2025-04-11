#region Menu Dialog
///@func Battle_GetMenuDialog()
///@desc Return the current menu dialog.
///@return {String}
function Battle_GetMenuDialog() {
	return obj_battle_controller.__menu_dialog;
}

///@func Battle_SetMenuDialog(text)
///@desc Set specified text string as the menu dialog.
///@param {String}	 text	The text string to set as the menu dialog.
function Battle_SetMenuDialog(_text) {
	obj_battle_controller.__menu_dialog = _text;
}

#endregion

#region Battle Dialog
///@func Battle_SetDialog([text])
///@desc Set specified text string as the menu dialog.
///@param {String}		[text]		The text string to set as the menu dialog.
function Battle_SetDialog(_text = "") {
	with (obj_battle_textwriter)
	{
		var _prefix = menu_string_prefix + menu_dialog_prefix;
		text = _prefix + _text;
	}
}

///@func Battle_SetDialogAutoEnd(enabled)
///@desc Enable or disable auto end of the menu dialog.
///@param {Bool}	enabled		Set to enable (true/on) or disable (false/off) the auto end of the menu dialog.
function Battle_SetDialogAutoEnd(_enabled) {
	obj_battle_controller.__dialog_auto_end = _enabled;
}

///@func Battle_IsDialogAutoEnd()
///@desc Return whenever the menu dialog can auto end or not.
///@return {Bool}
function Battle_IsDialogAutoEnd() {
	return obj_battle_controller.__dialog_auto_end;
}

///@func Battle_EndDialog()
///@desc End the menu dialog.
function Battle_EndDialog() {
	if (Battle_GetState() == BATTLE_STATE.DIALOG)
	{
	    Dialog_Clear();
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.DIALOG_END);
	    Battle_GotoNextState();
	}
}
#endregion
