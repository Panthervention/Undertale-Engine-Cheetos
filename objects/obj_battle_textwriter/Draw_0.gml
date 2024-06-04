/// @description Text/Choices Display
if (menu_dialog_visible)
	event_inherited();

var menu_state = Battle_GetMenu(), battle_state = Battle_GetState();

if (battle_state != BATTLE_STATE.MENU && battle_state != BATTLE_STATE.DIALOG)
	exit;

var _prefix = menu_string_prefix;
switch (menu_state)
{
	default:
		break;
		
	case BATTLE_MENU.FIGHT_TARGET:
	case BATTLE_MENU.ACT_TARGET:
		#region
		var enemy_name = _prefix, i = 0;
	    repeat (3)
	    {
	        var inst = Battle_GetEnemy(i);
	        if (instance_exists(inst))
	        {
	            if (Battle_IsEnemySpareable(i))
	                enemy_name += "[c_yellow]";
	            enemy_name += Battle_GetEnemyName(i) + "[c_white]\n";
	        }
	        i ++;
	    }
	    draw_text_scribble(100, 270, enemy_name);
		#endregion
		break;
		
    case BATTLE_MENU.ACT_ACTION:
		#region
		var ENEMY = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());

		var action_count = Battle_GetEnemyActionNumber(ENEMY),
			action_left = _prefix,
			action_right = _prefix;

		var i = 0;
		repeat (action_count)
		{
		    if (i % 2 == 0)
		        action_left += Battle_GetEnemyActionName(ENEMY, i) + "\n";
		    else
		        action_right += Battle_GetEnemyActionName(ENEMY, i) + "\n";
			i++;
		}

		draw_text_scribble(100, 270, action_left); // Column left
		draw_text_scribble(356, 270, action_right); // Column right
		#endregion
		break;
	
	case BATTLE_MENU.ITEM:
		#region
		switch (item_scroll_mode)
		{
			case BATTLE_MENU_ITEM.HORIZONTAL:
				#region
				var item_left = _prefix,
					item_right = _prefix;
		
				var i = 0, proc = obj_battle_controller._menu_choice_item_first;
				repeat (4)
				{
					var item = Item_Get(proc);
					if (Item_IsValid(item))
					{
					    var itemText = "* " + Item_GetName(item) + "\n";
					    if (i % 2 == 0)
					        item_left += itemText;
					    else
					        item_right += itemText;
					    proc++;
					}
					i++
				}
				draw_text_scribble(100, 270, item_left); // Column left
				draw_text_scribble(356, 270, item_right); // Column right
		
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
				var item_name = menu_string_prefix,
					i = obj_battle_controller._menu_choice_item_first;
				repeat(3)
				{
					var item = Item_Get(i);
					if (Item_IsValid(item))
					{
						item_name += "* " + Item_GetName(item) + "\n";
						i++;
					}
				}
				draw_text_scribble(100, 270, item_name);
				
				#region Scroll Bar
				var i = 0,
				    item_chose_first = obj_battle_controller._menu_choice_item_first,
				    item_count = Item_Count(),
				    item_current = Battle_GetMenuChoiceItem(),
				    arrow_x = obj_battle_board.x + obj_battle_board.right - 16,
				    arrow_y = obj_battle_board.y,
				    arrow_sine = 5 + (5 * sin(((current_time/1000) * 60) * 0.05)),
				    half_height = (10 * (item_count - 1)) * 0.5; // Adjusted for even distribution

				repeat(item_count)
				{
				    draw_sprite(spr_battle_menu_item_scrollbar_dot, i == item_current, arrow_x, arrow_y - half_height + (10 * i));
				    i++;
				}

				if(item_count > 3)
				{
				    // Draw the upward arrow above the first dot
				    if(item_chose_first != 0)
				        draw_sprite(spr_battle_menu_item_scrollbar_arrow, 0, arrow_x, arrow_y - half_height - 10 - arrow_sine);
    
				    // Draw the downward arrow below the last dot
				    if(item_chose_first != (item_count - 3))
				        draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow, 0, arrow_x, arrow_y + half_height + 10 + arrow_sine, 1, -1, 0, c_white, 1);
				}
				#endregion
				
				#endregion
				break;
		}
		#endregion
		break;
		
	case BATTLE_MENU.MERCY:
		#region
		var mercy = _prefix;
	    if (!Battle_IsMenuChoiceMercyOverride())
	    {
	        var i = 0;
	        repeat (3)
	        {
	            if (Battle_IsEnemySpareable(i))
	            {
	                mercy += "[c_yellow]";
	                break;
	            }
	            i++;
	        }
	        mercy += _label_spare;
        
	        if (Battle_IsMenuMercyFleeEnabled())
	        {
	            mercy += "\n[c_white]";
	            mercy += _label_flee;
	        }
	    }
	    else
	    {
	        var i = 0;
	        repeat (Battle_GetMenuChoiceMercyOverrideNumber())
	        {
	            mercy += Battle_GetMenuChoiceMercyOverrideName(proc);
	            mercy += "\n";
	            i++;
	        }
	    }
		draw_text_scribble(100, 270, mercy);
		#endregion
		break;
}
