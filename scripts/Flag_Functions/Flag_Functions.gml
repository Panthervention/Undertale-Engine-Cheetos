// Initializes the flag system
function Flag_Init() {
    global.__flag = {};
    Flag_Custom();
	return true;
}

// Uninitializes the flag system
function Flag_Uninit() {
    global.__flag = undefined; // Allow garbage collection
    return true;
}

// Saves flag data to respective file
///@param flag_type
function Flag_Save(_type) {
	var _path = Flag_GetSavePath(_type)
    var _string = Flag_GetRawData(_type),
        _string_size = string_byte_length(_string) + 1;
    
    var _buffer = buffer_create(_string_size, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, _path);
    buffer_delete(_buffer);

    show_debug_message($"CHEETOS: Flag type {_type} saved to {_path}.");

    return true;
}

// Loads flag data from a file
///@param flag_type
function Flag_Load(_type) {
	var _path = Flag_GetSavePath(_type);
	
	if (!file_exists(_path))
	{
        show_debug_message($"CHEETOS: Attempted to load flag type {_type} from non-existing file {_path}!");
        exit;
    }
	
    var _buffer = buffer_load(_path);
    var _string = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    
    var _data = SnapFromJSON(_string);
    Flag_SetRawData(_type, _data);

    show_debug_message($"CHEETOS: Flag loaded from {_path}.");
}

// Retrieves a specific flag value from its file
///@param flag_type
///@param flag_slot
///@param val_default
function Flag_Get(_type, _slot, _value_default = 0) {
    var struct = global.__flag;
    if (struct[$ _type] != undefined) 
    {
        var struct_f = struct[$ _type];
        if (struct_f[$ _slot] != undefined)
            return struct_f[$ _slot];
        else
            return _value_default;
    }
    else
        return _value_default;
}

// Sets a specific flag value
///@param flag_type
///@param flag_slot
///@param val
function Flag_Set(_type, _slot, _value) {
    global.__flag[$ _type] ??= {};
    
    global.__flag[$ _type][$ _slot] = _value; // Set the value directly
}

// Gets the path for saving the flag data
///@param flag_type
function Flag_GetSavePath(_type) {
    var result = $"./savefiles/",
		timeline = Flag_GetSaveSlot();
    switch (_type)
    {
        case FLAG_TYPE.STATIC:
            result += $"timeline {timeline}/static.save";
            break;
        case FLAG_TYPE.DYNAMIC:
            result += $"timeline {timeline}/dynamic.save";
            break;
        case FLAG_TYPE.INFO:
            result += $"timeline {timeline}/info.save";
            break;
        case FLAG_TYPE.SETTINGS:
            result += "settings.save";
            break;
        default:
            result = "";
            break;
    }
    return result;
}

// Gets the current save slot
function Flag_GetSaveSlot() {
    return Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.SAVE_SLOT);
}

// Sets the current save slot
///@param save_slot
function Flag_SetSaveSlot(_slot) {
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.SAVE_SLOT, _slot);
}

// Clears all data for a specific flag type
///@param flag_type
function Flag_Clear(_type) {
    if (global.__flag[$ _type] != undefined)
        global.__flag[$ _type] = {}; // Reset the struct directly
}

// Retrieves raw JSON data for a flag type
///@param flag_type
function Flag_GetRawData(_type) {
    global.__flag[$ _type] ??= {}; // Ensure the type exists
    return SnapToJSON(global.__flag[$ _type]);
}

// Sets raw data for a flag type
///@param flag_type
///@param flag_data
function Flag_SetRawData(_type, _raw) {
    global.__flag[$ _type] = _raw; // Directly update the struct in global.__flag
}