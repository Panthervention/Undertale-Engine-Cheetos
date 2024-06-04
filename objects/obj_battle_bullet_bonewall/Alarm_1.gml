if type_warn == 1
{
	if time_warn > 0
	{
		warn_color = warn_color == c_red ? c_yellow : c_red;
		warn_alpha_filled = warn_alpha_filled == 0.5 ? 0.25 : 0.5;
		alarm[1] = 5;
	}
}

if type_warn == 2
{
	warn_scale += 0.15;
	if warn_alpha > 0
	{
		warn_alpha -= 0.035;
		alarm[1] = 1;
	}
	else if warn_alpha <= 0 warn_alpha = 0;
}