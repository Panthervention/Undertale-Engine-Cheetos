depth = -10000;

blur_resolution_x = display_get_gui_width();
blur_resolution_y = display_get_gui_height();
blur_iteration_max = 4;

blur_intensity = 0;
blur_intensity_max = 1;
blur_surf_final = application_surface;

kawase = new Kawase(blur_resolution_x, blur_resolution_y, blur_iteration_max);
