blur_intensity = 0;
if (surface_exists(blur_surf))
	surface_free(blur_surf);
if (TweenExists({target: obj_blur_shader}))
	TweenDestroy({target: obj_blur_shader});
