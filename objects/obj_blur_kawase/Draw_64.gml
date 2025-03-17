blur_surf = kawase.GetSurface();
blur_surf_final = application_surface;

surface_set_target(blur_surf);
if (surface_exists(blur_surf_final))
	draw_surface(blur_surf_final, 0, 0);
surface_reset_target();

kawase.Blur(kawase.GetMaxIterations() / 1.28);

// Draw original scene first
draw_surface(blur_surf_final, 0, 0);

// Draw blurred surface with alpha based on the tweened intensity
var blendAlpha = blur_intensity / blur_intensity_max;
draw_set_alpha(blendAlpha);
draw_surface(blur_surf, 0, 0);
draw_set_alpha(1); // Reset alpha

