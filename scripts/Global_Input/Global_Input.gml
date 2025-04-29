#macro input_function global.__input_function

///@func Input_Init()
///@desc Initialize input update process.
function Input_Init()
{
	input_function = {};

	with (input_function)
	{
		check_up	= 0;
		check_down	= 0;
		check_left	= 0;
		check_right	= 0;
	
		press_vertical		= 0;
		press_horizontal	= 0;
		press_confirm		= 0;
		press_cancel		= 0;
		press_menu			= 0;

		check_vertical		= 0;
		check_horizontal	= 0;
		check_movement		= 0;
		check_confirm		= 0;
		check_cancel		= 0;
		
		timer = 0;
	}

	with (global)
	{
		__hash_check_up = variable_get_hash("check_up");
		__hash_check_down = variable_get_hash("check_down");
		__hash_check_left = variable_get_hash("check_left");
		__hash_check_right = variable_get_hash("check_right");
	
		__hash_press_vertical = variable_get_hash("press_vertical");
		__hash_press_horizontal = variable_get_hash("press_horizontal");
		__hash_press_confirm = variable_get_hash("press_confirm");
		__hash_press_cancel = variable_get_hash("press_cancel");
		__hash_press_menu = variable_get_hash("press_menu");
	
		__hash_check_vertical = variable_get_hash("check_vertical");
		__hash_check_horizontal = variable_get_hash("check_horizontal");
		__hash_check_movement = variable_get_hash("check_movement");
		__hash_check_confirm = variable_get_hash("check_confirm");
		__hash_check_cancel = variable_get_hash("check_cancel");
	}

	#region Input Processing
	global.__input_timesource = time_source_create(time_source_game, 1, time_source_units_frames, function()
	{
		with (input_function)
		{			
			check_up			= InputCheck(INPUT_VERB.UP);
			check_down			= InputCheck(INPUT_VERB.DOWN);
			check_left			= InputCheck(INPUT_VERB.LEFT);
			check_right			= InputCheck(INPUT_VERB.RIGHT);
	
			press_vertical		= InputOpposingPressed(INPUT_VERB.UP, INPUT_VERB.DOWN);
			press_horizontal	= InputOpposingPressed(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
			press_confirm		= InputPressed(INPUT_VERB.CONFIRM);
			press_cancel		= InputPressed(INPUT_VERB.CANCEL);
			press_menu			= InputPressed(INPUT_VERB.MENU);

			check_vertical		= InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN);
			check_horizontal	= InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
			check_movement		= (check_vertical != 0 || check_horizontal != 0);
			check_confirm		= InputCheck(INPUT_VERB.CONFIRM);
			check_cancel		= InputCheck(INPUT_VERB.CANCEL);
		}	
	}, [], -1, time_source_expire_after);
	time_source_start(global.__input_timesource);
	#endregion
}

///@func Input_Uninit()
///@desc Uninitialize the input update process.
function Input_Uninit()
{
	delete input_function;
	if (time_source_exists(global.__input_timesource))
		time_source_destroy(global.__input_timesource);
}

#macro PRESS_VERTICAL		struct_get_from_hash(input_function, global.__hash_press_vertical)
#macro PRESS_HORIZONTAL		struct_get_from_hash(input_function, global.__hash_press_horizontal)
#macro PRESS_CONFIRM		struct_get_from_hash(input_function, global.__hash_press_confirm)
#macro PRESS_CANCEL			struct_get_from_hash(input_function, global.__hash_press_cancel)
#macro PRESS_MENU			struct_get_from_hash(input_function, global.__hash_press_menu)

#macro CHECK_VERTICAL		struct_get_from_hash(input_function, global.__hash_check_vertical)
#macro CHECK_HORIZONTAL		struct_get_from_hash(input_function, global.__hash_check_horizontal)
#macro CHECK_IS_MOVING		struct_get_from_hash(input_function, global.__hash_check_movement)
#macro CHECK_CONFIRM		struct_get_from_hash(input_function, global.__hash_check_confirm)
#macro CHECK_CANCEL			struct_get_from_hash(input_function, global.__hash_check_cancel)

#macro CHECK_UP				struct_get_from_hash(input_function, global.__hash_check_up)
#macro CHECK_DOWN			struct_get_from_hash(input_function, global.__hash_check_down)
#macro CHECK_LEFT			struct_get_from_hash(input_function, global.__hash_check_left)
#macro CHECK_RIGHT			struct_get_from_hash(input_function, global.__hash_check_right)
