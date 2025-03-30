#region Menu

///@param {Bool}	visible
function Battle_SetMenuDialogVisible(_visible) {
	menu_dialog_visible = _visible;
}

///@return {Real}
function Battle_GetMenu() {
	return obj_battle_controller.__menu;
}

///@param {Real}	menu
///@param {Bool}	[call_event]
function Battle_SetMenu(_menu, _call = true) {
	obj_battle_controller.__menu = _menu;
	
	if (_menu == BATTLE_MENU.BUTTON)
	{
	    Battle_SetDialog(Battle_GetMenuDialog());
		obj_battle_textwriter.text_typist.reset();
	}

	if (_menu == BATTLE_MENU.FIGHT_TARGET || _menu == BATTLE_MENU.ACT_TARGET)
	{
	    if (Battle_GetMenuChoiceEnemy() >= Battle_GetEnemyNumber())
	        Battle_SetMenuChoiceEnemy(0, false);    
	}

	if (_menu == BATTLE_MENU.FIGHT_AIM)
	{
	    Battle_SetMenuFightAnimTime(0);
	    Battle_SetMenuFightDamageTime(0);
    
	    var OBJ = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.BATTLE_MENU_FIGHT_OBJ);
	    if (object_exists(OBJ))
	    {
	        if (OBJ == obj_battle_menu_fight || object_get_base_parent(OBJ) == obj_battle_menu_fight)
	            instance_create_depth(320, 320, 0, OBJ);
	    }
	}
 
	if (_menu == BATTLE_MENU.ACT_ACTION)
	{
	    var ENEMY = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
	    var num = Battle_GetEnemyActionNumber(ENEMY);

	    if (Battle_GetMenuChoiceAction() >= num)
	        Battle_SetMenuChoiceAction(0, false);
	}

	if (_menu == BATTLE_MENU.ITEM)
	{
	    Battle_SetMenuChoiceItem(0);
		obj_battle_controller.__menu_choice_item_first = 0;
		obj_battle_controller.__menu_choice_item = 0;
	}

	if (_menu == BATTLE_MENU.MERCY)
	{
	    if (!Battle_IsMenuChoiceMercyOverride())
	    {
	        if (Battle_GetMenuChoiceMercy() > Battle_IsMenuMercyFleeEnabled())
	            Battle_SetMenuChoiceMercy(0, false);
	    }
	    else
	    {
	        if (Battle_GetMenuChoiceMercy() >= Battle_GetMenuChoiceMercyOverrideNumber())
	            Battle_SetMenuChoiceMercy(0, false);
	    }
	}

	if (_call)
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_SWITCH);

	if (_menu == BATTLE_MENU.FIGHT_ANIM)
	{
	    if (instance_exists(obj_battle_menu_fight))
	    {
	        with (obj_battle_menu_fight)
	            event_user(BATTLE_MENU_FIGHT_EVENT.ANIM);
	    }
	}

	if (_menu == BATTLE_MENU.FIGHT_DAMAGE)
	{
	    if (instance_exists(obj_battle_menu_fight))
	    {
	        with (obj_battle_menu_fight)
	            event_user(BATTLE_MENU_FIGHT_EVENT.DAMAGE);
	    }
	}

	return true;
}

function Battle_EndMenu() {
	if (Battle_GetState() == BATTLE_STATE.MENU)
	{
	    Battle_SetMenu(-1, false);
    
	    var _button = Battle_GetMenuChoiceButton();
	    var _mercy = Battle_GetMenuChoiceMercy();
    
	    if (_button == BATTLE_MENU_CHOICE_BUTTON.ITEM)
	    {
	        obj_battle_controller.__menu_item_used_last = Item_Get(Battle_GetMenuChoiceItem());
			Item_CallEvent(obj_battle_controller.__menu_item_used_last, ITEM_EVENT.USE, Battle_GetMenuChoiceItem());
	        //Item_CallEvent(Item_Get(Battle_GetMenuChoiceItem()), ITEM_EVENT.USE, Battle_GetMenuChoiceItem());
	    }
    
	    if (_button == BATTLE_MENU_CHOICE_BUTTON.FIGHT)
	    {
	        if (instance_exists(obj_battle_menu_fight))
	        {
	            with (obj_battle_menu_fight)
	                event_user(BATTLE_MENU_FIGHT_EVENT.END);
	        }
	    }

	    if (_button == BATTLE_MENU_CHOICE_BUTTON.MERCY && _mercy == BATTLE_MENU_CHOICE_MERCY.FLEE)
	    {
	        if (Battle_IsMenuMercyFleeEnabled())
	        {
	            var value = irandom(100) + 10 * Battle_GetTurnNumber();
	            Battle_SetFleeable(round(value / 100));
	        }
	        else
	            Battle_SetFleeable(false);
	    }
    
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_END);
    
	    if (Battle_GetEnemyNumber() > 0)
	    {
	        if (_button == BATTLE_MENU_CHOICE_BUTTON.MERCY && _mercy == BATTLE_MENU_CHOICE_MERCY.FLEE && Battle_IsFleeable())
	        {
	            Battle_SetState(BATTLE_STATE.RESULT);
	            Battle_SetNextState(BATTLE_STATE.RESULT);
	            instance_create_depth(0, 0, 0, obj_battle_result_flee);
            
	            var _exp = Battle_GetRewardExp();
	            var _gold = Battle_GetRewardGold();
	            var _text = "";
	            if (_gold == 0 && _exp == 0)
	            {
	                var _rand = irandom(20);
	                var _fled_text = 0;
	                if (_rand < 2) _fled_text = 1;
	                else if (_rand == 2) _fled_text = 2;
	                else if (_rand == 3) _fled_text = 3;
	                else _fled_text = 0;
					
	                _text += lexicon_text($"battle.result.fled.{_fled_text}");
	            }
	            else
	            {   
	                _text += lexicon_text("battle.result.fled.reward", _exp, _gold);
					
	                Player_SetExp(Player_GetExp() + Battle_GetRewardExp());
	                Player_SetGold(Player_GetGold() + Battle_GetRewardGold());
	                if (Player_UpdateLv())
	                    audio_play_sound(snd_level_up, 0, false);
	            }
	            Battle_SetDialog(_text);
	        }
	        else
	            Battle_GotoNextState();
	    }
	}
}

