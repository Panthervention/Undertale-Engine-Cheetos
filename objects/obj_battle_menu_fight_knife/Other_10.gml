///@desc Anim 
if ((Battle_GetMenuFightDamage() >= 0) && __aim_confirm == true)
{
	__aim_confirm = 10;
    var _enemy_slot = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy()),
		_enemy_x = Battle_GetEnemyCenterPosX(_enemy_slot),
		_enemy_y = Battle_GetEnemyCenterPosY(_enemy_slot);
    
	var _knife = instance_create_depth(_enemy_x, _enemy_y, 0, obj_battle_menu_fight_anim_knife);
		//_knife.image_angle = __aim_angle;
}
