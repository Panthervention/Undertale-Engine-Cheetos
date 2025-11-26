depth = DEPTH_UI.PANEL;

__color = c_white;

__box_slot = 0;
__choice_mode = 0;
__choice_item = 0;

if (instance_exists(obj_char_player))
    obj_char_player.__moveable_box = false;

__label_inventory	= Lexicon("ui.box.inventory").Get();
__label_box			= Lexicon("ui.box.box").Get();
__label_finish		= Lexicon("ui.box.finish").Get();

__prefix = "[scale, 2][font_dt_sans]";