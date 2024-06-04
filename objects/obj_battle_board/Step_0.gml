// Frames 
var _frame_x = frame_x;
var _frame_y = frame_y;
var _frame_w = frame_w;
var _frame_h = frame_h;

// Background/Surface 
point_xy(x - left, y - up);
bg_x = point_x;
bg_y = point_y;
bg_w = left + right;
bg_h = up + down;

var side_h = (up + down) + thickness_frame * 2;
var side_v = (left + right) + thickness_frame * 2;

// Left 
point_xy((x - left) - thickness_frame, (y - up) - thickness_frame);
_frame_x[0] = point_x;
_frame_y[0] = point_y;
_frame_w[0] = thickness_frame;
_frame_h[0] = side_h;

// Top 
point_xy((x - left) - thickness_frame, (y - up) - thickness_frame);
_frame_x[1] = point_x;
_frame_y[1] = point_y;
_frame_w[1] = side_v;
_frame_h[1] = thickness_frame;

// Right 
point_xy(x + right, (y - up) - thickness_frame);
_frame_x[2] = point_x;
_frame_y[2] = point_y;
_frame_w[2] = thickness_frame;
_frame_h[2] = side_h;

// Bottom 
point_xy((x - left) - thickness_frame, y + down);
_frame_x[3] = point_x;
_frame_y[3] = point_y;
_frame_w[3] = side_v;
_frame_h[3] = thickness_frame;

frame_x = _frame_x;
frame_y = _frame_y;
frame_w = _frame_w;
frame_h = _frame_h;

