#region Most basic bone function
///@arg x
///@arg y
///@arg len
///@arg hsp
///@arg vsp
///@arg [type]
///@arg [out]
///@arg [mode]
///@arg [angle]
///@arg [rot]
///@arg [auto_destroy]
///@arg [duration]
function Bullet_Bone(X, Y, LENGTH, HSPEED, VSPEED, TYPE = 0, OUT = 0, MODE = 0, ANGLE = 90, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	var DEPTH = DEPTH_BATTLE.BULLET_MID;
	
	var bone = instance_create_depth(X, Y, DEPTH, obj_battle_bullet_bone);
	with bone
	{
		x = X;
		y = Y;
		hspeed = HSPEED;
		vspeed = VSPEED;
		image_angle = ANGLE;
		
		length = LENGTH;
		rotate = ROTATE;
		type = TYPE;
		duration = DURATION;
		mode = MODE;
		out = OUT;
		
		destroyable = DESTROYABLE;
	}
	return bone;
}

#endregion

#region Stick to board's size

///@arg x
///@arg len
///@arg hsp
///@arg [type]
///@arg [out]
///@arg [rot]
///@arg [auto_destroy]
///@arg [duration]
function Bullet_BoneTop(X, LENGTH, HSPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	var Y = (obj_battle_board.y - obj_battle_board.up) + (LENGTH / 2);
	var VSPEED = 0;
	var ANGLE = 90;
	var MODE = 0;
	var bone = Bullet_Bone(X, Y, LENGTH, HSPEED, VSPEED, TYPE, OUT, MODE, ANGLE, ROTATE, DESTROYABLE, DURATION);
	return bone;
}

