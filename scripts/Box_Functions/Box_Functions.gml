///@func Box_IsBoxSlotValid(box_slot)
///@desc Return whenever the box slot is valid or not.
///@param {Real}	box_slot	The slot number to check for validation.
///@return {Bool}
function Box_IsBoxSlotValid(_box_slot) {
	return (_box_slot >= 0 && _box_slot < array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX)));
}

///@func Box_ItemAdd(box_slot, item)
///@desc Add item struct to the box.
///@param {Real}			box_slot	The box slot number to use.
///@param {Struct.Item}		item		The item to add to the box.
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

///@func Box_ItemRemove(box_slot, slot)
///@desc Remove the item struct from the given box slot at the specified slot number in that box.
///@param {Real}	box_slot	The box slot number.
///@param {Real}	slot		The slot number in the box.
function Box_ItemRemove(_box_slot, _slot) {
	if (Box_IsBoxSlotValid(_box_slot))
	{
		if (Item_IsValid(Box_ItemGet(_box_slot, _slot)))
		{
			var _box_temp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX);
			if (Box_ItemCount(_box_slot) > 0)
				array_delete(_box_temp[_box_slot], _slot, 1);
			Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.BOX, _box_temp);
		}
	}
}
// Feather ignore GM1045
///@func Box_ItemGet(box_slot, slot)
///@desc Return the item struct from the given box slot at the specified slot number in that box.
///@param {Real}	box_slot	The box slot number.
///@param {Real}	slot		The slot number in the box.
///@return {Struct.Item, Real}
function Box_ItemGet(_box_slot, _slot) {
	if (Box_IsBoxSlotValid(_box_slot))
	{
		if (_slot >= 0 && _slot < Box_ItemCount(_box_slot))
			return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX)[_box_slot][_slot];
		return -1;
	}
	return -1;
}

///@func Box_ItemCount(box_slot)
///@desc Return the amount of item in the specified box slot.
///@param {Real}	box_slot	The slot number to get the amount of item.
///@return {Real}
function Box_ItemCount(_box_slot) {
	return (Box_IsBoxSlotValid(_box_slot)) ? array_length(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BOX)[_box_slot]) : 0;
}
