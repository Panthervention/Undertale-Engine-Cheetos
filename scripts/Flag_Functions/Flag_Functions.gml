//Sorry just had to revert the flag system :L


function Flag_Init()
{
	global._flag = ds_map_create();
	global._flag2 = {};
	Flag_Custom();
	return true;
}

function Flag_Uninit()
{
	var map = global._flag;
	while (!ds_map_empty(map))
	{
	    var key = ds_map_find_first(map);
	    var map_f = ds_map_find_value(map, key);
	    ds_map_destroy(map_f);
	    ds_map_delete(map, key);
	}
	ds_map_destroy(map);
	return true;
}

///@arg type
///@arg [path]
function Flag_Save(TYPE, PATH = "") 
{
	
	if (PATH == "")
	    PATH = Flag_GetSavePath(TYPE);

	var str = Flag_GetRaw(TYPE);
	edit_registry("string", __CHEETOS_REGISTRY + string(PATH), string(TYPE), string(str))

	show_debug_message("Flag type " + string(TYPE) + " saved to \"" + PATH + "\".");

	return true;
}

///@arg type
///@arg [path]
function Flag_Load(TYPE, PATH = "")
{
	if (PATH == "")
		PATH = Flag_GetSavePath(TYPE);

	var read = read_registry_key(__CHEETOS_REGISTRY + string(PATH))
	if !(read)
	{
		show_debug_message("The " + string(TYPE) + " type registry from " + string(PATH) + " was not found.");
		return false;
	}

	var str = read_registry(__CHEETOS_REGISTRY + string(Flag_GetSavePath(TYPE)), string(TYPE), "string")
	
	Flag_SetRaw(TYPE, str);

	show_debug_message("Flag loaded from \"" + PATH + "\".");

	return true;
}

///@arg type
///@arg slot
///@arg [default]
function Flag_Get(TYPE, SLOT, DEFAULT = 0)
{
	if is_struct(global._flag)
	{
		var struct = global._flag;
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
	else
	{
		var map = global._flag;
		if (ds_map_exists(map, TYPE))
		{
		    var map_f = ds_map_find_value(map, TYPE);
		    if (ds_map_exists(map_f, SLOT))
		    {
		        var result = ds_map_find_value(map_f, SLOT);
		        return result;
		    }
		    else
		        return DEFAULT;
		}
		else
		    return DEFAULT;
	}
}

///@arg type
///@arg slot
///@arg value
function Flag_Set(TYPE, SLOT, VALUE)
{
	if is_struct(global._flag)
	{
		global._flag[$ _type] ??= {};
    
	    global._flag[$ _type][$ _slot] = _value; // Set the value directly
		return true;
	
	}
	else
	{
		var map = global._flag;
		var map_f = -1;
		if (ds_map_exists(map, TYPE))
		    map_f = ds_map_find_value(map, TYPE);
		else
		{
		    map_f = ds_map_create();
		    ds_map_add(map, TYPE, map_f);
		}

		ds_map_replace(map_f, SLOT, VALUE);
		return true;
	}
}

///@arg type
function Flag_GetSavePath(TYPE)
{
	var result = "SOFTWARE\\" + __CHEETOS_GAME_NAME + "\\flag\\";
	switch (TYPE)
	{
	    case FLAG_TYPE.STATIC:
	        result += string(Flag_GetSaveSlot()) + "\\static";
	        break;
	    case FLAG_TYPE.DYNAMIC:
	        result += string(Flag_GetSaveSlot()) + "\\dynamic";
	        break;
	    case FLAG_TYPE.INFO:
	        result += string(Flag_GetSaveSlot()) + "\\info";
	        break;
	    case FLAG_TYPE.SETTINGS:
	        result += "\\settings";
	        break;
	    default:
	        result = "";
	        break;
	}
	return read_registry_key(result);
}

function Flag_GetSaveSlot()
{
	var result = Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.SAVE_SLOT);
	return result;
}

///@arg slot
function Flag_SetSaveSlot(SLOT)
{
	Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.SAVE_SLOT, SLOT);
	return true;
}

///@arg type
function Flag_Clear(TYPE)
{
	var map = global._flag;
	var map_f = -1;
	if (ds_map_exists(map, TYPE))
	{
	    map_f = ds_map_find_value(map, TYPE);
	    ds_map_clear(map_f);
	    return true;
	}
	else
	    return false;
}

///@arg type
function Flag_GetRaw(TYPE)
{
	var map = global._flag;
	var map_f = -1;
	if (ds_map_exists(map, TYPE))
	    map_f = ds_map_find_value(map, TYPE);
	else
	{
	    map_f = ds_map_create();
	    ds_map_add(map, TYPE, map_f);
	}

	var str = ds_map_write(map_f);

	return str;
}

///@arg type
///@arg raw
function Flag_SetRaw(TYPE, RAW)
{
	var map = global._flag;
	var map_f = -1;
	if (ds_map_exists(map, TYPE))
	{
	    map_f = ds_map_find_value(map, TYPE);
	    ds_map_clear(map_f);
	}
	else
	{
	    map_f = ds_map_create();
	    ds_map_add(map, TYPE, map_f);
	}

	ds_map_read(map_f, RAW);

	return true;
}

