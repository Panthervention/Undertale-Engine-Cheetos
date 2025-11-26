#region	Public Variables
depth = DEPTH_BATTLE.BOARD;
image_alpha = 1;

//surface_clip = -1;
surface_mask = -1;

x = BATTLE_BOARD.X;
y = BATTLE_BOARD.Y;

up = BATTLE_BOARD.UP;
down = BATTLE_BOARD.DOWN;
left = BATTLE_BOARD.LEFT;
right = BATTLE_BOARD.RIGHT;

frame_thickness = 5;

bg_alpha = 1;
bg_color = c_black;
#endregion

#region	Private Functions
__point_xy = function(_point_x, _point_y)
{
	var _angle = image_angle,
		_x = x,
		_y = y;
	
	//__point_x = ((_point_x - _x) * dcos(_angle)) - ((_point_y - _y) * dsin(_angle)) + _x;
	//__point_y = ((_point_y - _y) * dcos(_angle)) + ((_point_x - _x) * dsin(_angle)) + _y;
	__point_x = lengthdir_x(_point_x - _x, _angle) + lengthdir_y(_point_y - _y, -_angle) + _x;
	__point_y = lengthdir_x(_point_y - _y, _angle) - lengthdir_y(_point_x - _x, -_angle) + _y;
}
#endregion

#region	Private Variables
__frame_x = [0, 0, 0, 0];
__frame_y = [0, 0, 0, 0];
__frame_width = [0, 0, 0, 0];
__frame_height = [0, 0, 0, 0];

__bg_x = 0;
__bg_y = 0;
__bg_width = 0;
__bg_height = 0;

__point_x = 0;
__point_y = 0;

__transfer_angle = 0;
__transfer_bg_c = c_black;
__transfer_bg_a = 0;
__transfer_color = c_black;
__transfer_alpha = 0;
#endregion

