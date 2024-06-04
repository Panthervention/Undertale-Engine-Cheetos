if !surface_exists(blur_surf_final)
	blur_surf_final = application_surface;
if !surface_exists(blur_surf)
	blur_surf = surface_create(blur_resolution_x, blur_resolution_x);
	
if (surface_exists(blur_surf_final) && surface_exists(blur_surf))
{
	surface_set_target(blur_surf_final);

	shader_set(shd_gaussian_horizontal);
	shader_set_uniform_f(blur_uni_resolution_hoz, blur_resolution_x, blur_resolution_y);
	shader_set_uniform_f(blur_uni_amount_hoz, blur_intensity);
	draw_surface(blur_surf, 0, 0);
	shader_reset();
		
	surface_reset_target();
		
	shader_set(shd_gaussian_vertical);
	shader_set_uniform_f(blur_uni_resolution_vert, blur_resolution_x, blur_resolution_y);
	shader_set_uniform_f(blur_uni_amount_vert, blur_intensity);
	draw_surface(blur_surf_final, 0, 0);
	shader_reset();
}

	
