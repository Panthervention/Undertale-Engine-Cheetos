var input_vertical = PRESS_VERTICAL,
	input_horizontal = PRESS_HORIZONTAL,
	input_confirm = PRESS_CONFIRM,
	input_cancel = PRESS_CANCEL;
	
if (input_vertical < 0 && _choice_item > 0)
	_choice_item -= 1;
else if (input_vertical > 0 && ((_choice_mode == 0 && _choice_item < 7) || 
		(_choice_mode == 1 && _choice_item < 9)))
	_choice_item += 1;

if (input_horizontal != 0)
{
	_choice_mode = (input_horizontal > 0) ? 1 : 0;
	if (_choice_mode == 0 && _choice_item > 7)
	    _choice_item = 7;
}
else if (input_confirm)
{
	if (_choice_mode == 0)
	{
		var target = Item_Get(_choice_item);
		if (Item_IsValid(target) && Box_ItemCount(_box_slot) < 10)
		{
			Item_Remove(_choice_item);
			Box_ItemAdd(_box_slot, target);
			event_user(0); // Update item label
		}
	}
	else
	{
		var target = Box_ItemGet(_box_slot, _choice_item);
		if (Item_IsValid(target) && Item_Count() < 8)
		{
			Item_Add(target);
		    Box_ItemRemove(_box_slot, _choice_item);
			event_user(0); // Update item label
		}
	}
}
else if (input_cancel)
	instance_destroy();
	