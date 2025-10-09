var _input_vertical = PRESS_VERTICAL,
	_input_horizontal = PRESS_HORIZONTAL,
	_input_confirm = PRESS_CONFIRM,
	_input_cancel = PRESS_CANCEL;
	
if (_input_vertical < 0 && __choice_item > 0)
	__choice_item--;
else if (_input_vertical > 0 && ((__choice_mode == 0 && __choice_item < 7) || 
		(__choice_mode == 1 && __choice_item < 9)))
	__choice_item++;

if (_input_horizontal != 0)
{
	__choice_mode = (_input_horizontal > 0) ? 1 : 0;
	if (__choice_mode == 0 && __choice_item > 7)
	    __choice_item = 7;
}
else if (_input_confirm)
{
	if (__choice_mode == 0)
	{
		var _target = Item_Get(__choice_item);
		if (Item_IsValid(_target) && Box_ItemCount(__box_slot) < 10)
		{
			Item_Remove(__choice_item);
			Box_ItemAdd(__box_slot, _target);
		}
	}
	else
	{
		var _target = Box_ItemGet(__box_slot, __choice_item);
		if (Item_IsValid(_target) && Item_Count() < 8)
		{
			Item_Add(_target);
		    Box_ItemRemove(__box_slot, __choice_item);
		}
	}
}
else if (_input_cancel)
	instance_destroy();
	