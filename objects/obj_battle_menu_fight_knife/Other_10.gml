///@desc Anim 
if ((Battle_GetMenuFightDamage() >= 0) && _aim_confirm == true)
{
	_aim_confirm = 10;
    var ENEMY = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
    var X = _aim_x;//Battle_GetEnemyCenterPosX(ENEMY);
    var Y = Battle_GetEnemyCenterPosY(ENEMY);
    knife = instance_create_depth(X, Y, 0, obj_battle_menu_fight_anim_knife);
    knife.image_angle = _aim_angle;
}
