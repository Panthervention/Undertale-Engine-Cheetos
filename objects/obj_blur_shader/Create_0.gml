depth = -10000;

blur_resolution_x = display_get_gui_width();
blur_resolution_y = display_get_gui_height();

blur_uni_resolution_hoz = shader_get_uniform(shd_gaussian_horizontal, "resolution");
blur_uni_resolution_vert = shader_get_uniform(shd_gaussian_vertical, "resolution");

blur_uni_amount_hoz = shader_get_uniform(shd_gaussian_vertical, "blur_amount");
blur_uni_amount_vert = shader_get_uniform(shd_gaussian_horizontal, "blur_amount");

blur_intensity = 0;
blur_surf_final = noone;
blur_surf = noone;
