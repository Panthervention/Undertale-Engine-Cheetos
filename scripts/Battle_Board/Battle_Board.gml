///@return {Bool}
function Battle_IsBoardTransforming() {
	return (instance_exists(obj_battle_board)) ? (TweenExists({target: obj_battle_board})) : false;
}

///@param {Real}				up
///@param {Real}				own
///@param {Real}				left
///@param {Real}				right
///@param {Real}				[duration]
///@param {String, Function}	[ease]
///@param {Real}				[delay]
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

function Battle_BoardMaskSet(_use_texture = false, _mask_enable = true) {
	var _mask_shader = (!_use_texture) ? shd_clip_mask_primitive : shd_clip_mask_sprite;
	shader_set(_mask_shader);
	var _u_mask = shader_get_sampler_index(_mask_shader, "u_mask"),
		_u_maskEnable = shader_get_uniform(_mask_shader, "u_maskEnable"),
		_u_rect = shader_get_uniform(_mask_shader, "u_rect");
	
	shader_set_uniform_f(_u_rect, 0, 0, 640, 480);
	shader_set_uniform_f(_u_maskEnable, _mask_enable);
	texture_set_stage(_u_mask, surface_get_texture(obj_battle_board.surface_mask));
}

function Battle_BoardMaskReset() {
	shader_reset();
}
