var input_vertical = PRESS_VERTICAL,
	input_horizontal = PRESS_HORIZONTAL,
	input_confirm = PRESS_CONFIRM,
	input_cancel = PRESS_CANCEL;

if (_state == BATTLE_STATE.MENU)
{
    if (_menu == BATTLE_MENU.BUTTON)
    {
        var _button_pos = button_pos;
        var button = Battle_GetMenuChoiceButton();
        if (input_horizontal != 0)
        {
            button = posmod(button + input_horizontal, 4);
            Battle_SetMenuChoiceButton(button);
            audio_play_sound(snd_menu_switch, 50, false);
        }
        obj_battle_soul.x += ((_button_pos[button][0] - 47) - obj_battle_soul.x) / 3;
        obj_battle_soul.y += ((_button_pos[button][1] + 1) - obj_battle_soul.y) / 3;
        
        if (input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            switch (Battle_GetMenuChoiceButton())
            {
                case 0:
                    Battle_SetMenu(BATTLE_MENU.FIGHT_TARGET);
                    break;
                case 1:
                    Battle_SetMenu(BATTLE_MENU.ACT_TARGET);
                    break;
                case 2:
                    if (Item_Count() > 0)
                        Battle_SetMenu(BATTLE_MENU.ITEM);
                    else
                        audio_stop_sound(snd_menu_confirm);
                    break;
                case 3:
                    Battle_SetMenu(BATTLE_MENU.MERCY);
                    break;
            }
        }
    }
    else if (_menu == BATTLE_MENU.FIGHT_TARGET)
    {
        var enemy = Battle_GetMenuChoiceEnemy();
        var len = Battle_GetEnemyNumber();
        if (input_vertical != 0)
        {
            enemy = posmod(enemy + input_vertical, len);
            Battle_SetMenuChoiceEnemy(enemy);
            if (enemy >= 0 && Battle_GetEnemyNumber() > 1 && enemy < Battle_GetEnemyNumber())
                audio_play_sound(snd_menu_switch, 50, false);
        }
        
        obj_battle_soul.x += ((obj_battle_board.x - obj_battle_board.left - 5 + 40) - obj_battle_soul.x) / 3;
        obj_battle_soul.y += (((obj_battle_board.y - obj_battle_board.up - 5 + 37) + (enemy * 32)) - obj_battle_soul.y) / 3;
        
        if (input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        
        if (input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_SetMenu(BATTLE_MENU.FIGHT_AIM);
        }
    }
    else if (_menu == BATTLE_MENU.FIGHT_ANIM)
    {
        if (_menu_fight_anim_time > 0)
            _menu_fight_anim_time--;
        else if (_menu_fight_anim_time == 0)
            Battle_EndMenuFightAnim();
    }
    else if (_menu == BATTLE_MENU.FIGHT_DAMAGE)
    {
        if (_menu_fight_damage_time > 0)
            _menu_fight_damage_time--;
        else if (_menu_fight_damage_time == 0)
            Battle_EndMenuFightDamage();
    }
    else if (_menu == BATTLE_MENU.ACT_TARGET)
    {
        var enemy = Battle_GetMenuChoiceEnemy();
        var len = Battle_GetEnemyNumber();
        if (input_vertical != 0)
        {
            enemy = posmod(enemy + input_vertical, len);
            Battle_SetMenuChoiceEnemy(enemy);
            if (enemy >= 0 && len > 1 && enemy < len)
                audio_play_sound(snd_menu_switch, 50, false);
        }
        
        obj_battle_soul.x += ((obj_battle_board.x - obj_battle_board.left - 5 + 40) - obj_battle_soul.x) / 3;
        obj_battle_soul.y += (((obj_battle_board.y - obj_battle_board.up - 5 + 37) + (enemy * 32)) - obj_battle_soul.y) / 3;
        
        if (input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        
        if (input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_SetMenu(BATTLE_MENU.ACT_ACTION);
        }
    }
    else if (_menu == BATTLE_MENU.ACT_ACTION)
    {
        var action = Battle_GetMenuChoiceAction();
        var len = _enemy_action_number[Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy())];
        if (len > 1 && input_horizontal != 0)
        {
            action = posmod(action + input_horizontal, len);
            Battle_SetMenuChoiceAction(action);
            audio_play_sound(snd_menu_switch, 50, false);
        }
        if (len > 2 && input_vertical != 0)
        {
            action = posmod(action + (input_vertical * 2), len);
            Battle_SetMenuChoiceAction(action);
            audio_play_sound(snd_menu_switch, 50, false);
        }
        
        obj_battle_soul.x += (((obj_battle_board.x - obj_battle_board.left - 5 + 40) + ((action % 2) * 256)) - obj_battle_soul.x) / 3;
        obj_battle_soul.y += (((obj_battle_board.y - obj_battle_board.up - 5 + 37) + (floor(action / 2) * 32)) - obj_battle_soul.y) / 3;
        
        if (input_cancel)
            Battle_SetMenu(BATTLE_MENU.ACT_TARGET);
        else if (input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_EndMenu();
        }
    }
    else if (_menu == BATTLE_MENU.ITEM)
    {
        var slot = Battle_GetMenuChoiceItem();
        var len = Item_Count();
		
		var _item_scroll_mode = obj_battle_textwriter.item_scroll_mode;
		
		switch (_item_scroll_mode)
		{
			case BATTLE_MENU_ITEM.HORIZONTAL:
		        if (len > 1 && input_horizontal != 0)
		        {
		            slot = posmod(slot + input_horizontal, len);
		            Battle_SetMenuChoiceItem(slot);
		            audio_play_sound(snd_menu_switch, 50, false);
		        }
		        if (len > 2 && input_vertical != 0)
		        {
		            slot = posmod(slot + (input_vertical * 2), len);
		            Battle_SetMenuChoiceItem(slot);
		            audio_play_sound(snd_menu_switch, 50, false);
		        }
				obj_battle_soul.x += (((obj_battle_board.x - obj_battle_board.left - 5 + 40) + ((slot % 2) * 256)) - obj_battle_soul.x) / 3;
				obj_battle_soul.y += (((obj_battle_board.y - obj_battle_board.up - 5 + 37) + ((floor(slot / 2) % 2) * 32)) - obj_battle_soul.y) / 3;
				break;
			
			case BATTLE_MENU_ITEM.VERTICAL:
				if (len > 1 && input_vertical != 0)
		        {
		            slot = posmod(slot + input_vertical, len);
		            Battle_SetMenuChoiceItem(slot);
		            audio_play_sound(snd_menu_switch, 50, false);
		        }
				obj_battle_soul.x += ((obj_battle_board.x - obj_battle_board.left - 5 + 40) - obj_battle_soul.x) / 3;
				obj_battle_soul.y += (((obj_battle_board.y - obj_battle_board.up - 5 + 37) + ((slot - _menu_choice_item_first) * 32)) - obj_battle_soul.y) / 3;
				break;
		}
        
        if (input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        else if (input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_EndMenu();
        }
    }
    else if (_menu == BATTLE_MENU.MERCY)
    {
        if (input_vertical < 0)
        {
            var mercy = Battle_GetMenuChoiceMercy() - 1;
            if (mercy >= 0)
            {
                audio_play_sound(snd_menu_switch, 50, false);
                Battle_SetMenuChoiceMercy(mercy);
            }
        }
        else if (input_vertical > 0)
        {
            var mercy = Battle_GetMenuChoiceMercy() + 1;
            if ((!Battle_IsMenuChoiceMercyOverride() && mercy <= _menu_mercy_flee_enabled) || (Battle_IsMenuChoiceMercyOverride() && mercy < Battle_GetMenuChoiceMercyOverrideNumber()))
            {
                audio_play_sound(snd_menu_switch, 50, false);
                Battle_SetMenuChoiceMercy(mercy);
            }
        }
        
        obj_battle_soul.x += ((obj_battle_board.x - obj_battle_board.left - 5 + 40) - obj_battle_soul.x) / 3;
        obj_battle_soul.y += ((obj_battle_board.y - obj_battle_board.up - 5 + 37 + 32 * _menu_choice_mercy) - obj_battle_soul.y) / 3;
        
        if (input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        else if (input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_EndMenu();
        }
    }
}

if (_state == BATTLE_STATE.DIALOG)
{
	if (!obj_battle_textwriter.menu_dialog_visible) // If menu dialog not invisible
	{
	    if (!Dialog_IsEmpty())
	        Battle_SetDialog(Dialog_Get() + "[pause][script, Battle_SetMenuDialogVisible, false]");
	    else if (Battle_IsDialogAutoEnd())
	        Battle_EndDialog();
	}
}

if (_state == BATTLE_STATE.TURN_PREPARATION)
{
    if ((Battle_IsTurnPreparationAutoEnd()) && (!instance_exists(obj_battle_dialog_enemy) && !Battle_IsBoardTransforming()))
        Battle_EndTurnPreparation();
}

if (_state == BATTLE_STATE.IN_TURN)
{
    if (_turn_time > 0)
        _turn_time--;
    else if (_turn_time == 0)
        Battle_EndTurn();
}

if (_state == BATTLE_STATE.BOARD_RESETTING)
{
    if (!Battle_IsBoardTransforming())
    {
        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.BOARD_RESETTING_END);
        Battle_GotoNextState();
    }
}

if (_state == BATTLE_STATE.RESULT)
    if (!instance_exists(obj_battle_controller))
        Battle_End();

if (_state != BATTLE_STATE.RESULT && Battle_GetEnemyNumber() == 0)
{
    Battle_SetState(BATTLE_STATE.RESULT);
    Battle_SetNextState(BATTLE_STATE.RESULT);
    var text = lexicon_text("battle.result.won", Battle_GetRewardExp(), Battle_GetRewardGold());
    Player_SetExp(Player_GetExp() + Battle_GetRewardExp());
    Player_SetGold(Player_GetGold() + Battle_GetRewardGold());
    if (Player_UpdateLv())
    {
        text += "\n" + lexicon_text("battle.result.lv_up");
        audio_play_sound(snd_level_up, 50, false);
    }
    text += "[pause][end]";
    Battle_SetDialog(text);
}


// Putting this visibility control anywhere else above mess it up!
with (obj_battle_textwriter)
{
	menu_dialog_visible = true;
	if (Battle_GetMenu() != BATTLE_MENU.BUTTON && (Battle_GetState() != BATTLE_STATE.DIALOG))
		menu_dialog_visible = false;
}
