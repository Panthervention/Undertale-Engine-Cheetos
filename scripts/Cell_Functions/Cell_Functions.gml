///@func Cell_IsValid(cell)
///@desc Return whenever the specified cell address struct is a valid cell or not.
///@param {Struct.Cell}		cell	The cell address struct to check for validation.
///@return {Bool}
function Cell_IsValid(_cell) {
	return is_instanceof(_cell, Cell);
}

///@func Cell_IsAddressValid(address)
///@desc Return whenever the specified cell address number is a valid address.
///@param {Real}	address		The cell address number to check for validation.
///@return {Bool}
function Cell_IsAddressValid(_address) {
	return (_address >= 0 && _address < Cell_AddressCount() && _address < 8);
}

///@func Cell_AddressCount()
///@desc Return the amount of cell address currently available.
///@return {Real}
function Cell_AddressCount() {
	return array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL));
}

///@func Cell_CallEvent(_cell, _event, _address)
///@desc Run the specified event of the given cell address struct.
///@param {Struct.Cell}		cell		The cell address struct to execute the event.
///@param {Real}			event		The cell address event to execute (base on CELL_EVENT enum or 0 because there is only 1 event by now).
///@param {Real}			address		The number of the cell address.
function Cell_CallEvent(_cell, _event, _address) {
	if (Cell_IsValid(_cell))
	{
		switch (_event)
		{
			case CELL_EVENT.CALL:
				if (_cell[$ "event"] != undefined)
					if (is_callable(_cell.event))
						_cell.event(_cell);
				if (_cell[$ "dialog"] != undefined)
				{
					audio_play_sound(snd_phone_call, 0, false);
					Dialog_Add(_cell.dialog);
					Dialog_Start();
				}
				break;
		}
	}
}

///@func Cell_GetAdress(address)
///@desc Return the cell address struct at the specified address number or return -1 if the cell address does not exist.
///@param {Real}	address		The address number to get the cell address struct.
///@return {Struct.Cell}
function Cell_GetAdress(_address) {
	if (Cell_IsAddressValid(_address))
	{
		var _cell = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL)[_address];
		if (Cell_IsValid(_cell))
		{
			var _cell_base = global.__dictionary_cell[_cell.address];
			with (_cell)
			{
				if (name != _cell_base.name)
					name = _cell_base.name;
				if (dialog != _cell_base.dialog)
					dialog = _cell_base; // Not sure, requires further condition inspect!
				event = _cell_base.event;
			}
			return _cell;
		}
		return -1;
	}
	else
		return -1;
}

///@func Cell_SetAddress(address, cell)
///@desc Set the cell address struct at the specified address number.
///@param {Real}			address		The address number to assign the cell address struct.
///@param {Struct.Cell}		cell		The cell address struct need to be assigned.
function Cell_SetAddress(_address, _cell) {
	if (_address >= 0)
	{
		var _cell_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, []);
		if (Cell_IsValid(_cell))
		{
			if (_address < array_length(_cell_temp))
				array_resize(_cell_temp, _address + 1);
			_cell_temp[_address] = _cell;
		}
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, _cell_temp);
	}
}

///@func Cell_AddAddress(cell)
///@desc Add the cell address struct to the address list.
///@param {Struct.Cell}		cell		The cell address struct need to be added.
function Cell_AddAddress(_cell) {
	if (Cell_IsValid(_cell))
	{
		if (Cell_AddressCount() < 8)
		{
			var _cell_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, []);
			array_push(_cell_temp, _cell);
			Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, _cell_temp);
		}
	}
}

///@func Cell_DeleteAddress(address)
///@desc Remove the cell address struct from the address list.
///@param {Real}	address		The address number to remove toe cell address struct.
function Cell_DeleteAddress(_address) {
	if (Cell_IsValid(Cell_GetAdress(_address)) && Cell_AddressCount() > 0)
	{
		var _cell_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, []);
		array_delete(_cell_temp, _address, 1);
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, _cell_temp);
	}
}

///@func Cell_GetName(cell)
///@desc Return the name of the cell address struct.
///@param {Struct.Cell}		cell		The cell address struct need to get the name.
///@return {String}
function Cell_GetName(_cell) {
	return (Cell_IsValid(_cell)) ? ((_cell[$ "name"] != undefined) ? _cell.name : "") : "";
}
