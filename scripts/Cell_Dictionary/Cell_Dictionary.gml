enum CELL_EVENT {
	CALL,
}

#region Need to be adjusted when new cell added
	enum CELL_ADDRESS {
		TEMPLATE,
		TORIEL_PHONE,
		BOX_A,
		BOX_B,
	}

	#region Macro
	#macro cell_toriel	new Cell_Toriel()
	#macro cell_box_a	new Cell_BoxA()
	#macro cell_box_b	new Cell_BoxB()
	#endregion
	
	///@func Dictionary_Cell_Init()
	///@desc Initialize data about cell dictionary.
	function Dictionary_Cell_Init() {
		with (global)
		{
			__dictionary_cell = [];	
			__dictionary_cell[CELL_ADDRESS.TORIEL_PHONE]	= cell_toriel;
			__dictionary_cell[CELL_ADDRESS.BOX_A]			= cell_box_a;
			__dictionary_cell[CELL_ADDRESS.BOX_B]			= cell_box_b;
		}
	}

	#region Cells
	function Cell() constructor {
		is_cell = true;						// Exist for validation check! Do not touch!
		address = CELL_ADDRESS.TEMPLATE;
		name = undefined;
		dialog = undefined;
		event = function(_cell) {
			// Event here
		}
		// Aside from address which MUST be defined, everything else are optional.
	}

	function Cell_Toriel() : Cell() constructor {
		address = CELL_ADDRESS.TORIEL_PHONE;
		name = lexicon_text("cell.toriel.address");
		dialog = lexicon_text("cell.toriel.0");
	}

	function Cell_BoxA() : Cell() constructor {
		address = CELL_ADDRESS.BOX_A;
		name = lexicon_text("cell.dimension_box", "A");
		event = function(_cell) {
			var slot = 0;
			if (!instance_exists(obj_ui_box) && (Item_Count() > 0 || Box_ItemCount(slot) > 0))
			{
				audio_play_sound(snd_phone_box, 0, false);
				var box = instance_create_depth(0, 0, DEPTH_UI.PANEL, obj_ui_box);
					box.__box_slot = slot;
			}
			else
			{
				var rand = irandom(2),
					dialog = lexicon_text($"ui.box.inventory.empty.{rand}");
				Dialog_Add(dialog);
				Dialog_Start();
			}
		};
	}

	function Cell_BoxB() : Cell() constructor {
		address = CELL_ADDRESS.BOX_B;
		name = lexicon_text("cell.dimension_box", "B");
		event = function(_cell) {
			var slot = 1;
			if (!instance_exists(obj_ui_box) && (Item_Count() > 0 || Box_ItemCount(slot) > 0))
			{
				audio_play_sound(snd_phone_box, 0, false);
				var box = instance_create_depth(0, 0, DEPTH_UI.PANEL, obj_ui_box);
					box.__box_slot = slot;
			}
			else
			{
				var rand = irandom(2),
					dialog = lexicon_text($"ui.box.inventory.empty.{rand}");
				Dialog_Add(dialog);
				Dialog_Start();
			}
		};
	}
	#endregion
#endregion
