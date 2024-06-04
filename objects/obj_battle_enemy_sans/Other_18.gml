///@desc Turn Preparation Start

// Prepare the attack 
if (Battle_GetMenuChoiceButton() == BATTLE_MENU_CHOICE_BUTTON.FIGHT)
    instance_create_depth(0, 0, 0, obj_battle_turn_sans_classic);
else if (Battle_GetMenuChoiceButton() == BATTLE_MENU_CHOICE_BUTTON.ACT || Battle_GetMenuChoiceButton() == BATTLE_MENU_CHOICE_BUTTON.ITEM)
{
    if (Battle_GetTurnNumber() != 23) // Dummy number, create attack if not special turn
        instance_create_depth(0, 0, 0, obj_battle_turn_sans_classic);
    else
        Battle_SetNextState(0); // Do nothing
}
else if (Battle_GetMenuChoiceButton() == BATTLE_MENU_CHOICE_BUTTON.MERCY)
{
    if (Battle_GetTurnNumber() != 23) // Dummy number, create attack if not special turn
        instance_create_depth(0, 0, 0, obj_battle_turn_sans_classic);
    else
        Battle_SetNextState(0); // Do nothing
}


