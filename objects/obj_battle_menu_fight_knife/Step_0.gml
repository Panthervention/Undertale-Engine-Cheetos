if (__input_acceptable)
{
    if (__aim_x == __aim_x_target)
	{
        Battle_SetMenuFightDamage(-1);
        Battle_EndMenuFightAim();
        __input_acceptable = false;
		__aim_confirm = true;
    }
    
    if (input_check_pressed("confirm") && __input_acceptable && !__aim_confirm)
    {
		__input_acceptable = false;
		__aim_confirm = true;
        TweenDestroy(__aim_x_tween);
        __effect = true;
        alarm[0] = 1;
        
        var _atk = Player_GetAtkTotal(),
			_def = Battle_GetEnemyDEF(Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy())),
			_distance = point_distance(x, y, __aim_x, y),
			_width = sprite_get_width(spr_battle_menu_fight_bg) * 0.5;
		
        var _damage = _atk - _def + random(2);

        if (_distance <= 12)
            _damage *= 2.2;
        else
            _damage *= (1 - _distance / _width) * 2;
			
        _damage = round(_damage);
		
        if (_damage <= 0)
            _damage = 1;
        
        Battle_SetMenuFightDamage(_damage);
        Battle_SetMenuFightAnimTime(50);
        Battle_SetMenuFightDamageTime(45);
        Battle_EndMenuFightAim();
    }
}
