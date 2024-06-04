if (!audio_is_playing(bgm_default)) // Living Mice - Minecraft soundtrack
	audio_play_sound(bgm_default, 0, true);

depth = -15000;
timer = 0;
quit_timer = 0;
frame_skip = 0;

released = __CHEETOS_RELEASE;

#region Debug
allow_debug = __CHEETOS_ALLOW_DEBUG;
global.debug = false;
global.show_hitbox = 0;
global._fps_real = game_get_speed(gamespeed_fps);
global._fps_average = global._fps_real;
global._fps_min = global._fps_real;
global._fps_max = global._fps_real;

debug_fps_lock = false;
#endregion

global.hp = 0;
global.hp_max = 0;
global.kr = 0;
global.refill_speed = 0.2;

global.item_name_mode = 1; // 0: Full, 1: Short, 2: Short Serious
global.inventory_capacity = 8; // Default UNDERTALE

global.f2_locked = false;
global.kr_enable = false;
global.kr_overridable = true;
global.volume = 1;

#region Fader

fader_color = c_black;
fader_alpha = 0;
fader_tween = noone;

#endregion

#region Camera

event_user(0); // Camera properties loading

global.camera = camera_create_view(cam_x, cam_y, cam_width / cam_scale_x, cam_height / cam_scale_y, cam_angle, cam_target, -1, -1, cam_width / cam_scale_x / 2, cam_height / cam_scale_y / 2);

#endregion

#region Border

border_enable = false;
border_sprite = -1;
border_sprite_previous = -1;
border_alpha = 1;

#endregion
