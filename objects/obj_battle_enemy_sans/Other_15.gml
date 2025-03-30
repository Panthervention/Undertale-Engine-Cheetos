///@desc Menu End

switch (Battle_GetMenuChoiceButton())
{
    case BATTLE_MENU_CHOICE_BUTTON.FIGHT:
		// Check if enemy is dead and ready to be dusted
        //if (hp <= 0)
        //{
        //    // Create particle effect
		//	// Requires better handling because this is flawed!
        //    var inst = instance_create_depth(x, y, 0, obj_battle_death_particle);
        //    inst.sprite = sprite_index;
        //    audio_play_sound(snd_vaporize, 0, false);
        //    instance_destroy();
        //}
        global.menu_hurt = "de-activated";
        global.deadable = true;
        break;
    case BATTLE_MENU_CHOICE_BUTTON.ACT:
        switch (Battle_GetMenuChoiceAction())
        {
            case 0: // Check
                Dialog_Add(_check_dialog[_check_status]);
                global.menu_hurt = "de-activated";
                global.deadable = true;
                break;
        }
    case BATTLE_MENU_CHOICE_BUTTON.ITEM:
    case BATTLE_MENU_CHOICE_BUTTON.MERCY:
        global.menu_hurt = "de-activated";
        global.deadable = true;
        break;
}
