// Check if the target still exists, the target variable exists, and there is shake distance left
if (instance_exists(target) && variable_instance_exists(target, var_name) && shake_distance > 0)
{
	// Store the target’s base value if it has not been recorded yet
	if (!is_real(__shake_base))
		__shake_base = variable_instance_get(target, var_name);
		
	// Countdown before the next shake update
	if (__shake_time > 0)
		__shake_time--;
	else
	{
	    // Non-random shake: alternate between +distance and -distance each cycle
	    if (!shake_random)
	    {    
	        __shake_pos = (__shake_positive) ? shake_distance : -shake_distance;	// Toggle direction
	        __shake_positive ^= true;												// Flip the boolean flag
			
			// After completing a full shake cycle (positive + negative), gradually reduce amplitude
			if (!__shake_positive)
				shake_distance = max(0, shake_distance - shake_decrease);
        }
		// Random shake: assign a random offset between -distance and +distance each cycle
		else
		{
			__shake_pos = random_range(-shake_distance, shake_distance);	// Random offset
			shake_distance = max(0, shake_distance - shake_decrease);		// Gradually reduce amplitude
		}
		
		// Reset the shake timer; smaller shake_speed = faster updates
		__shake_time = shake_speed;
	}
	
	// Apply the shake offset to the target variable
	variable_instance_set(target, var_name, __shake_base + __shake_pos);
}
else
{
	// If the target or variable no longer exists, or shaking has finished, destroy this shaker instance
	instance_destroy();
}
