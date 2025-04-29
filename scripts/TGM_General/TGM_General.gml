
/// Feather ignore all

#macro fps_average ___fps_average()
/// @ignore
function ___fps_average() {
    static _avg = floor(fps_real);

    // EMA step: move 1/64 toward new sample via >>6
    _avg += (floor(fps_real) - _avg) >> 6;

    // Return the smoothed FPS
    return _avg;
}

/// @desc Returns a boolean (true or false) indicating whether the game was exported as a standalone (executable).
/// @returns {bool} 
function game_is_standalone() {
	static isStandalone = (GM_build_type == "exe");
	return isStandalone;
}

/// @desc Function Description
/// @param {function} callback Description
/// @param {array} args Description
/// @param {real} time Description
/// @param {real} [repetitions]=1 Description
/// @returns {id} Description
function invoke(_callback, _args, _time, _repetitions=1) {
	var _ts = time_source_create(time_source_game, _time, time_source_units_frames, _callback, _args, _repetitions);
	time_source_start(_ts);
	return _ts;
}
