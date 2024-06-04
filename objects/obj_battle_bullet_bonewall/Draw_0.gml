if (!active)
	exit;
else
{
	var spr = bone_index,
		spr_outline = bone_index_outline,
		spr_index = bone_sub,
		spr_width = sprite_get_width(spr),
		spr_height = sprite_get_height(spr) + 2;
	
	var color = ((type == 1) ? c_aqua : ((type == 2) ? c_orange : c_white)),
		color_outline = color;
	
	var board = obj_battle_board,
		board_x = board.x,
		board_y = board.y,
		board_u = board_y - board.up,
		board_d = board_y + board.down,
		board_l = board_x - board.left,
		board_r = board_x + board.right;

	if (time_warn > 0)
	{
		if (type_warn == 1)
		{
			var x1 = 0,
				y1 = 0,
				x2 = 0,
				y2 = 0;
		
			if (dir == DIR.UP or dir == DIR.DOWN)
			{
				x1 = board_l + 2;
				x2 = board_r - 3;
			
				if (dir == DIR.UP)
				{
					y1 = board_u + 2;
					y2 = board_u + target_height - 2;
				}
				if (dir == DIR.DOWN)
				{
					y1 = board_d - 2;
					y2 = board_d - target_height + 2;
				}
			}
			if (dir == DIR.LEFT or dir == DIR.RIGHT)
			{
				y1 = board_u + 2;
				y2 = board_d - 3;
			
				if (dir == DIR.LEFT)
				{
					x1 = board_l + 2;
					x2 = board_l + target_height - 2;
				}
				if (dir == DIR.RIGHT)
				{
					x1 = board_r - 2;
					x2 = board_r - target_height;
				}
			}
			
			Battle_BoardMaskSet(true);
			draw_set_alpha(warn_alpha_filled);
			draw_set_color(warn_color);
			draw_rectangle(x1, y1, x2, y2, false);
			
			draw_set_alpha(1);
			draw_set_color(warn_color);
			draw_rectangle(x1, y1, x2, y2, true);
			Battle_BoardMaskReset();
		}
		if (type_warn == 2)
			draw_sprite_ext(spr_pap_gasta_hand, 0, 520, 135, warn_scale, warn_scale, dir, c_white, warn_alpha);	
		draw_set_alpha(1);
		draw_set_color(c_white);
	}
	else
	{
		Battle_BoardMaskSet(true);
		var wall_angle = 0,
			wall_head = (spr_width / 2) - 1,
			wall_height = target_height > 0 ? ((target_height / spr_width) + ((wall_head / spr_width) * 2)) : 0;
		
		if (dir == DIR.UP or dir == DIR.DOWN)
		{
			wall_angle = BONE.VERTICAL;
			
			var bone_y = 0;
			
			if (dir == DIR.UP)
				bone_y = [(board_u - wall_head) + (height / 2), board_u, (board_u - wall_head + height) - 1];
			if (dir == DIR.DOWN)
				bone_y = [(board_d + wall_head) - (height / 2), board_d, (board_d + wall_head - height) - 1];
	
			for (var i = board_l - spr_height, n = board_r + spr_height, u = spr_height; i < n; i += u)
			{
				draw_sprite_ext(spr, spr_index,	i, bone_y[0], wall_height, 1, wall_angle, color, image_alpha);
				draw_sprite_ext(spr_outline, spr_index,	i, bone_y[0], wall_height, 1, wall_angle, color_outline, image_alpha);
			}
			if (global.show_hitbox)
			{
				draw_set_color(c_green);
				draw_set_alpha(0.25);
				draw_rectangle(board_l + 2, bone_y[1], board_r - 3, bone_y[2], false);
				draw_set_alpha(1);
				draw_set_color(c_white);
			}
		}
		if (dir == DIR.LEFT or dir == DIR.RIGHT)
		{
			wall_angle = BONE.HORIZONTAL;
			
			var bone_x = 0;
			if (dir == DIR.LEFT)
				bone_x = [(board_l - wall_head) + (height / 2), board_l, (board_l - wall_head + height) - 1];
			if (dir == DIR.RIGHT)
				bone_x = [(board_r + wall_head) - (height / 2), board_r, (board_r + wall_head - height) - 1];
				
			for (var i = board_u - spr_height, n = board_r + spr_height, u = spr_height; i < n; i += u)
			{
				draw_sprite_ext(spr, spr_index, bone_x[0], i, wall_height, 1, wall_angle, color, image_alpha);
				draw_sprite_ext(spr_outline, spr_index, bone_x[0], i, wall_height, 1, wall_angle, color_outline, image_alpha);
			}
			
			if (global.show_hitbox)
			{
				draw_set_color(c_green);
				draw_set_alpha(0.25);
				draw_rectangle(bone_x[1], board_u + 2, bone_x[2], board_d - 3, false);
				draw_set_alpha(1);
				draw_set_color(c_white);
			}
		}
		Battle_BoardMaskReset();
	}
}