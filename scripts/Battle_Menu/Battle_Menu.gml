#region Menu

function Battle_SetMenuDialogVisible() {
	menu_dialog_visible = argument0;
}

function Battle_GetMenu() {
	return obj_battle_controller._menu;
}

///@arg menu
///@arg [call_event]
function Battle_SetMenu(MENU, CALL = true) {
	obj_battle_controller._menu = MENU;
	
	if (MENU == BATTLE_MENU.BUTTON)
	{
	    Battle_SetDialog(Battle_GetMenuDialog());
		obj_battle_textwriter.text_typist.reset();
	}

	if (MENU == BATTLE_MENU.FIGHT_TARGET || MENU == BATTLE_MENU.ACT_TARGET)
	{
	    if (Battle_GetMenuChoiceEnemy() >= Battle_GetEnemyNumber())
	        Battle_SetMenuChoiceEnemy(0, false);    
	}

	if (MENU == BATTLE_MENU.FIGHT_AIM)
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
 
	if (MENU == BATTLE_MENU.ACT_ACTION)
	{
	    var ENEMY = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
	    var num = Battle_GetEnemyActionNumber(ENEMY);

	    if (Battle_GetMenuChoiceAction() >= num)
	        Battle_SetMenuChoiceAction(0, false);
	}

	if (MENU == BATTLE_MENU.ITEM)
	{
	    Battle_SetMenuChoiceItem(0);
		obj_battle_controller._menu_choice_item_first = 0;
		obj_battle_controller._menu_choice_item = 0;
	}

	if (MENU == BATTLE_MENU.MERCY)
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

	if (CALL)
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_SWITCH);

	if (MENU == BATTLE_MENU.FIGHT_ANIM)
	{
	    if (instance_exists(obj_battle_menu_fight))
	    {
	        with (obj_battle_menu_fight)
	            event_user(BATTLE_MENU_FIGHT_EVENT.ANIM);
	    }
	}

	if (MENU == BATTLE_MENU.FIGHT_DAMAGE)
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
    
	    var BUTTON = Battle_GetMenuChoiceButton();
	    var MERCY = Battle_GetMenuChoiceMercy();
    
	    if (BUTTON == BATTLE_MENU_CHOICE_BUTTON.ITEM)
	    {
	        obj_battle_controller._menu_item_used_last = Item_Get(Battle_GetMenuChoiceItem());
			Item_CallEvent(obj_battle_controller._menu_item_used_last, ITEM_EVENT.USE, Battle_GetMenuChoiceItem());
	        //Item_CallEvent(Item_Get(Battle_GetMenuChoiceItem()), ITEM_EVENT.USE, Battle_GetMenuChoiceItem());
	    }
    
	    if (BUTTON == BATTLE_MENU_CHOICE_BUTTON.FIGHT)
	    {
	        if (instance_exists(obj_battle_menu_fight))
	        {
	            with (obj_battle_menu_fight)
	                event_user(BATTLE_MENU_FIGHT_EVENT.END);
	        }
	    }

	    if (BUTTON == BATTLE_MENU_CHOICE_BUTTON.MERCY && MERCY == BATTLE_MENU_CHOICE_MERCY.FLEE)
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
	        if (BUTTON == BATTLE_MENU_CHOICE_BUTTON.MERCY && MERCY == BATTLE_MENU_CHOICE_MERCY.FLEE && Battle_IsFleeable())
	        {
	            Battle_SetState(BATTLE_STATE.RESULT);
	            Battle_SetNextState(BATTLE_STATE.RESULT);
	            instance_create_depth(0, 0, 0, obj_battle_result_flee);
            
	            var EXP = Battle_GetRewardExp();
	            var GOLD = Battle_GetRewardGold();
	            var text = "";
	            if (GOLD == 0 && EXP == 0)
	            {
	                var rand = irandom(20);
	                var fled_text = 0;
	                if (rand < 2) fled_text = 1;
	                else if (rand == 2) fled_text = 2;
	                else if (rand == 3) fled_text = 3;
	                else fled_text = 0;
					
	                text += lexicon_text($"battle.result.fled.{fled_text}");
	            }
	            else
	            {   
	                text += lexicon_text("battle.result.fled.reward", EXP, GOLD);
					
	                Player_SetExp(Player_GetExp() + Battle_GetRewardExp());
	                Player_SetGold(Player_GetGold() + Battle_GetRewardGold());
	                if (Player_UpdateLv())
	                    audio_play_sound(snd_level_up, 0, false);
	            }
	            Battle_SetDialog(text);
	        }
	        else
	            Battle_GotoNextState();
	    }
	    return true;
	}
	else
	    return false;
}

