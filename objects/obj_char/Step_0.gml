var _i = 0; repeat (4)
{
    if (move[_i] > 0)
    {
        if (!dir_locked)
            dir = _i;
        var _move_x = 0, _move_y = 0;
        if (_i == DIR.UP || _i == DIR.DOWN)
            _move_y = move_speed[_i] * (_i == DIR.UP ? -1 : 1);
        else if (_i == DIR.LEFT || _i == DIR.RIGHT)
            _move_x = move_speed[_i] * (_i == DIR.LEFT ? -1 : 1);
        var _moveable = true;
        if (collision)
        {
            var _list = __collision_list;
            ds_list_clear(_list);
            var _n = instance_place_list(x + _move_x, y + _move_y, obj_block, _list, false);
            var _j = 0; repeat (_n)
            {
                var _collision = _list[| _j];
                if (instance_exists(_collision))
                {
                    if (_collision.block_enabled)
                    {
                        _moveable = false;
                        break;
                    }
                }
                _j += 1;
            }
        }
        if (_moveable)
        {
            x += _move_x;
            y += _move_y;
        }
        move[_i] -= 1;
    }
    _i += 90;
}

var _refresh = ((dir != __dir_previous || talking != __talking_previous || (move[dir] > 0) != (__move_previous > 0)) && !res_override);
if (_refresh)
{
    if (move[DIR.UP] > 0 || move[DIR.DOWN] > 0 || move[DIR.LEFT] > 0 || move[DIR.RIGHT] > 0)
    {
        sprite_index = res_move_sprite[dir];
        image_index = res_move_image[dir];
        image_speed = res_move_speed[dir];
        image_xscale *= ((res_move_flip_x[dir] && sign(image_xscale) == 1) || (!res_move_flip_x[dir] && sign(image_xscale) == -1) ? -1 : 1);
    }
    else if (talking)
    {
        sprite_index = res_talk_sprite[dir];
        image_index = res_talk_image[dir];
        image_speed = res_talk_speed[dir];
        image_xscale *= ((res_talk_flip_x[dir] && sign(image_xscale) == 1) || (!res_talk_flip_x[dir] && sign(image_xscale) == -1) ? -1 : 1);
    }
    else
    {
        sprite_index = res_idle_sprite[dir];
        image_index = res_idle_image[dir];
        image_speed = res_idle_speed[dir];
        image_xscale *= ((res_idle_flip_x[dir] && sign(image_xscale) == 1) || (!res_idle_flip_x[dir] && sign(image_xscale) == -1) ? -1 : 1);
    }
}

__talking_previous = talking;
__dir_previous = dir;
__move_previous = move[dir];
