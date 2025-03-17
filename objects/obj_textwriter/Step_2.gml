text_wrapwidth = room_width - x;

var input_horizontal = PRESS_HORIZONTAL,
	input_confirm = PRESS_CONFIRM,
	input_cancel = PRESS_CANCEL;

if (sprite_exists(portrait))
{
	var portrait_w = sprite_get_width(portrait);
	text_wrapwidth -= (portrait_w * portrait_xscale);
}

text_writer = scribble(text, string(id));
text_writer.build(true);

var page = text_writer.get_page(),
	pause = text_typist.get_paused(), state = text_typist.get_state(),
	on_last_page = text_writer.on_last_page(), skippable = text_skippable;

if (pause && input_confirm)
	text_typist.unpause();
	
if (skippable && !pause && input_cancel)
	text_typist.skip_to_pause();

// Option Dialog (Dialog Branching)
if (option_exist && state == 1)
{
	if (input_horizontal != 0) // Option switching
	{
		audio_play_sound(snd_menu_switch, 0, false);
		option = posmod(option + PRESS_HORIZONTAL, option_amount);
	}
	else if (input_confirm) // Execute chosen option
	{
		option_exist = false;
		option_event[option]();
	}
}

// Page proceeding
if (state == 1 && !on_last_page)
	text_writer.page(page + 1);

