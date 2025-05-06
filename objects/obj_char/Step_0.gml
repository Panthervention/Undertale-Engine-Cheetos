// Movement processing
var _i = 0; repeat (4)
{
	var _dir = __dir_list[_i];	
	if (move[$ _dir] > 0)
	{
		if (!dir_locked)
			dir = _dir;
		
		var _move_speed = move_speed[$ _dir],
			_dx = ((_dir == DIR.RIGHT) - (_dir == DIR.LEFT)) * _move_speed,
			_dy = ((_dir == DIR.DOWN) - (_dir == DIR.UP)) * _move_speed;
		
		var _collision = instance_place(x + _dx, y + _dy, obj_block);
		if (!collision || _collision == noone || !_collision.block_enabled)
		{
			x += _dx;
			y += _dy;
		}
		
		move[$ _dir]--;
	}
	_i++;
}

// Determine current animation state
var _is_moving = (move[$ dir] > 0),
	_is_talking = talking;
	
// Bitwise trickery: 0 = idle, 1 = move, 2 = talk
var _state = (_is_talking << 1) | (_is_moving && !_is_talking);

if (!resource_override && (_state != __previous_state || dir != __previous_dir))
{
	var _resource = __resource_list[_state][$ dir];
	sprite_index = _resource.sprite_index;
	image_index = _resource.image_index;
	image_speed = _resource.image_speed;
	
	var _flip = _resource.flip_horizontally;
	if ((_flip && image_xscale > 0) || (!_flip && image_xscale < 0))
		image_xscale = -image_xscale;
}

// Update for next frame comparison
__previous_dir = dir;
__previous_move = move[$ dir];
__previous_state = _state;
__previous_talking = talking;
