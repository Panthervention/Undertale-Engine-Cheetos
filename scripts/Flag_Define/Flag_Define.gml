///@func Flag_Define()
///@desc Initialize default value for defined flag entries within this function.
function Flag_Define()
{
	#region Static
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.NAME, "CHARA");
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.LV, 1);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX, 20);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP, 20);
	
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.EXP, 0);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD, 0);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.KILLS, 0);
	
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ATK, 0);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.DEF, 0);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.SPD, 2);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.INV, 60);
	
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.BATTLE_MENU_FIGHT_OBJ, obj_battle_menu_fight_knife);
	
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM, []);
	
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM_WEAPON, -1);
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM_ARMOR, -1);
	#endregion
	
	#region Temp
	Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.KR, 0);
	
	Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.BATTLE_ROOM_RETURN, -1);
	
	Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_LANDMARK, noone);
	Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.TRIGGER_WARP_DIR, -1);
	
	Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.TEXTWRITER_CHOICE, -1);	
	#endregion
	
	#region Item
	Dictionary_Item_Init(); // Load the item dictionary before usage
	
	Item_Set(0, item_pie);
	Item_Set(1, item_noodles);
	Item_Set(2, item_steak);
	Item_Set(3, item_snow);
	Item_Set(4, item_snow);
	Item_Set(5, item_snow);
	Item_Set(6, item_lhero);
	Item_Set(7, item_lhero);

	Player_SetWeapon(weapon_stick);
	Player_SetArmor(armor_bandage);
	#endregion
	
	#region Cell
	Dictionary_Cell_Init(); // Load cell address dictionary before usage
	
	Cell_SetAddress(0, cell_toriel);
	Cell_SetAddress(1, cell_box_a);
	Cell_SetAddress(2, cell_box_b);
	#endregion
}
