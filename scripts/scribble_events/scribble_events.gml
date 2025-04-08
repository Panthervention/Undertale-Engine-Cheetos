#region Base Functions
function textwriter_end(_element, _parameter_array, _character_index) {
	instance_destroy(id);
}

function textwriter_skip(_element, _parameter_array, _character_index) {
	text_typist.skip();
	if (option_exist)
		option_typist.skip();
}

function textwriter_refresh(_element, _parameter_array, _character_index) {
	text_writer.refresh();
}

function set_visible(_element, _parameter_array, _character_index) {	
	visible = bool(string_trim(_parameter_array[0]));
}

function set_skippable(_element, _parameter_array, _character_index) {	
	text_skippable = bool(string_trim(_parameter_array[0]));
}

function set_dialog_box(_element, _parameter_array, _character_index) {
	dialog_box = bool(string_trim(_parameter_array[0]));
}

function set_text_gui(_element, _parameter_array, _character_index) {
	gui = bool(string_trim(_parameter_array[0]));
}

function set_text_depth(_element, _parameter_array, _character_index) {
	depth = real(string_trim(_parameter_array[0]));
}

function set_portrait(_element, _parameter_array, _character_index) {
	var parameter = [];
	for (var i = 0, n = array_length(_parameter_array); i < n; i++)
		parameter[i] = string_trim(_parameter_array[i]);
	
	portrait = asset_get_index(parameter[0]);
	portrait_index = real(parameter[1]);
}

function set_portrait_scale(_element, _parameter_array, _character_index) {
	var parameter = [];
	for (var i = 0, n = array_length(_parameter_array); i < n; i++)
		parameter[i] = string_trim(_parameter_array[i]);
	portrait_xscale = real(parameter[0]);
	portrait_yscale = real(parameter[1]);
}

function set_portrait_anim(_element, _parameter_array, _character_index) {
	var parameter = [];
	for (var i = 0, n = array_length(_parameter_array); i < n; i++)
		parameter[i] = string_trim(_parameter_array[i]);
	
	portrait = asset_get_index(parameter[0]);
	portrait_speed = real(parameter[1]);
	for (var i = 2, n = array_length(_parameter_array); i < n; i++)
		array_push(portrait_index_array, parameter[i]);
}



// CANNOT EXECUTE FUNCTIONS THAT ARE DECLARED OUTSIDE SCRIPTS
function method_execute(_element, _parameter_array, _character_index) {
	var parameter = [];
	for (var i = 0, n = array_length(_parameter_array); i < n; i++)
		parameter[i] = string_trim(_parameter_array[i]);
	script_execute_ext(asset_get_index(parameter[0]), parameter, 1);
}

scribble_add_macro("voice", function(voice, pitch) {
	var str = "[typistSoundPerChar," + string_trim(voice) + "," + string_trim(pitch) + "," + string_trim(pitch) + "," + " ]";
	return str;
});

scribble_add_macro("clear", function() {
	var str = "[/page]";
	return str;
});

#region [delay, milisecond] alternatives but it takes frame
var delay_alternative = function(delay) {
	var str = "[delay," + string(floor((delay / 60) * 1000)) + "]";
	return str;
};

scribble_add_macro("sleep", delay_alternative);
scribble_add_macro("wait", delay_alternative);
scribble_add_macro("fdelay", delay_alternative);
#endregion

scribble_typists_add_event("end", textwriter_end);
scribble_typists_add_event("instant", textwriter_skip);
scribble_typists_add_event("refresh", textwriter_refresh);

scribble_typists_add_event("visible", set_visible);
scribble_typists_add_event("skippable", set_skippable);
scribble_typists_add_event("dialog_box", set_dialog_box);
scribble_typists_add_event("gui", set_text_gui);
scribble_typists_add_event("depth", set_text_depth);

scribble_typists_add_event("portrait", set_portrait);
scribble_typists_add_event("portrait_scale", set_portrait_scale);
scribble_typists_add_event("portrait_anim", set_portrait_anim);

scribble_typists_add_event("script", method_execute);
#endregion

#region Misc Functions
function set_sans_expression(_element, _parameter_array, _character_index) {	
	obj_battle_enemy_sans.__head_image = real(string_trim(_parameter_array[0]));
}

scribble_typists_add_event("sans_head", set_sans_expression);
#endregion