///@arg x
///@arg len
///@arg hsp
///@arg [type]
///@arg [out]
///@arg [rot]
///@arg [auto_destroy]
///@arg [duration]
function Bullet_BoneBottom(X, LENGTH, HSPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{	var Y = (obj_battle_board.y + obj_battle_board.down) - (LENGTH / 2);
	var VSPEED = 0;
	var ANGLE = 90;
	var MODE = 0;
	var bone = Bullet_Bone(X, Y, LENGTH, HSPEED, VSPEED, TYPE, OUT, MODE, ANGLE, ROTATE, DESTROYABLE, DURATION);
	return bone;
}

///@arg y
///@arg len
///@arg vsp
///@arg [type]
///@arg [out]
///@arg [rot]
///@arg [auto_destroy]
///@arg [duration]
function Bullet_BoneLeft(Y, LENGTH, VSPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	var X = (obj_battle_board.x - obj_battle_board.left) + (LENGTH / 2);
	var HSPEED = 0;
	var ANGLE = 0;
	var MODE = 0;
	var bone = Bullet_Bone(X, Y, LENGTH, HSPEED, VSPEED, TYPE, OUT, MODE, ANGLE, ROTATE, DESTROYABLE, DURATION);
	return bone;
}

///@arg y
///@arg len
///@arg vsp
///@arg [type]
///@arg [out]
///@arg [rot]
///@arg [auto_destroy]
///@arg [duration]
function Bullet_BoneRight(Y, LENGTH, VSPEED, TYPE = 0, OUT = 0, ROTATE = 0, DESTROYABLE = true, DURATION = -1)
{
	var X = (obj_battle_board.x + obj_battle_board.right) - (LENGTH / 2);
	var HSPEED = 0;
	var ANGLE = 0;
	var MODE = 0;
	var bone = Bullet_Bone(X, Y, LENGTH, HSPEED, VSPEED, TYPE, OUT, MODE, ANGLE, ROTATE, DESTROYABLE, DURATION);
	return bone;
}

#endregion

#region Bone in Sine Wave

///@arg y
///@arg x_gap
///@arg vsp
///@arg space
///@arg amount
///@arg gap
///@arg udf
///@arg uds
///@arg [type]
///@arg [out]
function Bullet_BoneWaveV(Y, X_GAP, VSPEED, SPACE, AMOUNT, GAP, UDF, UDS, TYPE = 0, OUT = 0)
{
	var SIN = 0;
	var DIRECTION = sign(VSPEED);
	var bone = [];
	for (var i = 0; i < AMOUNT; ++i)
	{
		SIN += (UDS * 0.5);
		Y -= (SPACE * DIRECTION);
		
		var X = X_GAP + (sin(SIN) * UDF);
		bone[i] = Bullet_BoneGapV(X, Y, VSPEED, GAP);
	}
	return bone;
}

///@arg x
///@arg y_gap
///@arg hsp
///@arg space
///@arg amount
///@arg gap
///@arg udf
///@arg uds
///@arg [type]
///@arg [out]
function Bullet_BoneWaveH(X, Y_GAP, HSPEED, SPACE, AMOUNT, GAP, UDF, UDS, TYPE = 0, OUT = 0)
{
	var SIN = 0;
	var DIRECTION = sign(HSPEED);
	var bone = [];
	for (var i = 0; i < AMOUNT; ++i)
	{
		SIN += (UDS);
		X -= (SPACE * DIRECTION);
		
		var Y = Y_GAP + (sin(SIN) * UDF);
		bone[i] = Bullet_BoneGapH(X, Y, HSPEED, GAP);
	}
	return bone;
}

#endregion

#region Bone Gap

///@arg x
///@arg y
///@arg vsp
///@arg x_gap
///@arg [type]
///@arg [out]
///@arg [auto_destroy]
///@arg [duration]
function Bullet_BoneGapV(X, Y, VSPEED, X_GAP, TYPE = 0, OUT = 0, DESTROYABLE = true, DURATION = -1)
{
	var bone = [];
	var board = obj_battle_board;
	var board_x = board.y;
	var board_margin = [board.left, board.right];
	var GAP = X_GAP / 2;
	var LENGTH_L = X - board_x + board_margin[0] - GAP;
	var LENGTH_R = board_x + board_margin[1] - GAP - X;
	
	bone[0] = Bullet_BoneLeft(Y, LENGTH_L, VSPEED, TYPE, OUT, 0, DESTROYABLE, DURATION);
	bone[1] = Bullet_BoneRight(Y, LENGTH_R, VSPEED, TYPE, OUT, 0, DESTROYABLE, DURATION);
	return bone;
}

///@arg x
///@arg y
///@arg hsp
///@arg y_gap
///@arg [type]
///@arg [out]
///@arg [auto_destroy]
///@arg [duration]
function Bullet_BoneGapH(X, Y, HSPEED, Y_GAP, TYPE = 0, OUT = 0, DESTROYABLE = true, DURATION = -1)
{
	var bone = [];
	var board = obj_battle_board;
	var board_y = board.y;
	var board_margin = [board.up, board.down];
	var GAP = Y_GAP / 2;
	var LENGTH_T = Y - board_y + board_margin[0] - GAP;
	var LENGTH_B = board_y + board_margin[1] - GAP - Y;

	bone[0] = Bullet_BoneTop(X, LENGTH_T, HSPEED, TYPE, OUT, 0, DESTROYABLE, DURATION);
	bone[1] = Bullet_BoneBottom(X, LENGTH_B, HSPEED, TYPE, OUT, 0, DESTROYABLE, DURATION);
	return bone;
}

#endregion

#region Bone Wall

///@arg dir
///@arg height
///@arg delay
///@arg stay
///@arg [type]
///@arg [duration]
///@arg [warn_sound]
function Bullet_BoneWall(DIRECTION, HEIGHT, DELAY, HOLD, TYPE = 0, MOVE = 5, WARN_SOUND = true)
{
	var DEPTH = DEPTH_BATTLE.BULLET_MID;
	
	var wall = instance_create_depth(0, 0, DEPTH, obj_battle_bullet_bonewall);
	with wall
	{
		dir = DIRECTION;
		target_height = HEIGHT;
		time_warn = DELAY;
		time_stay = HOLD;
		time_move = MOVE;
		type = TYPE;
		sound_warn = WARN_SOUND;
	}
	
	return wall;
}

#endregion
