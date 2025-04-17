var _input_vertical = PRESS_VERTICAL,
	_input_horizontal = PRESS_HORIZONTAL,
	_input_confirm = PRESS_CONFIRM,
	_input_cancel = PRESS_CANCEL;

if (__state == BATTLE_STATE.MENU)
{
    if (__menu == BATTLE_MENU.BUTTON)
    {
        var _button_pos = button_pos,
			_button = Battle_GetMenuChoiceButton();
        if (_input_horizontal != 0)
        {
            _button = posmod(_button + _input_horizontal, 4);
            Battle_SetMenuChoiceButton(_button);
            audio_play_sound(snd_menu_switch, 50, false);
        }
		
        if (_input_confirm)
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
    else if (__menu == BATTLE_MENU.FIGHT_TARGET)
    {
        var _enemy = Battle_GetMenuChoiceEnemy(),
			_len = Battle_GetEnemyNumber();
        if (_input_vertical != 0)
        {
            _enemy = posmod(_enemy + _input_vertical, _len);
            Battle_SetMenuChoiceEnemy(_enemy);
            if (_enemy >= 0 && Battle_GetEnemyNumber() > 1 && _enemy < Battle_GetEnemyNumber())
                audio_play_sound(snd_menu_switch, 50, false);
        }
        
		with (obj_battle_soul)
		{
			x = lerp(x, (obj_battle_board.x - obj_battle_board.left - 5 + 40), 1/3);
			y = lerp(y, (obj_battle_board.y - obj_battle_board.up - 5 + 37) + (_enemy * 32), 1/3);
		}
		
        if (_input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        
        if (_input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_SetMenu(BATTLE_MENU.FIGHT_AIM);
        }
    }
    else if (__menu == BATTLE_MENU.FIGHT_ANIM)
    {
        if (__menu_fight_anim_time > 0)
            __menu_fight_anim_time--;
        else if (__menu_fight_anim_time == 0)
            Battle_EndMenuFightAnim();
    }
    else if (__menu == BATTLE_MENU.FIGHT_DAMAGE)
    {
        if (__menu_fight_damage_time > 0)
            __menu_fight_damage_time--;
        else if (__menu_fight_damage_time == 0)
            Battle_EndMenuFightDamage();
    }
    else if (__menu == BATTLE_MENU.ACT_TARGET)
    {
        var _enemy = Battle_GetMenuChoiceEnemy(),
			_len = Battle_GetEnemyNumber();
        if (_input_vertical != 0)
        {
            _enemy = posmod(_enemy + _input_vertical, _len);
            Battle_SetMenuChoiceEnemy(_enemy);
            if (_enemy >= 0 && _len > 1 && _enemy < _len)
                audio_play_sound(snd_menu_switch, 50, false);
        }
        
		with (obj_battle_soul)
		{
			x = lerp(x, (obj_battle_board.x - obj_battle_board.left - 5 + 40), 1/3);
			y = lerp(y, (obj_battle_board.y - obj_battle_board.up - 5 + 37) + (_enemy * 32), 1/3);
		}
		
        if (_input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        
        if (_input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_SetMenu(BATTLE_MENU.ACT_ACTION);
        }
    }
    else if (__menu == BATTLE_MENU.ACT_ACTION)
    {
        var _action = Battle_GetMenuChoiceAction(),
			_len = __enemy_action_number[Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy())];
        if (_len > 1 && _input_horizontal != 0)
        {
            _action = posmod(_action + _input_horizontal, _len);
            Battle_SetMenuChoiceAction(_action);
            audio_play_sound(snd_menu_switch, 50, false);
        }
        if (_len > 2 && _input_vertical != 0)
        {
            _action = posmod(_action + (_input_vertical * 2), _len);
            Battle_SetMenuChoiceAction(_action);
            audio_play_sound(snd_menu_switch, 50, false);
        }
        
		with (obj_battle_soul)
		{
			x = lerp(x, (obj_battle_board.x - obj_battle_board.left - 5 + 40) + ((_action % 2) * 256), 1/3);
			y = lerp(y, (obj_battle_board.y - obj_battle_board.up - 5 + 37) + (floor(_action / 2) * 32), 1/3);
		}
		
        if (_input_cancel)
            Battle_SetMenu(BATTLE_MENU.ACT_TARGET);
        else if (_input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_EndMenu();
        }
    }
    else if (__menu == BATTLE_MENU.ITEM)
    {
        var _slot = Battle_GetMenuChoiceItem(),
			_len = Item_Count();
		
		var _item_scroll_mode = obj_battle_textwriter.item_scroll_mode;
		
		switch (_item_scroll_mode)
		{
			case BATTLE_MENU_ITEM.HORIZONTAL:
		        if (_len > 1 && _input_horizontal != 0)
		        {
		            _slot = posmod(_slot + _input_horizontal, _len);
		            Battle_SetMenuChoiceItem(_slot);
		            audio_play_sound(snd_menu_switch, 50, false);
		        }
		        if (_len > 2 && _input_vertical != 0)
		        {
		            _slot = posmod(_slot + (_input_vertical * 2), _len);
		            Battle_SetMenuChoiceItem(_slot);
		            audio_play_sound(snd_menu_switch, 50, false);
		        }
				
				with (obj_battle_soul)
				{
					x = lerp(x, (obj_battle_board.x - obj_battle_board.left - 5 + 40) + ((_slot % 2) * 256), 1/3);
					y = lerp(y, (obj_battle_board.y - obj_battle_board.up - 5 + 37) + ((floor(_slot / 2) % 2) * 32), 1/3);
				}
				break;
			
			case BATTLE_MENU_ITEM.VERTICAL:
				if (_len > 1 && _input_vertical != 0)
		        {
		            _slot = posmod(_slot + _input_vertical, _len);
		            Battle_SetMenuChoiceItem(_slot);
		            audio_play_sound(snd_menu_switch, 50, false);
		        }
				
				with (obj_battle_soul)
				{
					x = lerp(x, (obj_battle_board.x - obj_battle_board.left - 5 + 40), 1/3);
					y = lerp(y, (obj_battle_board.y - obj_battle_board.up - 5 + 37) + ((_slot - other.__menu_choice_item_first) * 32), 1/3);
				}
				break;
		}
        
        if (_input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        else if (_input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_EndMenu();
        }
    }
    else if (__menu == BATTLE_MENU.MERCY)
    {
        if (_input_vertical < 0)
        {
            var _mercy = Battle_GetMenuChoiceMercy() - 1;
            if (_mercy >= 0)
            {
                audio_play_sound(snd_menu_switch, 50, false);
                Battle_SetMenuChoiceMercy(_mercy);
            }
        }
        else if (_input_vertical > 0)
        {
            var _mercy = Battle_GetMenuChoiceMercy() + 1;
            if ((!Battle_IsMenuChoiceMercyOverride() && _mercy <= __menu_mercy_flee_enabled) || (Battle_IsMenuChoiceMercyOverride() && mercy < Battle_GetMenuChoiceMercyOverrideNumber()))
            {
                audio_play_sound(snd_menu_switch, 50, false);
                Battle_SetMenuChoiceMercy(_mercy);
            }
        }
        
		with (obj_battle_soul)
		{
	        x = lerp(x, (obj_battle_board.x - obj_battle_board.left - 5 + 40), 1/3);
	        y = lerp(y, (obj_battle_board.y - obj_battle_board.up - 5 + 37 + 32 * other.__menu_choice_mercy), 1/3);
		}
		
        if (_input_cancel)
            Battle_SetMenu(BATTLE_MENU.BUTTON);
        else if (_input_confirm)
        {
            audio_play_sound(snd_menu_confirm, 50, false);
            Battle_EndMenu();
        }
    }
}

if (__state == BATTLE_STATE.DIALOG)
{
	if (!obj_battle_textwriter.menu_dialog_visible) // If menu dialog not invisible
	{
	    if (!Dialog_IsEmpty())
	        Battle_SetDialog($"{Dialog_Get()}[pause][script, Battle_SetMenuDialogVisible, false]");
	    else if (Battle_IsDialogAutoEnd())
	        Battle_EndDialog();
	}
}

if (__state == BATTLE_STATE.TURN_PREPARATION)
{
    if ((Battle_IsTurnPreparationAutoEnd()) && (!instance_exists(obj_battle_dialog_enemy) && !Battle_IsBoardTransforming()))
        Battle_EndTurnPreparation();
}

if (__state == BATTLE_STATE.IN_TURN)
{
    if (__turn_time > 0)
        __turn_time--;
    else if (__turn_time == 0)
        Battle_EndTurn();
}

if (__state == BATTLE_STATE.BOARD_RESETTING)
{
    if (!Battle_IsBoardTransforming())
    {
        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.BOARD_RESETTING_END);
        Battle_GotoNextState();
    }
}

if (__state == BATTLE_STATE.RESULT)
{
    if (!instance_exists(obj_battle_textwriter))
        Battle_End();
}

if (__state != BATTLE_STATE.RESULT && Battle_GetEnemyNumber() == 0)
{
	show_debug_message(obj_battle_textwriter.menu_dialog_visible);
    Battle_SetState(BATTLE_STATE.RESULT);
    Battle_SetNextState(BATTLE_STATE.RESULT);
    var _exp = Battle_GetRewardExp(),
		_gold = Battle_GetRewardGold(),
		_text_won = lexicon_text("battle.result.won", _exp, _gold);
    Player_SetExp(Player_GetExp() + Battle_GetRewardExp());
    Player_SetGold(Player_GetGold() + Battle_GetRewardGold());
    if (Player_UpdateLv())
    {
        _text_won += $"\n{lexicon_text("battle.result.lv_up")}";
        audio_play_sound(snd_level_up, 50, false);
    }
    _text_won += "[pause][end]";
    Battle_SetDialog(_text_won);
}


// Putting this visibility control anywhere else above mess it up!
with (obj_battle_textwriter)
{
	menu_dialog_visible = true;
	if (Battle_GetMenu() != BATTLE_MENU.BUTTON && (Battle_GetState() != BATTLE_STATE.DIALOG) && (Battle_GetState() != BATTLE_STATE.RESULT))
		menu_dialog_visible = false;
}
