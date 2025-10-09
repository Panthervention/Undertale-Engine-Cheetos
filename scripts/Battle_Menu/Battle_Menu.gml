#region Menu
///@func Battle_SetMenuDialogVisible(visible)
///@desc Set visibility of the menu dialog.
///@param {Bool}	visible
function Battle_SetMenuDialogVisible(_visible) {
	menu_dialog_visible = _visible;
}

///@func Battle_GetMenu()
///@desc Return the current state of the battle menu. 
///@return {Real}
function Battle_GetMenu() {
	return obj_battle_controller.__menu;
}

///@func Battle_SetMenu(menu, [call_event])
///@desc Set the state for the battle menu.
///@param {Real}	menu			The state of the battle menu to set.
///@param {Bool}	[call_event]	Whenever the enemy's Menu Switch (User Event 3) should be executed. (Default: true)
function Battle_SetMenu(_menu, _call_event = true) {
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
		
		obj_battle_controller.ui_fight.initialize();
	}
 
	if (_menu == BATTLE_MENU.ACT_ACTION)
	{
	    var _enemy_slot = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
	    var _enemy_action_count = Battle_GetEnemyActionNumber(_enemy_slot);

	    if (Battle_GetMenuChoiceAction() >= _enemy_action_count)
	        Battle_SetMenuChoiceAction(0, false);
	}

	if (_menu == BATTLE_MENU.ITEM)
	{
	    Battle_SetMenuChoiceItem(0);
		with (obj_battle_controller)
		{
			__menu_choice_item_first = 0;
			__menu_choice_item = 0;
		}
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

	if (_call_event)
	    Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_SWITCH);

	if (_menu == BATTLE_MENU.FIGHT_ANIM)
		obj_battle_controller.ui_fight.anim();

	if (_menu == BATTLE_MENU.FIGHT_DAMAGE)
		obj_battle_controller.ui_fight.damage();
}

///@func Battle_EndMenu()
///@desc End the battle menu state.
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
			obj_battle_controller.ui_fight.finish();

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
            
	            var _exp = Battle_GetRewardExp(),
					_gold = Battle_GetRewardGold(),
					_text = "";
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
///@func Battle_GetMenuChoiceButton()
///@desc Return the currently selected menu button.
///@return {Real}
function Battle_GetMenuChoiceButton() {
	return obj_battle_controller.__menu_choice_button;
}

///@func Battle_SetMenuChoiceButton(button, [call_event])
///@desc Set the current menu button.
///@param {Real}	button			The index of the button to set (between 0 and 3).
///@param {Bool}	[call_event]	Whenever the enemy's Menu Choice Switch (User Event 4) should be executed. (Default: true)
function Battle_SetMenuChoiceButton(_button, _call_event = true) {
	if (_button >= 0 && _button <= 3)
	{
	    obj_battle_controller.__menu_choice_button = _button;
    
	    if (_call_event)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
	}
}
#endregion

#region Enemy
///@func Battle_GetMenuChoiceEnemy()
///@desc Return the currently selected enemy.
///@return {Real}
function Battle_GetMenuChoiceEnemy() {
	return obj_battle_controller.__menu_choice_enemy;
}

///@func Battle_SetMenuChoiceEnemy(enemy, [call_event])
///@desc Set the current enemy target.
///@param {Real}	enemy			The index of the enemy to set (between 0 and 2).
///@param {Bool}	[call_event]	Whenever the enemy's Menu Choice Switch (User Event 4) should be executed. (Default: true)
function Battle_SetMenuChoiceEnemy(_enemy, _call_event = true) {
	if (_enemy >= 0 && _enemy < Battle_GetEnemyNumber())
	{
	    obj_battle_controller.__menu_choice_enemy = _enemy;
    
	    if (_call_event)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
	}
}
#endregion

#region Action
///@func Battle_GetMenuChoiceAction()
///@desc Return the currently selected enemy's action.
///@return {Real}
function Battle_GetMenuChoiceAction() {
	return obj_battle_controller.__menu_choice_action;
}

///@func Battle_SetMenuChoiceAction(action, [call_event])
///@desc Set the current enemy's action.
///@param {Real}	action			The index of the action (between 0 and 5).
///@param {Bool}	[call_event]	Whenever the enemy's Menu Choice Switch (User Event 4) should be executed. (Default: true)
function Battle_SetMenuChoiceAction(_action, _call_event = true) {
	if (_action >= 0 && _action <= 5)
	{
	    obj_battle_controller.__menu_choice_action = _action;
    
	    if (_call_event)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
	}
}
#endregion

#region Item
///@func Battle_GetMenuChoiceItem()
///@desc Return the currently selected item.
///@return {Real}
function Battle_GetMenuChoiceItem() {
	return obj_battle_controller.__menu_choice_item;
}

