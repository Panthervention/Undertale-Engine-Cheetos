/// @description Update Text Elements

_player_name		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.NAME);
_player_lv			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.LV);
_player_xp			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.EXP);
_player_xp_next		=	Player_GetLvExp(_player_lv + 1) - _player_xp; 
_player_kill		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.KILLS);
_player_hp			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP);
_player_hp_max		=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX);
_player_gold		=   Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD);
_player_atk			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK);
_player_atk_item	=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK_ITEM);
_player_def			=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF);
_player_def_item	=	Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF_ITEM);
_player_weapon		=	Item_GetName(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM_WEAPON));
_player_armor		=	Item_GetName(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ITEM_ARMOR));
_label_lv				=	$"LV   {_player_lv}";
_label_hp				=	$"HP   {_player_hp}/{_player_hp_max}";
_label_g				=	"G";
_label_item_use			=	lexicon_text("ui.menu.item_use");
_label_item_info		=	lexicon_text("ui.menu.item_info");
_label_item_drop		=	lexicon_text("ui.menu.item_drop");
_label_item_count		=	Item_Count();
_label_item				=	lexicon_text("ui.menu.item");
_label_stat				=	lexicon_text("ui.menu.stat");
_label_cell				=	lexicon_text("ui.menu.cell");
_label_address_count	=	Cell_AddressCount();
_label_item_name		=	function() {
								var _item_name = "", i = 0;
								repeat (Item_Count())
								    _item_name += Item_GetName(Item_Get(i++)) + "\n";
								return _item_name;
							};
_label_cell_address		=	function() {
								var _address = "", i = 0;
								repeat (Cell_AddressCount())
									_address += Cell_GetName(Cell_GetAdress(i++)) + "\n";
								return _address;
							};
_label_stats_name		=	lexicon_text("ui.menu.stats.0", _player_name);
_label_stats_vitality	=	lexicon_text("ui.menu.stats.1", _player_lv, _player_hp, _player_hp_max,
								_player_atk, _player_atk_item, _player_def, _player_def_item);
_label_stats_equipment	=	lexicon_text("ui.menu.stats.2", _player_weapon, _player_armor);
_label_stats_gold		=	lexicon_text("ui.menu.stats.3", _player_gold);
_label_stats_xp			=	lexicon_text("ui.menu.stats.4", _player_xp, _player_xp_next);
_label_stats_kill_count	=	lexicon_text("ui.menu.stats.5", _player_kill);

_draw_item_name			=	scribble($"{_prefix}{_label_item_name()}");
_draw_cell_address		=	scribble($"{_prefix}{_label_cell_address()}");

_draw_item_name		.build(true);
_draw_cell_address	.build(true);
