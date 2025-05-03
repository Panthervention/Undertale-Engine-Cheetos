event_inherited();

var _spd = 1/3;

var _i = 0; repeat(4)
{
	var _dir = __dir_list[_i];
	
	// Override the per-angle animation speeds:
    resource.idle[$ _dir].image_speed = _spd;
    resource.move[$ _dir].image_speed = _spd;
    resource.talk[$ _dir].image_speed = _spd;
	
	_i++;
}
