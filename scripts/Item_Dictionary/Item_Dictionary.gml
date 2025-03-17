#region Item Enumerators

enum ITEM_EVENT {
	USE,
	INFO,
	DROP,
}

enum ITEM_TYPE {
	CONSUMABLE,
	EQUIPMENT,
}
	
enum ITEM {
	TEMPLATE,
	
	PIE,
	NOODLES,
	STEAK,
	L_HERO,
	SNOW,
	
	STICK,
	BANDAGE,
	TOY_KNIFE,
	RIBBON,
}
#endregion

#region Macro
	#macro item_template new Item()

	#region Consumable
	#macro item_pie		new Item_Pie()
	#macro item_noodles new Item_Noodles()
	#macro item_steak	new Item_Steak()
	#macro item_lhero	new Item_LegendaryHero()
	#macro item_snow	new Item_SnowPiece()
	#endregion
	
	#region Equipment
	#macro weapon_stick			new Weapon_Stick()
	#macro weapon_toy_knife		new Weapon_ToyKnife()
	
	#macro armor_bandage		new Armor_Bandage()
	#macro armor_ribbon			new Armor_FadedRibbon()
	#endregion
#endregion

#region Item Template
function Item() constructor {
	// Compulsory variables
	item_id = ITEM.TEMPLATE;
	type = ITEM_TYPE.CONSUMABLE; // Either consumable or equipment
	uses = 1; // Only needed when the type is consumable
	type_equipment = ""; // Either "weapon" or "armor"
	name = "Cheetos";
	name_short = "RTF";
	name_short_serious = "Eden";
		
	#region Non-compulsory variables
	desc_info = undefined;			// This is a template for your item
	desc_use_before = undefined;	// This dialog plays before the "You ate ..."
	desc_use_after = undefined;	// This dialog plays after the "You healed x HP"
		
	heal = undefined;
	atk = undefined;
	def = undefined;
	spd = undefined;
	inv = undefined;
	effect = function() {
		// Your effect goes here
	};
	#endregion
}
#endregion

#region Item Dictionary
	#region Consumable
	function Item_Pie() : Item() constructor {
		item_id = ITEM.PIE;
		type = ITEM_TYPE.CONSUMABLE;
		uses = 4;
		name = lexicon_text("item.pie.name");
		name_short = lexicon_text("item.pie.name_short");
		name_short_serious = lexicon_text("item.pie.name_short_serious");

		heal = infinity;
		desc_info = lexicon_text("item.pie.info");
		effect = function(_item) {
			show_debug_message("uses: {0}", _item.uses - 1);
		};
	}
	function Item_Noodles() : Item() constructor {
		item_id = ITEM.NOODLES;
		type = ITEM_TYPE.CONSUMABLE;
		uses = 1;
		name = lexicon_text("item.noodles.name");
		name_short = lexicon_text("item.noodles.name_short");
		name_short_serious = lexicon_text("item.noodles.name_short_serious");
		
		heal = 90;
		desc_info = lexicon_text("item.noodles.info");
		desc_use_before = lexicon_text("item.noodles.use.before");
	};
	function Item_Steak() : Item() constructor {
		item_id = ITEM.STEAK;
		type = ITEM_TYPE.CONSUMABLE;
		uses = 1;

		name = lexicon_text("item.face_steak.name");
		name_short = lexicon_text($"item.face_steak.name_short.{real((string_lower(Player_GetName()) == "drak" || string_lower(Player_GetName()) == "gigi" || string_lower(Player_GetName()) == "gugu"))}");
		name_short_serious = lexicon_text("item.face_steak.name_short_serious");
		
		heal = 60;
		desc_info = lexicon_text("item.face_steak.info", heal);
	};
	function Item_SnowPiece() : Item() constructor {
		item_id = ITEM.SNOW;
		type = ITEM_TYPE.CONSUMABLE;
		uses = 1;
		name = lexicon_text("item.snow.name");
		name_short = lexicon_text("item.snow.name_short");
		name_short_serious = lexicon_text("item.snow.name_short_serious");

		heal = 45;
		desc_info = lexicon_text("item.snow.info", heal);
	}

	function Item_LegendaryHero() : Item() constructor {
		item_id = ITEM.L_HERO;
		type = ITEM_TYPE.CONSUMABLE;
		uses = 1;
		name = lexicon_text("item.legendary_hero.name");
		name_short = lexicon_text("item.legendary_hero.name_short");
		name_short_serious = lexicon_text("item.legendary_hero.name_short_serious");

		heal = 40;
		desc_info = lexicon_text("item.legendary_hero.info", heal);
		desc_use_after = lexicon_text("item.legendary_hero.use.after");
	}
	#endregion
	
	#region Equipment
	function Weapon_Stick() : Item() constructor {
		item_id = ITEM.STICK;
		type = ITEM_TYPE.CONSUMABLE;
		uses = infinity;
		name = lexicon_text("item.stick.name");
		name_short = lexicon_text("item.stick.name");
		name_short_serious = lexicon_text("item.stick.name");		
		
		desc_info = lexicon_text("item.stick.info");
		
		atk = 0;
	};
	function Armor_Bandage() : Item() constructor {
		item_id = ITEM.BANDAGE;
		type = ITEM_TYPE.CONSUMABLE;
		uses = 1;
		name = lexicon_text("item.bandage.name");
		name_short = lexicon_text("item.bandage.name");
		name_short_serious = lexicon_text("item.bandage.name");

		desc_info = lexicon_text("item.bandage.info");
		
		heal = 10;
		def = 0;
	}
	function Weapon_ToyKnife() : Item() constructor {
		item_id = ITEM.TOY_KNIFE;
		type = ITEM_TYPE.EQUIPMENT;
		type_equipment = "weapon";
		name = lexicon_text("item.toy_knife.name");
		name_short = lexicon_text("item.toy_knife.name");
		name_short_serious = lexicon_text("item.toy_knife.name");

		desc_info = lexicon_text("item.toy_knife.info");

		atk = 3;
	}
	function Armor_FadedRibbon() : Item() constructor {
		item_id = ITEM.RIBBON;
		type = ITEM_TYPE.EQUIPMENT;
		type_equipment = "armor";
		name = lexicon_text("item.faded_ribbon.name");
		name_short = lexicon_text("item.faded_ribbon.name.short");
		name_short_serious = lexicon_text("item.faded_ribbon.name.short");

		desc_info = lexicon_text("item.faded_ribbon.info");

		def = 3;
	}
	#endregion
#endregion

function Dictionary_Item_Init() {
	// Used as a base for comparison with the item in the inventory
	global._dictionary_item = [];
	global._dictionary_item[ITEM.TEMPLATE]		= item_template;
	global._dictionary_item[ITEM.PIE]			= item_pie;
	global._dictionary_item[ITEM.NOODLES]		= item_noodles;
	global._dictionary_item[ITEM.STEAK]			= item_steak;
	global._dictionary_item[ITEM.SNOW]			= item_snow;
	global._dictionary_item[ITEM.L_HERO]		= item_lhero;
	global._dictionary_item[ITEM.STICK]			= weapon_stick;
	global._dictionary_item[ITEM.BANDAGE]		= armor_bandage;
	global._dictionary_item[ITEM.TOY_KNIFE]		= weapon_toy_knife;
	global._dictionary_item[ITEM.RIBBON]		= armor_ribbon;
}
