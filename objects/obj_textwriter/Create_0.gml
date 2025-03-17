// Limitation can be coped for now
#region Text functions
text = "";
text_writer = scribble(text, string(id));
text_typist = scribble_typist()
	.in(0.5, 0) // Default speed of Undertale, which is 30 characters/s
	.sound_per_char(snd_text_voice_default, 1, 1, " ");

text_skippable = on;
text_wrapwidth = room_width - x;
#endregion

#region Private properties
// Should be taken with care and caution

gui = false;
if (instance_exists(obj_char_player))
    top = (obj_char_player.y - camera.y > 130 + obj_char_player.sprite_height);
else
	top = false;

#region Portrait
portrait = noone;
portrait_xscale = 1;
portrait_yscale = 1;
portrait_side = PORTRAIT_SIDE.LEFT; // Left (Right side exists but no idea what for atm)

portrait_index = 0;
portrait_index_array = [];
portrait_speed = 0;
enum PORTRAIT_SIDE {
	LEFT,
	RIGHT,
}
#endregion

#region Option Dialog (Dialog Branching)
option_exist = false;
option = 0;
option_x = [];
option_y = [];
option_amount = 0;
option_event = [];
#endregion

#endregion

