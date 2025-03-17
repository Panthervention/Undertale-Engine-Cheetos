depth = -10000;
timer = 0;
quit_timer = 0;

released = __CHEETOS_RELEASE;

with (global)
{
	#region		Vitalities Variables
	hp = 0;
	hp_max = 0;
	kr = 0;
	refill_speed = 0.2;
	#endregion
	
	#region		Inventory Variables
	item_name_mode = 1; // 0: Full, 1: Short, 2: Short Serious
	inventory_capacity = 8; // Default UNDERTALE
	#endregion
	
	#region		Global Logic Variables
	f2_locked = false;
	kr_enable = false;
	kr_overridable = true;
	volume = 1;
	#endregion
}

#region		Fader Variables
fader_color = c_black;
fader_alpha = 0;
fader_tween = noone;
#endregion

#region		Camera Variables
global.__camera = new Global_Camera();
#macro camera global.__camera
#endregion

#region		Border Variables
border_enable = false;
border_auto_capture = false;
border_sprite = noone;
border_sprite_previous = noone;
border_alpha = 1;

Border_SetEnabled(true, true);
#endregion

#region		Debug Variables
allow_debug = __CHEETOS_ALLOW_DEBUG;
with (global)
{
	debug = false;
	show_hitbox = 0;
	__fps_real = game_get_speed(gamespeed_fps);
	__fps_average = __fps_real;
	__fps_min = __fps_real;
	__fps_max = __fps_real;
}
debug_fps_lock = false;
#endregion
