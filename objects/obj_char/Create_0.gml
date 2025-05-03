event_inherited();

__dir_list = [DIR.UP, DIR.DOWN, DIR.LEFT, DIR.RIGHT];
var	_sprite_index = (sprite_exists(sprite_index) ? sprite_index : spr_fallback_default);

char_id = -1;

dir = DIR.DOWN;
dir_locked = false;

collision = true;

move = {};
move_speed = {};
resource =
{
	idle : {},
	move : {},
	talk : {}
};

var _i = 0; repeat (4)
{
	var _dir = __dir_list[_i],
		_flip_horizontally = (_dir == DIR.LEFT);
	
	move[$ _dir] = 0;
	move_speed[$ _dir] = 2;
	
	resource.idle[$ _dir] = {};
	with (resource.idle[$ _dir])
	{
		sprite_index = _sprite_index;
		image_index = 0;
		image_speed = 0;
		flip_horizontally = _flip_horizontally;
	}
	
	resource.move[$ _dir] = {};
	with (resource.move[$ _dir])
	{
		sprite_index = _sprite_index;
		image_index = 1;
		image_speed = 1/3;
		flip_horizontally = _flip_horizontally;
	}
	
	resource.talk[$ _dir] = {};
	with (resource.talk[$ _dir])
	{
		sprite_index = _sprite_index;
		image_index = 1;
		image_speed = 1/2;
		flip_horizontally = _flip_horizontally;
	}
	
	_i++;
}

resource_override = false;
talking = false;

__resource_list = [resource.idle, resource.move, resource.talk];

__previous_dir = -1;
__previous_move = -1;
__previous_state = -1;
__previous_talking = !talking;
