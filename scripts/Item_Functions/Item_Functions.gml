///@func Item_IsValid(item)
///@desc Return whenever the specified item struct is a valid item or not.
///@param {Struct.Item}		item		The item struct to check for validation.
///@return {Bool}
function Item_IsValid(_item) {
    return (is_struct(_item) && variable_struct_exists(_item, "is_item") && _item.is_item);
}

///@func Item_IsSlotValid(slot)
///@desc Return whenever the specified inventory slot number is valid or not.
///@param {Real}	slot	The slot number to check for validation.
///@return {Bool}
function Item_IsSlotValid(_slot) {
	return (_slot >= 0 && _slot < Item_Count() && _slot < global.inventory_capacity);
}

///@func Item_Count()
///@desc Return the amount of item in the inventory.
///@return {Real}
function Item_Count() {
	return array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM));
}

///@func Item_CallEvent(item, event, slot)
///@desc Run the specified event of the given item struct.
///@param {Struct.Item}						item		The item struct to execute the event.
///@param {Enum.ITEM_EVENT, Real}			event		The item event to execute (base on ITEM_EVENT enum or between 0 and 2).
///@param {Real}							slot		The inventory slot of the item.
function Item_CallEvent(_item, _event, _slot) {
	if (Item_IsValid(_item))
	{
	    switch (_event)
		{
			case ITEM_EVENT.USE:
				if (_item[$ "effect"] != undefined)
					if (is_callable(_item.effect))
						_item.effect(_item);
				switch (_item.type)
				{
					case ITEM_TYPE.CONSUMABLE:
						var _desc_use = "";
						if (_item[$ "desc_use_before"] != undefined)
							_desc_use += _item.desc_use_before + "\n";
					
						_desc_use += Item_GetTextEat(_item.name);
						if (_item[$ "heal"] != undefined)
						{
							audio_play_sound(snd_item_heal, 0, false);
							Player_Heal(_item.heal);
							_desc_use += "[sleep, 20]" + Item_GetTextHeal(_item.heal) + "\n";
						}
				
						if (_item[$ "desc_use_after"] != undefined)
							_desc_use += _item.desc_use_after;
					
						Dialog_Add(_desc_use);
						Dialog_Start();
								
						if (_item.uses != infinity && _item.uses > 0)
							_item.uses--;				
						if (_item.uses <= 0)
							Item_Remove(_slot);
						break;
				
					case ITEM_TYPE.EQUIPMENT:
						audio_play_sound(snd_item_equip, 0, false);
						var _desc_use = Item_GetTextEquip(_item.name),
							_type = string_lower(_item[$ "type_equipment"]);
				
						if (_type == "weapon")
						{
							Item_Set(_slot, Player_GetWeapon());
							Player_SetWeapon(_item);
						}
						else if (_type == "armor")
						{
							Item_Set(_slot, Player_GetArmor());
							Player_SetArmor(_item);
						}
				
						Dialog_Add(_desc_use);
						Dialog_Start();
						break;
				}
				break;
			case ITEM_EVENT.INFO:
				if (Item_IsSlotValid(_slot))
				{
					var _desc_info = $"* \"{_item.name}\"" + (_item[$ "desc_info"] != undefined ? (" - " + _item.desc_info) : "");
					Dialog_Add(_desc_info);
					Dialog_Start();
				}
				break;
			case ITEM_EVENT.DROP:
				if (Item_IsSlotValid(_slot))
				{
					var _rand = irandom(18), _sub = (_rand >= 0 && _rand <= 3) ? _rand + 1 : 0,		
						_desc_drop = lexicon_text($"item.drop.{_sub}", _item.name);
					Dialog_Add(_desc_drop);
					Dialog_Start();
					Item_Remove(_slot);
				}
				break;
		}
	}
}

///@func Item_Get(slot)
///@desc Return the item struct at the specified inventory slot or return -1 if the item does not exist.
///@param {Real}	slot	The inventory slot to get the item struct.
///@return {Struct.Item}
function Item_Get(_slot) {
	if (Item_IsSlotValid(_slot))
	{
		var _inventory_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM),
			_item = _inventory_temp[_slot];
		if (Item_IsValid(_item))
		{
			var _item_base = global.__dictionary_item[_item.item_id];
			with _item
			{
				if (name != _item_base.name)
					name = _item_base.name;
				else if (name_short != _item_base.name_short)
					name_short = _item_base.name_short;
				else if (name_short_serious != _item_base.name_short_serious)
					name_short_serious = _item_base.name_short_serious;
					
				else if (desc_info != _item_base.desc_info)
					desc_info = _item_base.desc_info;
				else if (desc_use_before != _item_base.desc_use_before)
					desc_use_before = _item_base.desc_use_before;
				else if (desc_use_after != _item_base.desc_use_after)
					desc_use_after = _item_base.desc_use_after;
				
				else if (heal != _item_base.heal)	heal = _item_base.heal;
				else if (atk != _item_base.atk)		atk = _item_base.atk;
				else if (def != _item_base.def)		def = _item_base.def;
				else if (spd != _item_base.spd)		spd = _item_base.spd;
				else if (inv != _item_base.inv)		inv = _item_base.inv;
				
				else
				{
					effect = _item_base.effect;
					_inventory_temp[_slot] = self;
					Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM, _inventory_temp);
				}
			}
			return _item;
		}
	    return -1;
	}
	return -1;
}

