/// @description Text/Choices Display
if (menu_dialog_visible)
	event_inherited();

var _menu_state = Battle_GetMenu(), _battle_state = Battle_GetState();

if (_battle_state != BATTLE_STATE.MENU && _battle_state != BATTLE_STATE.DIALOG)
	exit;

var _prefix = menu_string_prefix;
switch (_menu_state)
{
	default:
		break;
		
	case BATTLE_MENU.FIGHT_TARGET:
	case BATTLE_MENU.ACT_TARGET:
		#region
		var _enemy_name = _prefix;
		var _i = 0; repeat (3)
	    {
	        var _enemy_instance = Battle_GetEnemy(_i);
	        if (instance_exists(_enemy_instance))
	        {
	            if (Battle_IsEnemySpareable(_i))
	                _enemy_name += "[c_yellow]";
	            _enemy_name += Battle_GetEnemyName(_i) + "[c_white]\n";
	        }
	        _i ++;
		}
		// This is modified scribble behavior!
		// Original scribble cannot do this unless you "return _element"!
		var _enemy_label = draw_text_scribble(100, 270, _enemy_name);
		enemy_name_width_max = _enemy_label.get_width(); // Retrieve the max name width among enemmies
		#endregion
		break;
		
    case BATTLE_MENU.ACT_ACTION:
		#region
		var _enemy_slot = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());

		var _action_count = Battle_GetEnemyActionNumber(_enemy_slot),
			_action_left = _prefix,
			_action_right = _prefix;

		var _i = 0; repeat (_action_count)
		{
		    if (_i % 2 == 0)
		        _action_left += Battle_GetEnemyActionName(_enemy_slot, _i) + "\n";
		    else
		        _action_right += Battle_GetEnemyActionName(_enemy_slot, _i) + "\n";
			_i++;
		}

		draw_text_scribble(100, 270, _action_left); // Column left
		draw_text_scribble(356, 270, _action_right); // Column right
		#endregion
		break;
	
	case BATTLE_MENU.ITEM:
		#region
		switch (item_scroll_mode)
		{
			case BATTLE_MENU_ITEM.HORIZONTAL:
				#region
				var _item_left = _prefix,
					_item_right = _prefix;
		
				var _i = 0, _j = obj_battle_controller.__menu_choice_item_first; repeat (4)
				{
					var _item = Item_Get(_j);
					if (Item_IsValid(_item))
					{
					    var _item_text = "* " + Item_GetName(_item) + "\n";
					    if (_i % 2 == 0)
					        _item_left += _item_text;
					    else
					        _item_right += _item_text;
					    _j++;
					}
					_i++
				}
				draw_text_scribble(100, 270, _item_left); // Column left
				draw_text_scribble(356, 270, _item_right); // Column right
		
				if (Item_Count() > 4)
				{
					var _page_count = (floor(Battle_GetMenuChoiceItem() / 4) + 1),
						_page = _prefix + lexicon_text("battle.menu.page", _page_count);
					draw_text_scribble(384, 340, _page); // Page counter
				}
				#endregion
				break;
			case BATTLE_MENU_ITEM.VERTICAL:
				#region
				var _item_name = menu_string_prefix;
				var	_i = obj_battle_controller.__menu_choice_item_first; repeat(3)
				{
					var _item = Item_Get(_i);
					if (Item_IsValid(_item))
					{
						_item_name += "* " + Item_GetName(_item) + "\n";
						_i++;
					}
				}
				draw_text_scribble(100, 270, _item_name);
				
				#region Scroll Bar
				var _item_chose_first = obj_battle_controller.__menu_choice_item_first,
				    _item_count = Item_Count(),
				    _item_current = Battle_GetMenuChoiceItem(),
				    _arrow_x = obj_battle_board.x + obj_battle_board.right - 16,
				    _arrow_y = obj_battle_board.y,
				    _arrow_sine = 5 + (5 * sin(((current_time/1000) * 60) * 0.05)),
				    _half_height = (10 * (_item_count - 1)) * 0.5; // Adjusted for even distribution

				var _i = 0; repeat(_item_count)
				{
				    draw_sprite(spr_battle_menu_item_scrollbar_dot, _i == _item_current, _arrow_x, _arrow_y - _half_height + (10 * _i));
				    _i++;
				}

				if (_item_count > 1)
				{
				    // Draw the upward arrow above the first dot
					draw_sprite(spr_battle_menu_item_scrollbar_arrow, 0, _arrow_x, _arrow_y - _half_height - 10 - _arrow_sine);
				    // Draw the downward arrow below the last dot
					draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow, 0, _arrow_x, _arrow_y + _half_height + 10 + _arrow_sine, 1, -1, 0, c_white, 1);
				}
				#endregion
				
				#endregion
				break;
		}
		#endregion
		break;
		
	case BATTLE_MENU.MERCY:
		#region
		var _mercy = _prefix;
	    if (!Battle_IsMenuChoiceMercyOverride())
	    {
	        var _i = 0;
	        repeat (3)
	        {
	            if (Battle_IsEnemySpareable(_i))
	            {
	                _mercy += "[c_yellow]";
	                break;
	            }
	            _i++;
	        }
	        _mercy += __label_spare;
        
	        if (Battle_IsMenuMercyFleeEnabled())
	        {
	            _mercy += "\n[c_white]";
	            _mercy += __label_flee;
	        }
	    }
	    else
	    {
	        var _i = 0; repeat (Battle_GetMenuChoiceMercyOverrideNumber())
	        {
	            _mercy += Battle_GetMenuChoiceMercyOverrideName(_i);
	            _mercy += "\n";
	            _i++;
	        }
	    }
		draw_text_scribble(100, 270, _mercy);
		#endregion
		break;
}
