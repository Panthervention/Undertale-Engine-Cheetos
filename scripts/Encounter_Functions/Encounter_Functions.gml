// Initializes the encounter system
function Encounter_Init() 
{
    global._encounter = {};
    Encounter_Store_Load();
}

// Uninitializes the encounter system
function Encounter_Uninit() 
{
    global._encounter = undefined; // Clear the global struct to allow garbage collection
    return true;
}

// Sets the details for a specific encounter
function Encounter_Set(ID, enemy_0, enemy_1, enemy_2, menu_dialog, flee = true, quick = false, soul_x = 48, soul_y = 454) 
{
    if (ID >= 0)
    {
        if (global._encounter[$ ID] == undefined)
            global._encounter[$ ID] = {};

        var struct_e = global._encounter[$ ID];
        struct_e[$ "enemy_0"] = enemy_0;
        struct_e[$ "enemy_1"] = enemy_1;
        struct_e[$ "enemy_2"] = enemy_2;
        struct_e[$ "menu_dialog"] = menu_dialog;
        struct_e[$ "menu_mercy_flee_enabled"] = flee;
        struct_e[$ "quick"] = quick;
        struct_e[$ "soul_x"] = soul_x;
        struct_e[$ "soul_y"] = soul_y;

        return true;
    }
    else
        return false;
}

// Starts an encounter
function Encounter_Start(encounter, anim = true, exclam = true) 
{
    if (Encounter_IsExists(encounter))
    {
        if (!instance_exists(obj_char_player))
            anim = false;

        if (!anim)
        {
            Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.ENCOUNTER, encounter);
            if (!Player_IsInBattle())
            {
                Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.BATTLE_ROOM_RETURN, room);
                room_persistent = true;
            }
            room_goto(room_battle);
        }
        else
        {
            var inst = instance_create_depth(0, 0, 0, obj_encounter_anim);
            inst._encounter = encounter;
            inst._exclam = exclam;
            inst._quick = Encounter_IsQuick(encounter);
            inst._soul_x = Encounter_GetSoulX(encounter);
            inst._soul_y = Encounter_GetSoulY(encounter);
        }
        return true;
    }
    else
    {
        show_debug_message($"Encounter ID {encounter} doesn't exists!");
        return false;
    }
}

// Retrieves an enemy from an encounter
function Encounter_GetEnemy(ID, enemy) 
{
    if (Encounter_IsExists(ID) && Battle_IsEnemySlotValid(enemy))
    {
        var struct_e = global._encounter[$ ID];
       
        return (object_exists(struct_e[$ $"enemy_{enemy}"]) ? struct_e[$ $"enemy_{enemy}"] : -1);
    }
    else
        return -1;
}

// Retrieves the menu dialog for an encounter
function Encounter_GetMenuDialog(ID) 
{
    if (Encounter_IsExists(ID))
    {
        var struct_e = global._encounter[$ ID];
        return (is_string(struct_e[$ "menu_dialog"]) ? struct_e[$ "menu_dialog"] : "");
    }
    else
        return "";
}

// Checks if mercy or flee options are enabled for an encounter
function Encounter_IsMenuMercyFleeEnabled(ID) 
{
    if (Encounter_IsExists(ID))
    {
        var struct_e = global._encounter[$ ID];
        return (is_real(struct_e[$ "menu_mercy_flee_enabled"]) ? struct_e[$ "menu_mercy_flee_enabled"] : true);
    }
    else
        return true;
}

// Checks if an encounter exists
function Encounter_IsExists(encounter) 
{
    return (global._encounter[$ encounter] != undefined);
}

// Checks if an encounter is marked as quick
function Encounter_IsQuick(ID) 
{
    if (Encounter_IsExists(ID))
    {
        var struct_e = global._encounter[$ ID];
        return (is_bool(struct_e[$ "quick"]) ? struct_e[$ "quick"] : false);
    }
    else
        return false;
}

// Retrieves the X position of the soul in an encounter
function Encounter_GetSoulX(ID) 
{
    if (Encounter_IsExists(ID))
    {
        var struct_e = global._encounter[$ ID];
        return (is_real(struct_e[$ "soul_x"]) ? struct_e[$ "soul_x"] : 48);
	}
	else
		return 48;
}

// Retrieves the Y position of the soul in an encounter
function Encounter_GetSoulY(ID)
{
	if (Encounter_IsExists(ID))
	{
		var struct_e = global.encounter[$ ID];
		return (is_real(struct_e[$ "soul_y"]) ? struct_e[$ "soul_y"] : 454);
	}
	else
		return 454;
}