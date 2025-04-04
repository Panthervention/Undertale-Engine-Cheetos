///@desc Turn End
global.deadable = false;
global.menu_hurt = "activated";

if (Battle_GetTurnNumber() > 2)
	__check_status = 1; // Update check status