///@func Battle_SetMenuChoiceItem(slot, [call_event])
///@desc Set the current item slot.
///@param {Real}	item			The item slot in the inventory (between 0 and 7)
///@param {Bool}	[call_event]	Whenever the enemy's Menu Choice Switch (User Event 4) should be executed. (Default: true)
function Battle_SetMenuChoiceItem(_slot, _call_event = true) {	
	if (_slot < Item_Count())
	{
		var _item_scroll_mode = obj_battle_textwriter.item_scroll_mode;
		obj_battle_controller.__menu_choice_item = _slot;
		switch (_item_scroll_mode)
		{
			case BATTLE_MENU_ITEM.HORIZONTAL:
				obj_battle_controller.__menu_choice_item_first = (_slot div 4) * 4;
				break;
			
			case BATTLE_MENU_ITEM.VERTICAL:
				while (_slot >= obj_battle_controller.__menu_choice_item_first + 3)
				    obj_battle_controller.__menu_choice_item_first++;
    
				while (_slot < obj_battle_controller.__menu_choice_item_first)
				    obj_battle_controller.__menu_choice_item_first--;
				break;
		}
 
	    if (_call_event)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
	}
}

///@func Battle_GetMenuItemUsedLast()
///@desc Return the item that was last used.
///@return {Struct}
function Battle_GetMenuItemUsedLast() {
	 return obj_battle_controller.__menu_item_used_last;
}
#endregion

#region Mercy
///@func Battle_GetMenuChoiceMercy() 
///@desc Return the currently selected mercy option.
///@return {Real}
function Battle_GetMenuChoiceMercy() {
	return obj_battle_controller.__menu_choice_mercy;
}

///@func Battle_SetMenuChoiceMercy(mercy, [call_event])
///@desc Set the current mercy option.
///@param {Real}	mercy			The mercy option to set (between 0 and 1).
///@param {Bool}	[call_event]	Whenever the enemy's Menu Choice Switch (User Event 4) should be executed. (Default: true)
function Battle_SetMenuChoiceMercy(_mercy, _call_event = true) {
	if ((!Battle_IsMenuChoiceMercyOverride() && _mercy >= 0 && _mercy <= 1) || 
		 (Battle_IsMenuChoiceMercyOverride() && _mercy >= 0 && _mercy < Battle_GetMenuChoiceMercyOverrideNumber()))
	{
	    obj_battle_controller.__menu_choice_mercy = _mercy;
    
	    if (_call_event)
	        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);  
	}
}

#region Overriding
///@func Battle_SetMenuChoiceMercyOverride(override)
///@desc Set whenever the mercy options are overridable or not.
///@param {Bool}	override	Overridability of the mercy options.
function Battle_SetMenuChoiceMercyOverride(_override) {
	obj_battle_controller.__menu_choice_mercy_override = _override;
}

///@func Battle_IsMenuChoiceMercyOverride()
///@desc Return whenever the mercy options are overridable or not.
///@return {Bool}
function Battle_IsMenuChoiceMercyOverride() {
	return obj_battle_controller.__menu_choice_mercy_override;
}

///@func Battle_GetMenuChoiceMercyOverrideNumber()
///@desc Return the current amount of active custom mercy override options.
///@return {Real}
function Battle_GetMenuChoiceMercyOverrideNumber() {
	return obj_battle_controller.__menu_choice_mercy_override_number;
}

///@func Battle_SetMenuChoiceMercyOverrideNumber(number)
///@desc Set the amount of custom mercy override options in the battle menu (between 1 and 3).
///@param {Real}	number		The number of mercy override options.
function Battle_SetMenuChoiceMercyOverrideNumber(_number) {
	if (_number >= 1 && _number <= 3)
		obj_battle_controller.__menu_choice_mercy_override_number = _number;
}

///@func Battle_GetMenuChoiceMercyOverrideName(choice_mercy_slot)
///@desc Return the custom label of a specified mercy override slot.
///@param {Real}	choice_mercy_slot	The index of the custom label.
///@return {String}
function Battle_GetMenuChoiceMercyOverrideName(_choice_mercy_slot) {
	return (_choice_mercy_slot >= 0 && _choice_mercy_slot <= 2) ? obj_battle_controller.__menu_choice_mercy_override_name[_slot] : "";
}

///@func Battle_SetMenuChoiceMercyOverrideName(choice_mercy_slot, name)
///@desc Set the name of the custom label to the specified mercy override slot.
///@param {Real}	choice_mercy_slot	The index of the custom label.
///@param {String}	name				The name of the custom label.
function Battle_SetMenuChoiceMercyOverrideName(_choice_mercy_slot, _name) {
	if (_choice_mercy_slot >= 0 && _choice_mercy_slot <= 2)
		obj_battle_controller.__menu_choice_mercy_override_name[_choice_mercy_slot] = _name;
}
#endregion
#endregion
