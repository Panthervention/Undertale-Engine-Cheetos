depth = -12000;	// DEPTH_UI.ENCOUNTER_ANIM;

__encounter = -1;
__exclaim = true;
__quick = false;
__soul_x = 48;
__soul_y = 454;

__draw_soul = false;
__draw_soul_x = 0;
__draw_soul_y = 0;
__draw_player = false;
__draw_black = false;
__flash = 0;

if (instance_exists(obj_char_player))
    obj_char_player.__moveable_encounter = false;

alarm[0] = 1;
