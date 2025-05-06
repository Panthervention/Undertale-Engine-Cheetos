/*
	******************************************************************************
	This entire script is dedicated to store events of options from dialog,
	so hopefully you won't need a separate script for that.
	Maybe I will rework the dialog system someday, if I have the guts to...
	______________________________________________________________________________
	Tag												|		Functionality
													|
	[option, n]										|		The position of the option number n in the text.
													|		Ex: "[option, 0]Yes          [option, 1]No"
													|
	[option_event, n, n+1]							|		The function event that happens when the option is chosen.
													|		Ex: "[option_event, function1, function2]"
													|		Choosing Yes will execute function 1 and choosing No will execute function2.
	******************************************************************************
*/

#region Option Functions (Don't touch without caring taken)
function set_option(_element, _parameter_array, _character_index) {
	if (!option_exist)
		option_exist = true;
	var _index = real(string_trim(_parameter_array[0])),
		_left = text_writer.get_glyph_data(_character_index).left,
		_middle = (text_writer.get_glyph_data(_character_index).top + text_writer.get_glyph_data(_character_index).bottom) / 2;
	option_x[_index] = _left;
	option_y[_index] = _middle; // The initiate top-left is 0 regardless where scribble is called!
	option_amount = max(_index + 1, option_amount);
}

// CANNOT EXECUTE FUNCTIONS THAT ARE DECLARED OUTSIDE SCRIPTS
function set_option_event(_element, _parameter_array, _character_index) {
	var _parameter = [];
	for (var _i = 0, _n = array_length(_parameter_array); _i < _n; _i++)
	{
		_parameter[_i] = string_trim(_parameter_array[_i]);
		option_event[_i] = asset_get_index(_parameter[_i]);
	}
}
scribble_typists_add_event("option", set_option);
scribble_typists_add_event("option_event", set_option_event);
#endregion

#region Option stuffs
function option_box_yes() {
	if (!instance_exists(obj_ui_box) && (Item_Count() > 0 || Box_ItemCount(0) > 0))
	{
		instance_create_depth(0, 0, DEPTH_UI.PANEL, obj_ui_box);
		instance_destroy(obj_ui_dialog);
	}
	else
	{
		var _rand = irandom(2),
			_dialog = lexicon_text($"ui.box.inventory.empty.{_rand}");
		Dialog_Add(_dialog);
		Dialog_Start();
	}
}

function option_box_no() {
	instance_destroy(obj_ui_dialog);
}

function option_sans_fight_yes() {
	instance_destroy(obj_ui_dialog);
	Encounter_Start(0);
}

function option_sans_fight_nope() {
	text = lexicon_text("overworld.sans.dialog.weary");
}
#endregion
