if (__state == 0)
{
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

	if (__soul_shard_render)
	{
		var _i = 0; repeat(6)
		{
			with (__soul_shard[$ _i])
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
			_i++;
		}
	}
}
else if (__state == 1 || __state == 2)
{
	draw_set_font(font_gameover);
	draw_set_align(fa_center, fa_middle);
	draw_text_transformed_color(320, 124, "GAME\nOVER", 2, 2, 0, c_white, c_white, c_white, c_white, image_alpha);
	draw_set_align();
}
