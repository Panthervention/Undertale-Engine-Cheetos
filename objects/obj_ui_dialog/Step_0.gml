if (!_initialized)
{
	_initialized = true;
	if (!Dialog_IsEmpty())
	{
	    x = 60;
		y = (_top ? 30 : 340);

		text = "[scale, 2][font_dt_mono]";
		text += Dialog_Get();
		if (_auto_end)
			text += "[pause][end]";
	}
	else
		instance_destroy();
}
