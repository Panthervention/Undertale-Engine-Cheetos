function Battle_IsBoardTransforming() {
	return (instance_exists(obj_battle_board)) ? (TweenExists({target: obj_battle_board})) : false;
}

///@arg up
///@arg down
///@arg left
///@arg right
///@arg [duration]
///@arg [ease]
///@arg [delay]
function Battle_SetBoardSize(U, D, L, R, duration = 25, ease = "", delay = 0) {
	with obj_battle_board
	{
		if (duration <= 0)
		{ up = U; down = D; left = L; right = R; }
		else
		{
			var prop = [["up>", U], ["down>", D], ["left>", L], ["right>", R]],
				i = 0;
			repeat(4)
			{
				TweenFire(id, ease, 0, off, delay, duration, prop[i][0], prop[i][1]);
				i++;
			}
		}
	}
	return true;
}

function Battle_BoardMaskSet(useTexture = false, maskEnable = 1) {
	var mask_shader = (!useTexture) ? shd_clip_mask_primitive : shd_clip_mask_sprite;
	shader_set(mask_shader);
	var u_mask = shader_get_sampler_index(mask_shader, "u_mask"),
		u_maskEnable = shader_get_uniform(mask_shader, "u_maskEnable"),
		u_rect = shader_get_uniform(mask_shader, "u_rect");
	
	shader_set_uniform_f(u_rect, 0, 0, 640, 480);
	shader_set_uniform_f(u_maskEnable, maskEnable);
	texture_set_stage(u_mask, surface_get_texture(obj_battle_board.surface_mask));
}

function Battle_BoardMaskReset() {
	shader_reset();
}
