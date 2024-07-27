// This entire script is dedicated to store events of options from dialogs
// So hopefully you won't need a separate script for that

#region Option Functions (Don't touch without caring taken)
function set_option(_element, _parameter_array, _character_index) {
	if !option_exist
		option_exist = true;
	var index = real(string_trim(_parameter_array[0])),
		left = text_writer.get_glyph_data(_character_index).left,
		middle = (text_writer.get_glyph_data(_character_index).top 
				+ text_writer.get_glyph_data(_character_index).bottom) * 0.5;
	option_x[index] = left;
	option_y[index] = middle; // The initiate top-left is 0 regardless where scribble is called!
	option_amount = max(index + 1, option_amount);
}

// CANNOT EXECUTE FUNCTIONS THAT ARE DECLARED OUTSIDE SCRIPTS
function set_option_event(_element, _parameter_array, _character_index) {
	var parameter = [];
	for (var i = 0, n = array_length(_parameter_array); i < n; i++)
	{
		parameter[i] = string_trim(_parameter_array[i]);
		option_event[i] = asset_get_index(parameter[i]);
	}
}
scribble_typists_add_event("option", set_option);
scribble_typists_add_event("option_event", set_option_event);
#endregion

function option_box_yes() {
	if (!instance_exists(obj_ui_box) && (Item_Count() > 0 || Box_ItemCount(0) > 0))
	{
		instance_create_depth(0, 0, DEPTH_UI.PANEL, obj_ui_box);
		instance_destroy(obj_ui_dialog);
	}
	else
	{
		var rand = irandom(2),
			dialog = lexicon_text($"ui.box.inventory.empty.{rand}");
		Dialog_Add(dialog);
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
