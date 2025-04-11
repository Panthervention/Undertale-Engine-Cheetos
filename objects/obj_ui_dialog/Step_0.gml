if (!__initialized)
{
	__initialized = true;
	if (!Dialog_IsEmpty())
	{
	    x = 60;
		y = (__top ? 30 : 340);

		text = "[scale, 2][font_dt_mono]";
		text += Dialog_Get();
		if (__auto_end)
			text += "[pause][end]";
	}
	else
		instance_destroy();
}
