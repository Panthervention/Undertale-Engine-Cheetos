var _input_vertical = PRESS_VERTICAL,
	_input_horizontal = PRESS_HORIZONTAL,
	_input_confirm = PRESS_CONFIRM,
	_input_cancel = PRESS_CANCEL,
	_input_menu = PRESS_MENU;
if (instance_exists(obj_ui_dialog) && __menu != -1)
    __menu = -1;
else if (__menu == -1 && !instance_exists(obj_ui_dialog))
    instance_destroy();

switch (__menu)
{
    case 0:
        // Main menu navigation
        if (abs(_input_vertical) == 1)
        {
            var check = Cell_AddressCount() > 0 ? 2 : 1;
            __choice = posmod(__choice + _input_vertical, check + 1);
            audio_play_sound(snd_menu_switch, 0, false);
        }
        else if (_input_confirm)
        {
            if (_choice == 0)
				__menu = (Item_Count() > 0) ? 1 : 0;
            else
				__menu = _choice + 2;    
            audio_play_sound(snd_menu_confirm, 0, false);
        }
		else if (_input_menu || _input_cancel)
			instance_destroy();
        break;
    case 1:
        // Item selection
        if (abs(_input_vertical) == 1)
        {
            __choice_item = posmod(__choice_item + _input_vertical, Item_Count());
            audio_play_sound(snd_menu_switch, 0, false);
        }
        else if (_input_confirm)
        {
            __menu = 2;      
            audio_play_sound(snd_menu_confirm, 0, false);
        }
        else if (_input_cancel)
            __menu = 0;
        break;
    case 2:
        // Item operation
        if (abs(_input_horizontal) == 1)
        {
            __choice_item_operation = posmod(__choice_item_operation + _input_horizontal, 3);
            audio_play_sound(snd_menu_switch, 0, false);
        }
        else if (_input_confirm)
        {
            __menu = -1;       
            Item_CallEvent(Item_Get(__choice_item), ITEM_EVENT.USE + __choice_item_operation, __choice_item);
            audio_play_sound(snd_menu_confirm, 0, false);
        }
        else if (_input_cancel)
            __menu = 1;
        break;
    case 3:
    case 4:
        // Phone menu and other menus with simple navigation
        if (__menu == 4 && abs(_input_vertical) == 1)
        {
            __choice_cell = posmod(__choice_cell + _input_vertical, Cell_AddressCount());
            audio_play_sound(snd_menu_switch, 0, false);
        }
        if (_input_confirm && __menu == 4)
        {
            Cell_CallEvent(Cell_GetAdress(__choice_cell), CELL_EVENT.CALL, __choice_cell);
            __menu = -1;
            audio_play_sound(snd_menu_confirm, 0, false);
        }
        else if (_input_cancel)
            __menu = 0;
        break;
}

