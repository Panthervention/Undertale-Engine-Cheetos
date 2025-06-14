///@func Flag_Init()
///@desc Initializes the flag system
function Flag_Init() {
    global.__flag = {};
    Flag_Define();
}

///@func Flag_Uninit()
///@desc Uninitializes the flag system
function Flag_Uninit() {
    global.__flag = undefined; // Allow garbage collection
}

///@func Flag_Save(type)
///@desc Saves flag data to corresponding file.
///@param {Enum.FLAG_TYPE, Real}	flag_type	The flag type to save the data (base on FLAG_TYPE enum of between 0 to 4).
function Flag_Save(_type) {
	var _path = Flag_GetSavePath(_type)
    var _string = Flag_GetRawData(_type),
        _string_size = string_byte_length(_string) + 1;
    
    var _buffer = buffer_create(_string_size, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, _path);
    buffer_delete(_buffer);

    show_debug_message($"CHEETOS: Flag type {_type} saved to {_path}.");
}

///@func Flag_Load(type)
///@desc Loads flag data from corresponding file.
///@param {Enum.FLAG_TYPE, Real}	flag_type	The flag type to load the data (base on FLAG_TYPE enum of between 0 to 4).
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

///@func Flag_Get(type, entry, [value_default])
///@desc Retrieve a specific flag value from its file.
///@param {Enum.FLAG_TYPE, Real}	flag_type		The flag type to retrieve the data from (base on FLAG_TYPE enum of between 0 to 4).
///@param {Real}					flag_entry		The flag entry to retrieve the data from (ex: FLAG_STATIC.HP).
///@param {Any}					[val_default]	The default value to return in case the data entry does not exist.
///@return {Any}
// feather ignore once GM1045
// Real is part of Any
function Flag_Get(_type, _entry, _value_default = 0) {
    var struct = global.__flag;
    if (struct[$ _type] != undefined) 
    {
        var struct_f = struct[$ _type];
        if (struct_f[$ _entry] != undefined)
            return struct_f[$ _entry];
        else
            return _value_default;
    }
    else
        return _value_default;
}

///@func Flag_Set(type, entry, value)
///@desc Set a value to a specific flag entry.
///@param {Enum.FLAG_TYPE, Real}	flag_type	The flag type to set the data to (base on FLAG_TYPE enum of between 0 to 4).
///@param {Real}					flag_entry	The flag entry to set the data to (ex: FLAG_STATIC.HP).
///@param {Any}						val			The value to assign to the flag entry.
function Flag_Set(_type, _entry, _value) {
    global.__flag[$ _type] ??= {}; 
    global.__flag[$ _type][$ _entry] = _value; // Set the value directly
}

///@func Flag_GetSavePath(type)
///@desc Get the path for saving the flag data.
///@param {Enum.FLAG_TYPE, Real}	flag_type	The flag type to retrieve the path (base on FLAG_TYPE enum of between 0 to 4).
///@return {String}
function Flag_GetSavePath(_type) {
    var _path = $"./savefiles/",
		_timeline = Flag_GetSaveSlot();
    switch (_type)
    {
        case FLAG_TYPE.STATIC:
            _path += $"timeline {_timeline}/static.save";	break;
        case FLAG_TYPE.DYNAMIC:
            _path += $"timeline {_timeline}/dynamic.save";	break;
        case FLAG_TYPE.INFO:
            _path += $"timeline {_timeline}/info.save";		break;
        case FLAG_TYPE.SETTINGS:
            _path += "settings.save";						break;
        default:
            _path = "";										break;
    }
    return _path;
}

///@func Flag_GetSaveSlot()
///@desc Get the current save slot.
///@return {Real}
function Flag_GetSaveSlot() {
    return Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.SAVE_SLOT);
}

///@func Flag_SetSaveSlot(slot)
///@desc Set the current save slot.
///@param {Real}	slot	The number of the save slot.
function Flag_SetSaveSlot(_slot) {
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.SAVE_SLOT, _slot);
}

///@func Flag_Clear(type)
///@desc Clear all data of specified flag type.
///@param {Enum.FLAG_TYPE, Real}	flag_type	The flag type to clear the data (base on FLAG_TYPE enum of between 0 to 4).
function Flag_Clear(_type) {
    if (global.__flag[$ _type] != undefined)
        global.__flag[$ _type] = {}; // Reset the struct directly
}

///@func Flag_GetRawData(type)
///@desc Retrieve raw JSON data from specified flag type.
///@param {Enum.FLAG_TYPE, Real}	flag_type	The flag type to retrieve the raw data (base on FLAG_TYPE enum of between 0 to 4).
///@return {String}
function Flag_GetRawData(_type) {
    global.__flag[$ _type] ??= {}; // Ensure the type exists
    return SnapToJSON(global.__flag[$ _type]);
}

///@func Flag_SetRawData(type, raw)
///@desc Set raw data to specified flag type.
///@param {Enum.FLAG_TYPE, Real}	flag_type	The flag type to assign the raw data (base on FLAG_TYPE enum of between 0 to 4).
///@param {Any}		flag_data	The raw data to assign.
function Flag_SetRawData(_type, _raw) {
    global.__flag[$ _type] = _raw; // Directly update the struct in global.__flag
}