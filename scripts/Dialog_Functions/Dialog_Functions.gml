///@func Dialog_Init()
///@desc Initialize the dialog queue.
function Dialog_Init() {
	global.__dialog_queue = ds_queue_create();
}

///@func Dialog_Uninit()
///@desc Uninitialize the dialog queue.
function Dialog_Uninit() {
	if (ds_exists(global.__dialog_queue, ds_type_queue))
		ds_queue_destroy(global.__dialog_queue);
}

///@func Dialog_Get()
///@desc Return the dialog in the queue and dequeue that dialog.
///@return {String}
function Dialog_Get() {
	var _text = ds_queue_dequeue(global.__dialog_queue);
	return (is_string(_text) ? _text : "");
}

///@func Dialog_IsEmpty()
///@desc Return whenever the dialog queue is empty.
///@return {Bool}
function Dialog_IsEmpty() {
	return ds_queue_empty(global.__dialog_queue);
}

///@func Dialog_Add(text)
///@desc Add the text string to the dialog queue.
///@param {String}		text	The text string to add to the dialog queue.
function Dialog_Add(_text) {
	ds_queue_enqueue(global.__dialog_queue, _text);
}

///@func Dialog_Clear()
///@desc Clear the dialog queue.
function Dialog_Clear() {
	ds_queue_clear(global.__dialog_queue);
}

///@func Dialog_Start([auto_end])
///@desc Start displaying the dialog.
///@param {Bool}	[auto_end]		Whenever the dialog will be able to disappear via player confirm input.
function Dialog_Start(_auto_end = true) {
	if (!instance_exists(obj_ui_dialog) && !Player_IsInBattle())
	{
	    var _dialog = instance_create_depth(0, 0, 0, obj_ui_dialog);
		_dialog.__auto_end = _auto_end;
	}
}
