///@desc Menu Switch 
switch (Battle_GetMenu())
{
	case BATTLE_MENU.FIGHT_TARGET:
		// In case you wanna show enemy's HP in the fight target selection
		//var _hp_bar = instance_create_depth(0, 0, 0, obj_battle_menu_fight_hp_bar);
	    //_hp_bar.enemy_slot = __enemy_slot;
	    //_hp_bar.hp_max = hp_max;
	    //_hp_bar.hp = hp;
		break;
		
    case BATTLE_MENU.FIGHT_ANIM:
        if (Battle_GetMenuFightDamage() >= 0)
        {
            if (Battle_GetTurnNumber() != 24) // If not special attack, dodge!
            {
				var _rand = choose(0, 1);
				if (_rand)
					TweenFire(id, "oCirc", 0, off, 0, 30, "x>", 200);
				else
					TweenFire(id, "oCirc", 0, off, 0, 30, "x>", 440);
				TweenFire(id, "oCirc", 0, off, 40, 30, "x>", 320);
                __body_sprite = spr_sans_body;
                __body_image = 2;
                alarm[1] = 40;
            }
        }
        break;
    case BATTLE_MENU.FIGHT_DAMAGE:
        if (Battle_GetMenuFightDamage() >= 0)
        {
            if (Battle_GetTurnNumber() != 24)
            {
				// Dodged so miss
                var _miss = instance_create_depth(320, (y - 185), 0, obj_battle_damage);
                _miss.damage = "MISS";
				_miss.color = c_gray;
            }
            else
            {
				// Damage Calculation on hit
                var _dmg = instance_create_depth(320, (y - 185), 0, obj_battle_damage);
                _dmg.damage = 999999999;
                _dmg.bar_visible = false; // Doesn't let the hp bar visible
				hp = 0;
                __body_image = 0;
                alarm[3] = 1;
                alarm[4] = 40;
                __head_image = 16;
                audio_play_sound(snd_hard_damage, 1, false);
            }
        }
		break;
}
