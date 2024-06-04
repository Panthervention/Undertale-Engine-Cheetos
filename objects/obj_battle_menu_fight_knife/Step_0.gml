if (_input_acceptable)
{
    if (_aim_x == _aim_x_target)
	{
        Battle_SetMenuFightDamage(-1);
        Battle_EndMenuFightAim();
        _input_acceptable = false;
		_aim_confirm = true;
    }
    
    if (input_check_pressed("confirm") && _input_acceptable && !_aim_confirm)
    {
		_input_acceptable = false;
		_aim_confirm = true;
        TweenDestroy(_aim_x_tween);
        _effect = true;
        alarm[0] = 1;
        
        var ATK = Player_GetAtkTotal();
        var DEF = Battle_GetEnemyDEF(Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy()));
        var DISTANCE = point_distance(x, y, _aim_x, y);
        var WIDTH = sprite_get_width(spr_battle_menu_fight_bg) * 0.5;
		
        var damage = ATK - DEF + random(2);

        if (DISTANCE <= 12)
            damage *= 2.2;
        else
            damage *= (1 - DISTANCE / WIDTH) * 2;
        damage = round(damage);
		
        if (damage <= 0)
            damage = 1;
        
        Battle_SetMenuFightDamage(damage);
        Battle_SetMenuFightAnimTime(50);
        Battle_SetMenuFightDamageTime(45);
        Battle_EndMenuFightAim();
    }
}
