///@desc Menu Switch 
switch (Battle_GetMenu())
{
	case BATTLE_MENU.FIGHT_TARGET:
		// In case you wanna show enemy's HP in the fight target selection
		//a = instance_create_depth(0, 0, 0, obj_battle_menu_fight_hp_bar);
	    //a.enemy_slot = _enemy_slot;
	    //a.hp_max = hp_max;
	    //a.hp = hp;
		break;
		
    case BATTLE_MENU.FIGHT_ANIM:
        {
            if (Battle_GetMenuFightDamage() >= 0)
            {
                if (Battle_GetTurnNumber() != 24) // If not special attack, dodge!
                {
                    if (obj_battle_menu_fight_knife._aim_x > 240 && obj_battle_menu_fight_knife._aim_x < 400)
                    {
                        if (obj_battle_menu_fight_knife._aim_x >= 320)
                        {
							TweenFire(id, "oCirc", 0, off, 0, 30, "x>", 200);
							TweenFire(id, "oCirc", 0, off, 40, 30, "x>", 320);
                        }
                        else if (obj_battle_menu_fight_knife._aim_x < 320)
                        {
							TweenFire(id, "oCirc", 0, off, 0, 30, "x>", 440);
							TweenFire(id, "oCirc", 0, off, 40, 30, "x>", 320);
                        }
                    }
                    _body_sprite = spr_sans_body;
                    _body_image = 2;
                    alarm[1] = 40;
                }
            }
        }
        break;
    case BATTLE_MENU.FIGHT_DAMAGE:
        {
            if (Battle_GetMenuFightDamage() != 1)
            {
                if (Battle_GetTurnNumber() != 24)
                {
					// Dodged so miss
                    a = instance_create_depth(320, (y - 185), 0, obj_battle_damage);
                    a.damage = -2;
                }
                else
                {
					// Damage Calculation on hit
                    a = instance_create_depth(320, (y - 185), 0, obj_battle_damage);
                    a.damage = 999999999;
                    a.bar_visible = 0; // Doesn't let the hp bar visible
                    _body_image = 0;
                    alarm[3] = 1;
                    alarm[4] = 40;
                    _head_image = 16;
                    audio_play_sound(snd_hard_damage, 1, false);
                }
            }
        }
		break;
}
