function Box_IsBoxSlotValid(_box_slot) {
	return (_box_slot >= 0 && _box_slot < array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX)));
}

function Box_ItemAdd(_box_slot, _item) {
	if (Item_IsValid(_item))
	{
		var _box_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX, []);
		if (!Box_IsBoxSlotValid(_box_slot))
			array_resize(_box_temp, _box_slot + 1);
		if (!is_array(_box_temp[_box_slot]))
			_box_temp[_box_slot] = [];
		if (Box_ItemCount(_box_slot) < 10)
			array_push(_box_temp[_box_slot], _item);
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.BOX, _box_temp);
	}
}

function Box_ItemRemove(_box_slot, _slot) {
	if (Box_IsBoxSlotValid(_box_slot))
	{
		if (Item_IsValid(Box_ItemGet(_box_slot, _slot)))
		{
			var _box_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX);
			if (Box_ItemCount(_box_slot) > 0)
				array_delete(_box_temp[_box_slot], _slot, 1);
			if (Box_ItemCount(_box_slot) <= 0)
				array_delete(_box_temp, _box_slot, 1);
			Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.BOX, _box_temp);
		}
	}
}

function Box_ItemGet(_box_slot, _slot) {
	if (Box_IsBoxSlotValid(_box_slot))
	{
		if (_slot >= 0 && _slot < Box_ItemCount(_box_slot))
			return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX)[_box_slot][_slot];
		return -1;
	}
	return -1;
}

function Box_ItemCount(_box_slot) {
	if (Box_IsBoxSlotValid(_box_slot))
		return array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX)[_box_slot]);
	else
		return 0;
}
