var input_vertical = PRESS_VERTICAL,
	input_horizontal = PRESS_HORIZONTAL,
	input_confirm = PRESS_CONFIRM,
	input_cancel = PRESS_CANCEL,
	input_menu = PRESS_MENU;
if (instance_exists(obj_ui_dialog) && __menu != -1)
    __menu = -1;
else if (__menu == -1 && !instance_exists(obj_ui_dialog))
    instance_destroy();

switch (__menu)
{
    case 0:
        // Main menu navigation
        if (abs(input_vertical) == 1)
        {
            var check = Cell_AddressCount() > 0 ? 2 : 1;
            _choice = posmod(_choice + input_vertical, check + 1);
            audio_play_sound(snd_menu_switch, 0, false);
        }
        else if (input_confirm)
        {
            if (_choice == 0)
				__menu = (Item_Count() > 0) ? 1 : 0;
            else
				__menu = _choice + 2;    
            audio_play_sound(snd_menu_confirm, 0, false);
        }
		else if (input_menu || input_cancel)
			instance_destroy();
        break;
    case 1:
        // Item selection
        if (abs(input_vertical) == 1)
        {
            _choice_item = posmod(_choice_item + input_vertical, Item_Count());
            audio_play_sound(snd_menu_switch, 0, false);
        }
        else if (input_confirm)
        {
            __menu = 2;      
            audio_play_sound(snd_menu_confirm, 0, false);
        }
        else if (input_cancel)
            __menu = 0;
        break;
    case 2:
        // Item operation
        if (abs(input_horizontal) == 1)
        {
            _choice_item_operation = posmod(_choice_item_operation + input_horizontal, 3);
            audio_play_sound(snd_menu_switch, 0, false);
        }
        else if (input_confirm)
        {
            __menu = -1;       
            Item_CallEvent(Item_Get(_choice_item), ITEM_EVENT.USE + _choice_item_operation, _choice_item);
            audio_play_sound(snd_menu_confirm, 0, false);
        }
        else if (input_cancel)
            __menu = 1;
        break;
    case 3:
    case 4:
        // Phone menu and other menus with simple navigation
        if (__menu == 4 && abs(input_vertical) == 1)
        {
            _choice_cell = posmod(_choice_cell + input_vertical, Cell_AddressCount());
            audio_play_sound(snd_menu_switch, 0, false);
        }
        if (input_confirm && __menu == 4)
        {
            Cell_CallEvent(Cell_GetAdress(_choice_cell), CELL_EVENT.CALL, _choice_cell);
            __menu = -1;
            audio_play_sound(snd_menu_confirm, 0, false);
        }
        else if (input_cancel)
            __menu = 0;
        break;
}

