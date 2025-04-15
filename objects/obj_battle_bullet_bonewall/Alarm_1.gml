if (time_warn > 0)
{
	warn_color = (warn_color == c_red) ? c_yellow : c_red;
	warn_alpha_filled = (warn_alpha_filled == 0.5) ? 0.25 : 0.5;
	alarm[1] = 5;
}
