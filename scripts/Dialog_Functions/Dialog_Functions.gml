function Dialog_Init() {
	global._dialog_queue = ds_queue_create();
	return true;
}

function Dialog_Uninit() {
	if (ds_exists(global._dialog_queue, ds_type_queue))
	{
		ds_queue_destroy(global._dialog_queue);
		return true;
	}
	else
		return false;
}

function Dialog_Get() {
	var text = ds_queue_dequeue(global._dialog_queue);
	return (is_string(text) ? text : "");
}

function Dialog_IsEmpty() {
	return ds_queue_empty(global._dialog_queue);
}

///@param text
function Dialog_Add(text) {
	ds_queue_enqueue(global._dialog_queue, text);
	return true;
}

function Dialog_Clear() {
	ds_queue_clear(global._dialog_queue);
	return true;
}

///@param [auto_end]
function Dialog_Start(auto_end = true) {
	if (!instance_exists(obj_ui_dialog) && !Player_IsInBattle())
	{
	    var dialog = instance_create_depth(0, 0, 0, obj_ui_dialog);
		dialog._auto_end = auto_end;
	    return true;
	}
	else
	    return false;
}