#endregion

#region Button

function Battle_GetMenuChoiceButton() {
	return obj_battle_controller._menu_choice_button;
}

///@arg button_choice
///@arg [call_event]
function Battle_SetMenuChoiceButton(BUTTON, CALL = true) {
	if (BUTTON >= 0 && BUTTON <= 3)
	{
	    obj_battle_controller._menu_choice_button = BUTTON;
    
	    if (CALL)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}

#endregion

#region Enemy

function Battle_GetMenuChoiceEnemy() {
	return obj_battle_controller._menu_choice_enemy;
}

///@arg enemy_choice
///@arg [call_event]
function Battle_SetMenuChoiceEnemy(ENEMY, CALL = true) {
	if (ENEMY >= 0 && ENEMY < Battle_GetEnemyNumber())
	{
	    obj_battle_controller._menu_choice_enemy = ENEMY;
    
	    if (CALL)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}

#endregion

#region Action

function Battle_GetMenuChoiceAction() {
	return obj_battle_controller._menu_choice_action;
}

///@arg action_choice
///@arg [call_event]
function Battle_SetMenuChoiceAction(ACTION, CALL = true) {
	if (ACTION >= 0 && ACTION <= 5)
	{
	    obj_battle_controller._menu_choice_action = ACTION;
    
	    if (CALL)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}

#endregion

#region Item

function Battle_GetMenuChoiceItem() {
	return obj_battle_controller._menu_choice_item;
}

///@arg item_choice
///@arg [call_event]
function Battle_SetMenuChoiceItem(slot, call = true) {	
	if (slot < Item_Count())
	{
		var _item_scroll_mode = obj_battle_textwriter.item_scroll_mode;
		obj_battle_controller._menu_choice_item = slot;
		switch (_item_scroll_mode)
		{
			case BATTLE_MENU_ITEM.HORIZONTAL:
				obj_battle_controller._menu_choice_item_first = (slot div 4) * 4;
				break;
			
			case BATTLE_MENU_ITEM.VERTICAL:
				while (slot >= obj_battle_controller._menu_choice_item_first + 3)
				    obj_battle_controller._menu_choice_item_first += 1;
    
				while (slot < obj_battle_controller._menu_choice_item_first)
				    obj_battle_controller._menu_choice_item_first -= 1;
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
	return obj_battle_controller._menu_item_used_last;
}

#endregion

#region Mercy

function Battle_GetMenuChoiceMercy() {
	return obj_battle_controller._menu_choice_mercy;
}

///@arg mercy_choice
///@arg [call_event]
function Battle_SetMenuChoiceMercy(MERCY, CALL = true) {
	if ((!Battle_IsMenuChoiceMercyOverride() && MERCY >= 0 && MERCY <= 1) || 
		 (Battle_IsMenuChoiceMercyOverride() && MERCY >= 0 && MERCY < Battle_GetMenuChoiceMercyOverrideNumber()))
	{
	    obj_battle_controller._menu_choice_mercy = MERCY;
    
	    if (CALL)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
    
	    return true;
	}
	else
	    return false;
}

#region Overriding

	///@arg override
	function Battle_SetMenuChoiceMercyOverride(OVERRIDE) {
		obj_battle_controller._menu_choice_mercy_override = OVERRIDE;
		return true;
	}

	function Battle_IsMenuChoiceMercyOverride() {
		return obj_battle_controller._menu_choice_mercy_override;
	}

	function Battle_GetMenuChoiceMercyOverrideNumber() {
		return  obj_battle_controller._menu_choice_mercy_override_number;
	}

	///@arg number
	function Battle_SetMenuChoiceMercyOverrideNumber(NUMBER) {
		if (NUMBER >= 1 && NUMBER <= 3)
		{
		    obj_battle_controller._menu_choice_mercy_override_number = NUMBER;
		    return true;
		}
		else
		    return false;
	}

	///@arg choice_mercy_slot
	function Battle_GetMenuChoiceMercyOverrideName(SLOT) {
		if (SLOT >= 0 && SLOT <= 2)
		    return obj_battle_controller._menu_choice_mercy_override_name[SLOT];
		else
		    return "";
	}

	///@arg choice_mercy_slot
	///@arg name
	function Battle_SetMenuChoiceMercyOverrideName(SLOT, NAME) {
		if (SLOT >= 0 && SLOT <= 2)
		{
		    obj_battle_controller._menu_choice_mercy_override_name[SLOT] = NAME;
		    return true;
		}
		else
		    return false;
	}

#endregion

#endregion
