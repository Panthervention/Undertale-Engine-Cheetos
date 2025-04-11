/*
	******************************************************************************
	The custom string format for scribble text via obj_textwriter and its children
	BASE FUNCTIONS
	______________________________________________________________________________
	Tag												|		Functionality
	______________________________________________________________________________
	[end]											|		Instantly ends the dialog and destroy the obj_textwriter itself.
													|
	[instant]										|		Skip the typewriter effect to the end of the text instantly.
													|
	[refresh]										|		Refresh the textwriter, is dangerous and need to be used cautiously.
													|
	[visible, bool]									|		Set enable (true) or disable (false) the visibility
													|		of the obj_textwriter (which is the text itself).
													|
	[skippable, bool]								|		Whenever the dialog can be skipped via player input or not.
													|
	[voice, sound, pitch]							|		Set an audio asset as the dialog voice with given pitch.
													|
	[sleep, real]									|		
	[wait, real]									|		Pause the text typewriter effect for the given duration in frame.
	[fdelay, real]									|
													|
	[gui, bool]										|		Whenever the text will be rendered in Draw event or Draw GUI event.
													|
	[depth, real]									|		Set the depth of the obj_textwriter (which is the text itself).
													|
	[portrait, real]								|		Set a sprite as the portrait of the dialog at given image index.
													|
	[portrait_scale, xscale, yscale]				|		Set the scale of the portrait image.
													|
	[portrait_anim, speed, index1, index2, ...]		|		Set a sprite as the portrait of the dialog and then circle around given
													|		specified indexes at given speed value, or one can say... portrait with
													|		talking animation.
													|
	[script, script_name, param1, param2, ...]		|		Execute a function right in the string with the input parameter.
													|		Ex: "[script, Player_Heal, 99]"
													|
	______________________________________________________________________________					
	MISCELLANEOUS FUNCTIONS
	______________________________________________________________________________	
	Tag												|		Functionality
	[sans_head, index]								|		Set the index of sans's face in the battle.
						
	****************************************************************************** 
*/
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
	var _str = $"[typistSoundPerChar,{string_trim(voice)},{string_trim(pitch)},{string_trim(pitch)}, ]";
	return _str;
});

scribble_add_macro("clear", function() {
	var _str = "[/page]";
	return _str;
});

#region [delay, milisecond] alternatives which takes frame instead
var _delay_alternative = function(delay) {
	var _str = "[delay," + string(floor((delay / 60) * 1000)) + "]";
	return _str;
};

scribble_add_macro("sleep", _delay_alternative);
scribble_add_macro("wait", _delay_alternative);
scribble_add_macro("fdelay", _delay_alternative);
#endregion

scribble_typists_add_event("end", textwriter_end);
scribble_typists_add_event("instant", textwriter_skip);
scribble_typists_add_event("refresh", textwriter_refresh);

scribble_typists_add_event("visible", set_visible);
scribble_typists_add_event("skippable", set_skippable);
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

