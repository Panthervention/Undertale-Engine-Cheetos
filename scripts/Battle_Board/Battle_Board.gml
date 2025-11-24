///@func Battle_IsBoardTransforming()
///@desc Return whenever the battle board is resizing or not.
///@return {Bool}
function Battle_IsBoardTransforming() {
	return (instance_exists(obj_battle_board)) ? (TweenExists({target: obj_battle_board})) : false;
}

///@func Battle_SetBoardSize(up, down, left, right, [duration], [ease], [delay])
///@desc Set the size of the battle board (in pixel of course).
///@param {Real}				up				The top side of the board. (Default: 65)
///@param {Real}				down			The bottom side of the board. (Default: 65)
///@param {Real}				left			The left side of the board. (Default: 283)
///@param {Real}				right			The right side of the board. (Default: 283)
///@param {Real}				[duration]		The duration of the transformation in frame. (Default: 25)
///@param {String, Function}	[ease]			The easing string or function for the transformation. (Default: linear)
///@param {Real}				[delay]			The delay before transformation start. (Default: 0)
function Battle_SetBoardSize(_up, _down, _left, _right, _duration = 25, _ease = "", _delay = 0) {
	with (obj_battle_board)
	{
		if (_duration <= 0)
		{ up = _up; down = _up; left = _left; right = _right; }
		else
		{
			var prop = [["up>", _up], ["down>", _down], ["left>", _left], ["right>", _right]],
				i = 0;
			repeat(4)
			{
				TweenFire(id, _ease, 0, off, _delay, _duration, prop[i][0], prop[i][1]);
				i++;
			}
		}
	}
}

///@func Battle_BoardMaskSet([use_texture], [mask_enable])
///@desc Set all further drawing to be (only) visible within the board mask.
///@param {Bool}	[use_texture]	Whenever further drawing includes sprite or just primitive draw functions (like draw_line(), draw_rectangle()...). (Default: false)
///@param {Bool}	[mask_enable]	Whenever further drawing will be masked within the board or not. (Default: true)
function Battle_BoardMaskSet(_use_texture = false, _mask_enable = true) {
	var _mask_shader = shd_clip_mask_primitive;//(!_use_texture) ? shd_clip_mask_primitive : shd_clip_mask_sprite;
	shader_set(_mask_shader);
	var _u_mask = shader_get_sampler_index(_mask_shader, "u_mask"),
		_u_maskEnable = shader_get_uniform(_mask_shader, "u_maskEnable"),
		_u_rect = shader_get_uniform(_mask_shader, "u_rect");
	
	shader_set_uniform_f(_u_rect, 0, 0, 640, 480);
	shader_set_uniform_f(_u_maskEnable, _mask_enable);
	texture_set_stage(_u_mask, surface_get_texture(obj_battle_board.surface_mask));
	//show_debug_message($"shader {shader_get_name(_mask_shader)} is compiled: {shader_is_compiled(_mask_shader)}");
}

///@func Battle_BoardMaskReset()
///@desc Reset all further drawing from specifically within the board mask back to the screen.
function Battle_BoardMaskReset() {
	shader_reset();
}
