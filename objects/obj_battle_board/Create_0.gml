#region	Public Variables
depth = DEPTH_BATTLE.BOARD;
image_alpha = 1;

surface_clip = -1;
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
	var _angle = image_angle;
	
	//__point_x = ((_point_x - x) * dcos(_angle)) - ((_point_y - y) * dsin(_angle)) + x;
	//__point_y = ((_point_y - y) * dcos(_angle)) + ((_point_x - x) * dsin(_angle)) + y;
	__point_x = lengthdir_x(_point_x - x, _angle) + lengthdir_y(_point_y - y, -_angle) + x;
	__point_y = lengthdir_x(_point_y - y, _angle) - lengthdir_y(_point_x - x, -_angle) + y;
}
#endregion

#region	Private Variables
__surface_frame = -1;

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
#endregion

