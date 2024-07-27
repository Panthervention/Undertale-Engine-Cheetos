depth = DEPTH_UI.PANEL;

_color = c_white;

_box_slot = 0;
_choice_mode = 0;
_choice_item = 0;


if (instance_exists(obj_char_player))
    obj_char_player._moveable_box = false;

_label_inventory = lexicon_text("ui.box.inventory");
_label_box		 = lexicon_text("ui.box.box");
_label_finish	 = lexicon_text("ui.box.finish");

_prefix = "[scale, 2][font_dt_sans]";
event_user(0); // Update item label
