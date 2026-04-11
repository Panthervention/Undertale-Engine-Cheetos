if (sprite_exists(sprite))
{
    if (__line == 0)
        draw_sprite_ext(sprite, 0, x, y, scale_x, scale_y, 0, c_white, 1);
    else
    {
        if (!surface_exists(__surface))
            __surface = surface_create(640, 480); // Cannot use surface format constant because sprite may have color
        surface_set_target(__surface);
	        draw_clear_alpha(0, 0);
	        draw_sprite_ext(sprite, 0, x, y, scale_x, scale_y, 0, c_white, 1);
        surface_reset_target();
        draw_surface_part(__surface, 0, __line - 2, 640, 480 - (__line - 2), 0, __line - 2);
    }
}
