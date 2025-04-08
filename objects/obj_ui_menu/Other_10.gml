/// @description Update Text Elements
/* Feather ignore all */
__player_name		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.NAME);
__player_lv			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.LV);
__player_xp			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.EXP);
__player_xp_next	=	Player_GetLvExp(__player_lv + 1) - __player_xp; 
__player_kill		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.KILLS);
__player_hp			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP);
__player_hp_max		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX);
__player_gold		=   Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD);
__player_atk		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK);
__player_atk_item	=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK_ITEM);
__player_def		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF);
__player_def_item	=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF_ITEM);
__player_weapon		=	Item_GetName(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM_WEAPON));
__player_armor		=	Item_GetName(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM_ARMOR));
__label_lv					=	$"LV   {__player_lv}";
__label_hp					=	$"HP   {__player_hp}/{__player_hp_max}";
__label_g					=	"G";
__label_item_use			=	lexicon_text("ui.menu.item_use");
__label_item_info			=	lexicon_text("ui.menu.item_info");
__label_item_drop			=	lexicon_text("ui.menu.item_drop");
__label_item_count			=	Item_Count();
__label_item				=	lexicon_text("ui.menu.item");
__label_stat				=	lexicon_text("ui.menu.stat");
__label_cell				=	lexicon_text("ui.menu.cell");
__label_address_count		=	Cell_AddressCount();
__label_item_name			=	function() {
									var _item_name = "", i = 0;
									repeat (Item_Count())
									    _item_name += Item_GetName(Item_Get(i++)) + "\n";
									return _item_name;
								};
__label_cell_address		=	function() {
									var _address = "", i = 0;
									repeat (Cell_AddressCount())
										_address += Cell_GetName(Cell_GetAdress(i++)) + "\n";
									return _address;
								};
__label_stats_name			=	lexicon_text("ui.menu.stats.0", __player_name);
__label_stats_vitality		=	lexicon_text("ui.menu.stats.1", __player_lv, __player_hp, __player_hp_max,
								__player_atk, __player_atk_item, __player_def, __player_def_item);
__label_stats_equipment		=	lexicon_text("ui.menu.stats.2", __player_weapon, __player_armor);
__label_stats_gold			=	lexicon_text("ui.menu.stats.3", __player_gold);
__label_stats_xp			=	lexicon_text("ui.menu.stats.4", __player_xp, __player_xp_next);
__label_stats_kill_count	=	lexicon_text("ui.menu.stats.5", __player_kill);

__draw_item_name		=	scribble($"{__prefix}{__label_item_name()}");
__draw_cell_address		=	scribble($"{__prefix}{__label_cell_address()}");

__draw_item_name	.build(true);
__draw_cell_address	.build(true);
