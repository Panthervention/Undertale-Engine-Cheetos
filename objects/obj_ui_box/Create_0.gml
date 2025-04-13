depth = DEPTH_UI.PANEL;

__color = c_white;

__box_slot = 0;
__choice_mode = 0;
__choice_item = 0;

if (instance_exists(obj_char_player))
    obj_char_player.__moveable_box = false;

__label_inventory	= lexicon_text("ui.box.inventory");
__label_box			= lexicon_text("ui.box.box");
__label_finish		= lexicon_text("ui.box.finish");

__prefix = "[scale, 2][font_dt_sans]";
event_user(0); // Update item label