#endregion

#region Button
///@return {Real}
function Battle_GetMenuChoiceButton() {
	return obj_battle_controller.__menu_choice_button;
}

///@param {Real}	button_choice
///@param {Bool}	[call_event]
function Battle_SetMenuChoiceButton(_button, _call = true) {
	if (_button >= 0 && _button <= 3)
	{
	    obj_battle_controller.__menu_choice_button = _button;
    
	    if (_call)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
	}
}

#endregion

#region Enemy

function Battle_GetMenuChoiceEnemy() {
	return obj_battle_controller.__menu_choice_enemy;
}

///@param enemy_choice
///@param [call_event]
function Battle_SetMenuChoiceEnemy(ENEMY, _call = true) {
	if (ENEMY >= 0 && ENEMY < Battle_GetEnemyNumber())
	{
	    obj_battle_controller.__menu_choice_enemy = ENEMY;
    
	    if (_call)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}

#endregion

#region Action

function Battle_GetMenuChoiceAction() {
	return obj_battle_controller.__menu_choice_action;
}

///@param action_choice
///@param [call_event]
function Battle_SetMenuChoiceAction(ACTION, _call = true) {
	if (ACTION >= 0 && ACTION <= 5)
	{
	    obj_battle_controller.__menu_choice_action = ACTION;
    
	    if (_call)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}

#endregion

#region Item

function Battle_GetMenuChoiceItem() {
	return obj_battle_controller.__menu_choice_item;
}

///@param item_choice
///@param [call_event]
function Battle_SetMenuChoiceItem(slot, call = true) {	
	if (slot < Item_Count())
	{
		var _item_scroll_mode = obj_battle_textwriter.item_scroll_mode;
		obj_battle_controller.__menu_choice_item = slot;
		switch (_item_scroll_mode)
		{
			case BATTLE_MENU_ITEM.HORIZONTAL:
				obj_battle_controller.__menu_choice_item_first = (slot div 4) * 4;
				break;
			
			case BATTLE_MENU_ITEM.VERTICAL:
				while (slot >= obj_battle_controller.__menu_choice_item_first + 3)
				    obj_battle_controller.__menu_choice_item_first += 1;
    
				while (slot < obj_battle_controller.__menu_choice_item_first)
				    obj_battle_controller.__menu_choice_item_first -= 1;
				break;
		}
 
	    if (call)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}


function Battle_GetMenuItemUsedLast() {
	return obj_battle_controller.__menu_item_used_last;
}

#endregion

#region Mercy

function Battle_GetMenuChoiceMercy() {
	return obj_battle_controller.__menu_choice_mercy;
}

///@param mercy_choice
///@param [call_event]
function Battle_SetMenuChoiceMercy(_mercy, _call = true) {
	if ((!Battle_IsMenuChoiceMercyOverride() && _mercy >= 0 && _mercy <= 1) || 
		 (Battle_IsMenuChoiceMercyOverride() && _mercy >= 0 && _mercy < Battle_GetMenuChoiceMercyOverrideNumber()))
	{
	    obj_battle_controller.__menu_choice_mercy = _mercy;
    
	    if (_call)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}

#region Overriding

	///@param override
	function Battle_SetMenuChoiceMercyOverride(_override) {
		obj_battle_controller.__menu_choice_mercy_override = _override;
		return true;
	}

	function Battle_IsMenuChoiceMercyOverride() {
		return obj_battle_controller.__menu_choice_mercy_override;
	}

	function Battle_GetMenuChoiceMercyOverrideNumber() {
		return  obj_battle_controller.__menu_choice_mercy_override_number;
	}

	///@param number
	function Battle_SetMenuChoiceMercyOverrideNumber(_number) {
		if (_number >= 1 && _number <= 3)
		    obj_battle_controller.__menu_choice_mercy_override_number = _number;
	}

	///@param choice_mercy_slot
	function Battle_GetMenuChoiceMercyOverrideName(SLOT) {
		if (SLOT >= 0 && SLOT <= 2)
		    return obj_battle_controller.__menu_choice_mercy_override_name[SLOT];
		else
		    return "";
	}

	///@param choice_mercy_slot
	///@param name
	function Battle_SetMenuChoiceMercyOverrideName(SLOT, NAME) {
		if (SLOT >= 0 && SLOT <= 2)
		{
		    obj_battle_controller.__menu_choice_mercy_override_name[SLOT] = NAME;
		    return true;
		}
		else
		    return false;
	}

#endregion

#endregion
