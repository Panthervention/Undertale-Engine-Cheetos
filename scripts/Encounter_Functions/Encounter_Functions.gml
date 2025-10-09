///@func Encounter_Init()
///@desc Initialize the encounter system.
function Encounter_Init() {
    global.__encounter = {};
    Encounter_Store_Load();
}

///@func Encounter_Uninit()
///@desc Uninitialize the encounter system.
function Encounter_Uninit() {
    global.__encounter = undefined; // Clear the global struct to allow garbage collection
}

///@func Encounter_Set(encounter_id, enemy_0, enemy_1, enemy_2, menu_dialog, [fleeable], [quick], [soul_x], [soul_y]) 
///@desc Set the properties for a specific encounter ID preset.
///@param {Real}								encounter_id	The ID number of this encounter preset (must be equal or greater than 0).
///@param {Asset.GMObject, Id.Instance}			enemy_0			The enemy object (or id instance of the enemy [NOT RECOMMENDED!]) on the left.
///@param {Asset.GMObject, Id.Instance}			enemy_1			The enemy object (or id instance of the enemy [NOT RECOMMENDED!]) at the center.
///@param {Asset.GMObject, Id.Instance}			enemy_2			The enemy object (or id instance of the enemy [NOT RECOMMENDED!]) on the right.
///@param {String}								menu_dialog		The (initial) dialog of the menu.
///@param {Bool}								[fleeable]		Whenever the player can flee or not. (Default: true)
///@param {Bool}								[quick]			Whenever when the encounter exclaimation animation is quick or not. (Default: false)
///@param {Real}								[soul_x]		The initial soul's x coordinate in the battle. (Default: 48)
///@param {Real}								[soul_y]		The initial soul's y coordinate in the battle. (Default: 454)
function Encounter_Set(_encounter_id, _enemy_0, _enemy_1, _enemy_2, _menu_dialog, _fleeable = true, _quick = false, _soul_x = 48, _soul_y = 454) {
	if (_encounter_id < 0)
		exit;
	
    if (global.__encounter[$ _encounter_id] == undefined)
        global.__encounter[$ _encounter_id] = {};

    var _struct_encounter = global.__encounter[$ _encounter_id];
	with (_struct_encounter)
	{
		enemy_0 = _enemy_0;
		enemy_1 = _enemy_1;
		enemy_2 = _enemy_2;
		menu_dialog = _menu_dialog;
		menu_mercy_flee_enabled = _fleeable;
		quick = _quick;
		soul_x = _soul_x;
		soul_y = _soul_y;
	}
}

///@func Encounter_Start(encounter_id, [animation], [exclamation])
///@desc Start an encounter with the given ID preset.
///@param {Real}	encounter_id	The ID number of the encounter preset to start (must be equal or greater than 0).
///@param {Bool}	[animation]		Whenever there will be encounter start animation.		
///@param {Bool}	[exclamation]	Whenever there will be a [!] or [=))] sprite above the player character.
function Encounter_Start(_encounter_id, _animation = true, _exclamation = true) {
    if (Encounter_Exists(_encounter_id))
    {
        if (!instance_exists(obj_char_player))
            _animation = false;

        if (!_animation)
        {
            Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.ENCOUNTER, _encounter_id);
            if (!Player_IsInBattle())
            {
                Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.BATTLE_ROOM_RETURN, room);
                room_persistent = true;
            }
            room_goto(room_battle);
        }
        else
        {
            var _encounter_anim = instance_create_depth(0, 0, 0, obj_encounter_anim);
			with (_encounter_anim)
			{
				__encounter = _encounter_id;
				__exclaim = _exclamation;
				__quick = Encounter_IsQuick(_encounter_id);
				__soul_x = Encounter_GetSoulX(_encounter_id);
				__soul_y = Encounter_GetSoulY(_encounter_id);
			}
        }
    }
    else
        show_debug_message($"CHEETOS: Encounter ID {_encounter_id} doesn't exists!");
}

