#region Debug
if global.debug
{
	var c_debug = merge_color(c_lime, c_green, 0.5),
		fps_locked = debug_fps_lock ? "(Locked)" : "(Unlocked)",
		game_speed = game_get_speed(gamespeed_fps);
	
	// Drawing background
	draw_set_color(c_white);
	draw_set_alpha(0.25);
	draw_rectangle(0, 0, 220, 130, false);
	
	draw_set_font(font_dt_sans);
	draw_set_alpha(1);
	draw_set_color(c_debug);
	draw_text(5, 0, "DEBUG");
	draw_text(5, 10, "----------------------------------------");
	draw_text(5, 20, $"FPS: {fps} ({global.__fps_real}/{global.__fps_average}) ({global.__fps_min}/{global.__fps_max})");
	draw_text(5, 35, $"Speed: {game_speed} ({game_speed / 60}x) {fps_locked}");
	draw_text(5, 50, $"Room: {room_get_name(room)}");
	draw_text(5, 65, $"Instances: {instance_count}");
	draw_text(5, 80, $"Mouse Coords: {mouse_x}x ; {mouse_y}y");
	draw_text(5, 90, "----------------------------------------");
	if Player_IsInBattle()
	{
		draw_text(5, 100, $"Turn: {Battle_GetTurnNumber()}{instance_exists(obj_battle_turn) ? $" - Timer: {obj_battle_turn.timer}" : "" }");
		if (instance_exists(obj_battle_soul))
			draw_text(5, 115, $"Soul Coords: {obj_battle_soul.x}x ; {obj_battle_soul.y}y");
	}
	
	draw_set_color(c_white);
}
#endregion

#region Fader

	draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, fader_color, fader_alpha);

#endregion

#region Quitting Message

	if quit_timer >= 1 
		draw_sprite_ext(spr_quitting, quit_timer / 14, 4, 4, 2, 2, 0, c_white, quit_timer / 30);

#endregion