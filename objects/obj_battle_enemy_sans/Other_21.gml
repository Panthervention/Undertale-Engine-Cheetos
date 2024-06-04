///@desc Turn End
global.deadable = false;
global.menu_hurt = "activated";

if (Battle_GetTurnNumber() > 2)
	_check_status = 1; // Update check status