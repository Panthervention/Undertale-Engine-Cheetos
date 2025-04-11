event_inherited();

char_id = 0;

res_idle_sprite[DIR.UP] = spr_char_frisk_up;
res_idle_sprite[DIR.DOWN] = spr_char_frisk_down;
res_idle_sprite[DIR.LEFT] = spr_char_frisk_right;
res_idle_sprite[DIR.RIGHT] = spr_char_frisk_right;
res_move_sprite[DIR.UP] = spr_char_frisk_up;
res_move_sprite[DIR.DOWN] = spr_char_frisk_down;
res_move_sprite[DIR.LEFT] = spr_char_frisk_right;
res_move_sprite[DIR.RIGHT] = spr_char_frisk_right;

moveable = true;
__moveable_dialog = true;
__moveable_menu = true;
__moveable_save = true;
__moveable_warp = true;
__moveable_encounter = true;
__moveable_box = true;
