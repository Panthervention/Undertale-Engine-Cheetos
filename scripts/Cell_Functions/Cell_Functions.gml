///@arg cell
function Cell_IsValid(_cell) {
	return is_struct(_cell);
}

///@arg address
function Cell_IsAddressValid(_address) {
	return (_address >= 0 && _address < Cell_AddressCount() && _address < 8);
}

function Cell_AddressCount() {
	return array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL));
}

///@arg cell
///@arg event
///@arg address
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

///@arg address
function Cell_GetAdress(_address) {
	if (Cell_IsAddressValid(_address))
	{
		var _cell = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL)[_address];
		if (Cell_IsValid(_cell))
		{
			var _cell_base = global._dictionary_cell[_cell.address];
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

///@arg address
///@arg cell
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

///@arg cell
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

///@arg address
function Cell_DeleteAddress(_address) {
	if (Cell_IsValid(Cell_GetAdress(_address)) && Cell_AddressCount() > 0)
	{
		var _cell_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, []);
		array_delete(_cell_temp, _address, 1);
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.CELL, _cell_temp);
	}
}

///@arg cell
function Cell_GetName(_cell) {
	if (Cell_IsValid(_cell))
		return (_cell[$ "name"] != undefined) ? _cell.name : "";
	else
		return "";
}
