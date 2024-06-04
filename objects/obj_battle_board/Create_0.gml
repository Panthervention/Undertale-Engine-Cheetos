///@desc
depth = DEPTH_BATTLE.BOARD;
image_alpha = 1;

surface_clip = noone;
surface_mask = noone;

x = BATTLE_BOARD.X;
y = BATTLE_BOARD.Y;

up = BATTLE_BOARD.UP;
down = BATTLE_BOARD.DOWN;
left = BATTLE_BOARD.LEFT;
right = BATTLE_BOARD.RIGHT;

frame_x = [0, 0, 0, 0];
frame_y = [0, 0, 0, 0];
frame_w = [0, 0, 0, 0];
frame_h = [0, 0, 0, 0];

bg_x = 0
bg_y = 0
bg_w = 0
bg_h = 0

bg_a = 0.25;
bg_c = c_black;

thickness_frame = 5;

point_x = 0;
point_y = 0;

function point_xy(p_x, p_y)
{
	var angle = image_angle
	
	point_x = ((p_x - x) * dcos(-angle)) - ((p_y - y) * dsin(-angle)) + x
	point_y = ((p_y - y) * dcos(-angle)) + ((p_x - x) * dsin(-angle)) + y
}