///@func Encounter_GetEnemy(encounter_id, enemy_slot)
///@desc Return enemy id instance from an encounter preset or return -1 if the specified enemy slot doesn't have any enemy.
///@param {Real}	encounter_id	The ID number of the encounter preset to get the enemy id instance (must be equal or greater than 0).
///@param {Real}	enemy_slot		The enemy slot to get the id instance (between 0 and 2).
///@return {Id.Instance}
function Encounter_GetEnemy(_encounter_id, _enemy_slot) {
    if (Encounter_Exists(_encounter_id) && Battle_IsEnemySlotValid(_enemy_slot))
    {
        var _struct_encounter = global.__encounter[$ _encounter_id];      
        return (object_exists(_struct_encounter[$ $"enemy_{_enemy_slot}"]) ? _struct_encounter[$ $"enemy_{_enemy_slot}"] : -1);
    }
    else
        return -1;
}

///@func Encounter_GetMenuDialog(encounter_id)
///@desc Return the menu dialog for an encounter preset.
///@param {Real}	encounter_id	The ID number of the encounter preset to get the menu dialog (must be equal or greater than 0).
///@return {String}
function Encounter_GetMenuDialog(_encounter_id) {
    if (Encounter_Exists(_encounter_id))
    {
        var _struct_encounter = global.__encounter[$ _encounter_id];
        return (is_string(_struct_encounter[$ "menu_dialog"]) ? _struct_encounter[$ "menu_dialog"] : "");
    }
    else
        return "";
}

///@func Encounter_IsMenuMercyFleeEnabled(encounter_id)
///@desc Return whenever if mercy or flee options are enabled for an encounter preset.
///@param {Real}	encounter_id	The ID number of the encounter preset to check whenever the flee option is enabled or not (must be equal or greater than 0).
///@return {Bool}
function Encounter_IsMenuMercyFleeEnabled(_encounter_id) {
    if (Encounter_Exists(_encounter_id))
    {
        var _struct_encounter = global.__encounter[$ _encounter_id];
        return (is_real(_struct_encounter[$ "menu_mercy_flee_enabled"]) ? _struct_encounter[$ "menu_mercy_flee_enabled"] : true);
    }
    else
        return true;
}

///@func Encounter_IsQuick(encounter_id)
///@desc Check if the encounter animation of an encounter preset is marked as quick or not.
///@param {Real}	encounter_id	The ID number of the encounter preset to check whenever the encounter animation is marked as quick or not (must be equal or greater than 0).
///@return {Bool}
function Encounter_IsQuick(_encounter_id) {
    if (Encounter_Exists(_encounter_id))
    {
        var _struct_encounter = global.__encounter[$ _encounter_id];
        return (is_bool(_struct_encounter[$ "quick"]) ? _struct_encounter[$ "quick"] : false);
    }
    else
        return false;
}

///@func Encounter_GetSoulX(encounter_id) 
///@desc Return the initial x coordinate of the soul in the battle of an encounter preset.
///@param {Real}	encounter_id	The ID number of the encounter preset to get the initial x coordinate of the soul in the battle (must be equal or greater than 0).
///@return {Real}
function Encounter_GetSoulX(_encounter_id) {
    if (Encounter_Exists(_encounter_id))
    {
        var _struct_encounter = global.__encounter[$ _encounter_id];
        return (is_real(_struct_encounter[$ "soul_x"]) ? _struct_encounter[$ "soul_x"] : 48);
	}
	else
		return 48;
}

///@func Encounter_GetSoulY(encounter_id) 
///@desc Return the initial y coordinate of the soul in the battle of an encounter preset.
///@param {Real}	encounter_id	The ID number of the encounter preset to get the initial y coordinate of the soul in the battle (must be equal or greater than 0).
///@return {Real}
function Encounter_GetSoulY(_encounter_id) {
	if (Encounter_Exists(_encounter_id))
	{
		var _struct_encounter = global.__encounter[$ _encounter_id];
		return (is_real(_struct_encounter[$ "soul_y"]) ? _struct_encounter[$ "soul_y"] : 454);
	}
	else
		return 454;
}

///@func Encounter_Exists(encounter_id)
///@desc Check if an encounter preset exists.
///@param {Real}	encounter_id	The ID number of the encounter preset to check if it exists (must be equal or greater than 0).
///@return {Bool}
function Encounter_Exists(_encounter_id) {
    return (global.__encounter[$ _encounter_id] != undefined);
}