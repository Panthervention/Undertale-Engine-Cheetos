if timer > 0 timer--;

image_angle += rotate;

if (lenable)
{
    len_dir += len_dir_move;
    len += len_speed;
    x = len_x + lengthdir_x(len,len_dir);  
    y = len_y + lengthdir_y(len,len_dir);
    if (len_angle)
        image_angle += len_dir_move;
}
else if (mode != 0)
{
	switch (mode)
	{
		case 1:
			y = (obj_battle_board.y - obj_battle_board.up) + (length / 2);
			break;
		case 2:
			y = (obj_battle_board.y + obj_battle_board.down) - (length / 2);
			break;
		case 3:
			x = (obj_battle_board.x - obj_battle_board.left) + (length / 2);
			break;
		case 4:
			x = (obj_battle_board.x + obj_battle_board.right) - (length / 2);
			break;
	}
}
