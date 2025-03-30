///@param item
function Item_IsValid(_item) {
    return is_struct(_item);
}

///@param slot
function Item_IsSlotValid(_slot) {
	return (_slot >= 0 && _slot < Item_Count() && _slot < global.inventory_capacity);
}

function Item_Count() {
	return array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM));
}

///@param item
///@param event
///@param slot
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

///@param slot
function Item_Get(_slot) {
	if (Item_IsSlotValid(_slot))
	{
		var _inventory_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM),
			_item = _inventory_temp[_slot];
		if (Item_IsValid(_item))
		{
			var _item_base = global._dictionary_item[_item.item_id];
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

///@param slot
///@param item
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

///@param item
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

///@param slot
function Item_Remove(_slot) {
	if (Item_IsValid(Item_Get(_slot)) && Item_Count() > 0)
	{
		var _inventory_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM);
		array_delete(_inventory_temp, _slot, 1);
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM, _inventory_temp);
	}
}

///@param item
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

function Player_GetArmor() {
	return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_ARMOR);
}

///@param armor
function Player_SetArmor(armor) {
	if (Item_IsValid(armor))
	{
		Flag_Set(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_ARMOR, armor);
		Player_UpdateStatsEquipment(armor);
	}
}

function Player_GetWeapon() {
	return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_WEAPON);
}

///@param weapon
function Player_SetWeapon(weapon) {
	if (Item_IsValid(weapon))
	{
		Flag_Set(FLAG_TYPE.STATIC,FLAG_STATIC.ITEM_WEAPON, weapon);
		Player_UpdateStatsEquipment(weapon);
	}
}

///@param heal
///@param [new_line]
function Item_GetTextHeal(heal, new_line = true) {
	var result =" ";
		result += (new_line ? "\n" : "");
	
	var hp = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.HP),
		hp_max = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.HP_MAX);
	
	result += (hp + heal >= hp_max) ? lexicon_text("item.heal.full") : lexicon_text("item.heal.part", heal);
	
	return result;
}

///@param name
function Item_GetTextEat(name) {
	return lexicon_text("item.eat", name);
}

///@param name
function Item_GetTextEquip(name) {
	return lexicon_text("item.equip", name);
}


