blur_surf_final = application_surface;

surface_set_target(kawase.GetSurface());
if (surface_exists(blur_surf_final))
	draw_surface(blur_surf_final, 0, 0);
surface_reset_target();

kawase.Blur(kawase.GetMaxIterations() / 1.28);

// Draw original scene first
draw_surface(blur_surf_final, 0, 0);

// Draw blurred surface with alpha based on the tweened intensity
var _blend_alpha = blur_intensity / blur_intensity_max;
draw_set_alpha(_blend_alpha);
draw_surface(blur_surf, 0, 0);
draw_set_alpha(1); // Reset alpha

