if (active)
{
	var _spr = bone_index,
		_spr_outline = bone_index_outline,
		_spr_index = bone_sub,
		_spr_width = sprite_get_width(_spr),
		_spr_height = sprite_get_height(_spr) + 2;
	
	var _color = ((type == 1) ? c_aqua : ((type == 2) ? c_orange : c_white)),
		_color_outline = _color;
	
	var _board = obj_battle_board,
		_board_x = _board.x,
		_board_y = _board.y,
		_board_u = _board_y - _board.up,
		_board_d = _board_y + _board.down,
		_board_l = _board_x - _board.left,
		_board_r = _board_x + _board.right;

	if (time_warn > 0)
	{
		var _x1 = 0,
			_y1 = 0,
			_x2 = 0,
			_y2 = 0;
		
		if (dir == DIR.UP || dir == DIR.DOWN)
		{
			_x1 = _board_l + 2;
			_x2 = _board_r - 3;
			
			if (dir == DIR.UP)
			{
				_y1 = _board_u + 2;
				_y2 = _board_u + target_height - 2;
			}
			else if (dir == DIR.DOWN)
			{
				_y1 = _board_d - 2;
				_y2 = _board_d - target_height + 2;
			}
		}
		else if (dir == DIR.LEFT || dir == DIR.RIGHT)
		{
			_y1 = _board_u + 2;
			_y2 = _board_d - 3;
			
			if (dir == DIR.LEFT)
			{
				_x1 = _board_l + 2;
				_x2 = _board_l + target_height - 2;
			}
			else if (dir == DIR.RIGHT)
			{
				_x1 = _board_r - 2;
				_x2 = _board_r - target_height;
			}
		}
			
		Battle_BoardMaskSet(true);
		draw_set_alpha(warn_alpha_filled);
		draw_set_color(warn_color);
		draw_rectangle(_x1, _y1, _x2, _y2, false);
			
		draw_set_alpha(1);
		draw_set_color(warn_color);
		draw_rectangle(_x1, _y1, _x2, _y2, true);
		Battle_BoardMaskReset();
		
		draw_set_alpha(1);
		draw_set_color(c_white);
	}
	else
	{
		Battle_BoardMaskSet(true);
		var _wall_angle = 0,
			_wall_head = (_spr_width / 2) - 1,
			_wall_height = target_height > 0 ? ((target_height / _spr_width) + ((_wall_head / _spr_width) * 2)) : 0;
		
		if (dir == DIR.UP || dir == DIR.DOWN)
		{
			_wall_angle = BONE.VERTICAL;
			
			var _bone_y = 0;
			
			if (dir == DIR.UP)
				_bone_y = [(_board_u - _wall_head) + (height / 2), _board_u, (_board_u - _wall_head + height) - 1];
			else if (dir == DIR.DOWN)
				_bone_y = [(_board_d + _wall_head) - (height / 2), _board_d, (_board_d + _wall_head - height) - 1];
	
			for (var _i = _board_l - _spr_height, _n = _board_r + _spr_height, u = _spr_height; _i < _n; _i += u)
			{
				draw_sprite_ext(_spr, _spr_index,	_i, _bone_y[0], _wall_height, 1, _wall_angle, _color, image_alpha);
				draw_sprite_ext(_spr_outline, _spr_index,	_i, _bone_y[0], _wall_height, 1, _wall_angle, _color_outline, image_alpha);
			}
			if (global.show_hitbox)
			{
				draw_set_color(c_green);
				draw_set_alpha(0.25);
				draw_rectangle(_board_l + 2, _bone_y[1], _board_r - 3, _bone_y[2], false);
				draw_set_alpha(1);
				draw_set_color(c_white);
			}
		}
		else if (dir == DIR.LEFT || dir == DIR.RIGHT)
		{
			_wall_angle = BONE.HORIZONTAL;
			
			var _bone_x = 0;
			if (dir == DIR.LEFT)
				_bone_x = [(_board_l - _wall_head) + (height / 2), _board_l, (_board_l - _wall_head + height) - 1];
			else if (dir == DIR.RIGHT)
				_bone_x = [(_board_r + _wall_head) - (height / 2), _board_r, (_board_r + _wall_head - height) - 1];
				
			for (var _i = _board_u - _spr_height, _n = _board_r + _spr_height, u = _spr_height; _i < _n; _i += u)
			{
				draw_sprite_ext(_spr, _spr_index, _bone_x[0], _i, _wall_height, 1, _wall_angle, _color, image_alpha);
				draw_sprite_ext(_spr_outline, _spr_index, _bone_x[0], _i, _wall_height, 1, _wall_angle, _color_outline, image_alpha);
			}
			
			if (global.show_hitbox)
			{
				draw_set_color(c_green);
				draw_set_alpha(0.25);
				draw_rectangle(_bone_x[1], _board_u + 2, _bone_x[2], _board_d - 3, false);
				draw_set_alpha(1);
				draw_set_color(c_white);
			}
		}
		Battle_BoardMaskReset();
	}
}