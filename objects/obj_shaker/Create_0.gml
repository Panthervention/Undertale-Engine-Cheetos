target = noone;				// The target object instance to apply the shake effect to
var_name = "";				// The variable name in the target instance that will be shaken (e.g., "x" or "y")

shake_distance = 0;			// Maximum shake amplitude (pixels or units)
shake_speed = 0;			// Delay (in steps) between shake direction updates; lower = faster shaking
shake_random = false;		// If true, shake direction is randomized instead of alternating
shake_decrease = 1;			// Amount to decrease shake_distance each update until it reaches 0

__shake_base = undefined;	// Stores the original (base) value of the target variable before shaking
__shake_pos = 0;			// Current shake offset being applied to the variable
__shake_time = 0;			// Internal timer controlling when the next shake update occurs
__shake_positive = true;	// Used to toggle between positive and negative shake directions
