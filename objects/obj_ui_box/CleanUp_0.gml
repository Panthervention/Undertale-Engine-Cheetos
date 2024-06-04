_label_item_inventory	.flush();
_label_item_box			.flush();

if (instance_exists(obj_char_player))
    obj_char_player._moveable_box = true;
