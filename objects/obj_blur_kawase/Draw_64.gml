blur_surf = kawase.GetSurface();
blur_surf_final = application_surface;

surface_set_target(blur_surf);
if (surface_exists(blur_surf_final))
	draw_surface(blur_surf_final, 0, 0);
surface_reset_target();

kawase.Blur(kawase.GetMaxIterations() * (blur_intensity / blur_intensity_max));

draw_surface(blur_surf, 0, 0);