///@func Item_Set(slot, item)
///@desc Set the item struct to the specified inventory slot.
///@param {Real}			slot		The inventory slot to set the item struct to.
///@param {Struct.Item}		item		The item struct to set to the inventory slot.
function Item_Set(_slot, _item) {
	if (_slot >= 0)
	{
		var _inventory_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM);
		if (Item_IsValid(_item))
		{
			if (_slot < array_length(_inventory_temp))
				array_resize(_inventory_temp, _slot + 1);
			
			_inventory_temp[_slot] = _item;
		}
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM, _inventory_temp);
	}
}

///@func Item_Add(item)
///@desc Add an item struct to the inventory.
///@param {Struct.Item}		item	The item struct to add to the inventory.
function Item_Add(_item) {
	if (Item_IsValid(_item))
	{
		var _inventory_cap = global.inventory_capacity;
		if (Item_Count() < _inventory_cap)
		{
			var _inventory_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM);
			array_push(_inventory_temp, _item);
			Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM, _inventory_temp);
		}
	}
}

///@func Item_Remove(slot)
///@desc Remove an item struct from the specified inventory slot
///@param {Real}	slot	The inventory slot that has the item need to be removed.
function Item_Remove(_slot) {
	if (Item_IsValid(Item_Get(_slot)) && Item_Count() > 0)
	{
		var _inventory_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM);
		array_delete(_inventory_temp, _slot, 1);
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM, _inventory_temp);
	}
}

///@func Item_GetName(item)
///@desc Return the name of the specified item struct.
///@param {Struct.Item}		item	The item struct to get the name.
function Item_GetName(_item) {
	if (Item_IsValid(_item))
	{
		var _name = "";
		switch (global.item_name_mode)
		{
			case 0:
				_name = _item.name;
				break;
			case 1:
				_name = _item.name_short;
				break;
			case 2:
				_name = _item.name_short_serious;
				break;
		}
		return _name;
	}
	else
		return "";
}

///@func Player_UpdateStatsEquipment(item)
///@desc Update player equipment stats from specified item struct.
function Player_UpdateStatsEquipment(_item) {
	if (_item[$ "atk"] != undefined)
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ATK_ITEM, _item.atk);
	if (_item[$ "def"] != undefined)
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.DEF_ITEM, _item.def);
	if (_item[$ "spd"] != undefined)
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.SPD_ITEM, _item.spd);
	if (_item[$ "inv"] != undefined)
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.INV_ITEM, _item.inv);
}

///@func Player_GetArmor()
///@desc Return the armor item struct that's currently equipped.
///@return {Struct.Item}
function Player_GetArmor() {
	return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_ARMOR);
}

///@func Player_SetArmor(armor)
///@desc Equip the specified armor item struct.
///@param {Struct.Item}		armor		The armor item struct to equip.
function Player_SetArmor(_armor) {
	if (Item_IsValid(_armor))
	{
		Flag_Set(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_ARMOR, _armor);
		Player_UpdateStatsEquipment(_armor);
	}
}

///@func Player_GetWeapon()
///@desc Return the weapon item struct that's currently equipped.
///@return {Struct.Item}
function Player_GetWeapon() {
	return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_WEAPON);
}

///@func Player_SetWeapon(weapon)
///@desc Equip the specified weapon item struct.
///@param {Struct.Item}		weapon		The weapon item struct to equip.
function Player_SetWeapon(weapon) {
	if (Item_IsValid(weapon))
	{
		Flag_Set(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_WEAPON, weapon);
		Player_UpdateStatsEquipment(weapon);
	}
}

///@func Item_GetTextHeal(heal, [new_line])
///@desc Return the healing dialog base on the specified amount of HP.
///		 [Your HP was maxed out.] if the heal can fully recover HP or
///		 [You recovered x HP.] if the heal can only recover the x amount of HP.
///@param {Real}	heal			The amount of heal of the item.
///@param {Bool}	[new_line]		Whenever the healing dialog will go down to the new line. (Default: true)
///@return {String}
function Item_GetTextHeal(_heal, _new_line = true) {
	var _result =" ";
		_result += (_new_line ? "\n" : "");
	
	var _hp = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.HP),
		_hp_max = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.HP_MAX);
	
	_result += (_hp >= _hp_max) ? lexicon_text("item.heal.full") : lexicon_text("item.heal.part", _heal);
	
	return _result;
}

///@func Item_GetTextEat(name)
///@desc Return the item consume dialog with the item's name along.
///@param {String}		name	The name of the item.
///@return {String}
function Item_GetTextEat(_name) {
	return lexicon_text("item.eat", _name);
}

///@func Item_GetTextEquip(name)
///@desc Return the item equip dialog with the item's name along.
///@param {String}		name	The name of the item.
///@return {String}
function Item_GetTextEquip(_name) {
	return lexicon_text("item.equip", _name);
}


