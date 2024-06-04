#region Input
// Here are the macros for handy input code
#macro CHECK_HORIZONTAL input_check_opposing("left", "right")
#macro CHECK_VERTICAL input_check_opposing("up", "down")
#macro CHECK_CONFIRM input_check("confirm")
#macro CHECK_CANCEL input_check("cancel")

#macro PRESS_HORIZONTAL input_check_opposing_pressed("left", "right")
#macro PRESS_VERTICAL input_check_opposing_pressed("up", "down")
#macro PRESS_CONFIRM input_check_pressed("confirm")
#macro PRESS_MENU input_check_pressed("menu")
#macro PRESS_CANCEL input_check_pressed("cancel")
#endregion

#macro off false
#macro on true

#macro game_restart __game_restart // Hijacking GameMaker's game_restart() as it's dumb as shit!
