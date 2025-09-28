#macro input_function global.__input_function

///@func Input_Init()
///@desc Initialize input update process.
function Input_Init()
{
	input_function = {};

	with (input_function)
	{
		#region Input values
		check_up			= 0;
		check_down			= 0;
		check_left			= 0;
		check_right			= 0;
	
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
		check_pause			= 0;
		#endregion
		
		#region Input hashes
		hash_check_up			= variable_get_hash("check_up");
		hash_check_down			= variable_get_hash("check_down");
		hash_check_left			= variable_get_hash("check_left");
		hash_check_right		= variable_get_hash("check_right");
	
		hash_press_vertical		= variable_get_hash("press_vertical");
		hash_press_horizontal	= variable_get_hash("press_horizontal");
		hash_press_confirm		= variable_get_hash("press_confirm");
		hash_press_cancel		= variable_get_hash("press_cancel");
		hash_press_menu			= variable_get_hash("press_menu");
	
		hash_check_vertical		= variable_get_hash("check_vertical");
		hash_check_horizontal	= variable_get_hash("check_horizontal");
		hash_check_movement		= variable_get_hash("check_movement");
		hash_check_confirm		= variable_get_hash("check_confirm");
		hash_check_cancel		= variable_get_hash("check_cancel");
		hash_check_pause		= variable_get_hash("check_pause");
		#endregion
		
		#region Input processing
		// For this system to work, `INPUT_COLLECT_MODE` in __InputConfig has to be set to `2`
		__input_timesource = time_source_create(time_source_game, 1, time_source_units_frames, function()
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
			check_pause			= InputCheck(INPUT_VERB.PAUSE);
			
			// Manually collects player input from devices.
			// As mentioned, `INPUT_COLLECT_MODE` must be set to `2`.
			InputManualCollect();
		}, [], -1, time_source_expire_after);
		#endregion
	}
	// Start the input processing
	time_source_start(input_function.__input_timesource);
}

///@func Input_Uninit()
///@desc Uninitialize the input update process.
function Input_Uninit()
{
	if (time_source_exists(input_function.__input_timesource))
		time_source_destroy(input_function.__input_timesource);
	delete input_function;
}

#region Input macros
#macro CHECK_UP				struct_get_from_hash(input_function, input_function.hash_check_up)
#macro CHECK_DOWN			struct_get_from_hash(input_function, input_function.hash_check_down)
#macro CHECK_LEFT			struct_get_from_hash(input_function, input_function.hash_check_left)
#macro CHECK_RIGHT			struct_get_from_hash(input_function, input_function.hash_check_right)

#macro PRESS_VERTICAL		struct_get_from_hash(input_function, input_function.hash_press_vertical)
#macro PRESS_HORIZONTAL		struct_get_from_hash(input_function, input_function.hash_press_horizontal)
#macro PRESS_CONFIRM		struct_get_from_hash(input_function, input_function.hash_press_confirm)
#macro PRESS_CANCEL			struct_get_from_hash(input_function, input_function.hash_press_cancel)
#macro PRESS_MENU			struct_get_from_hash(input_function, input_function.hash_press_menu)

#macro CHECK_VERTICAL		struct_get_from_hash(input_function, input_function.hash_check_vertical)
#macro CHECK_HORIZONTAL		struct_get_from_hash(input_function, input_function.hash_check_horizontal)
#macro CHECK_IS_MOVING		struct_get_from_hash(input_function, input_function.hash_check_movement)
#macro CHECK_CONFIRM		struct_get_from_hash(input_function, input_function.hash_check_confirm)
#macro CHECK_CANCEL			struct_get_from_hash(input_function, input_function.hash_check_cancel)
#macro CHECK_PAUSE			struct_get_from_hash(input_function, input_function.hash_check_pause)
#endregion
