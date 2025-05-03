event_inherited();

char_id = 0;
var _i = 0; repeat(4)
{
	var _dir = __dir_list[_i];
	
	var _sprite = (_dir == DIR.UP) ? spr_char_frisk_up : ((_dir == DIR.DOWN) ? spr_char_frisk_down : spr_char_frisk_right);
	resource.idle[$ _dir].sprite_index = _sprite;
	resource.move[$ _dir].sprite_index = _sprite;
	
	_i++;
}

__collision_offset = {};
__collision_offset[$ DIR.UP]    = [-0.5, 4, 0, -5, 0.5, -4, -1, 5];
__collision_offset[$ DIR.DOWN]  = [-0.5, 4, 0, 20, 0.5, -4, 0, 15];
__collision_offset[$ DIR.LEFT]  = [0, 0, -1, 19, 0.5, -15, 0, 0];
__collision_offset[$ DIR.RIGHT] = [0, 0, -1, 19, 0.5, 15, 0, 0];

moveable = true;
__moveable_dialog = true;
__moveable_menu = true;
__moveable_save = true;
__moveable_warp = true;
__moveable_encounter = true;
__moveable_box = true;
