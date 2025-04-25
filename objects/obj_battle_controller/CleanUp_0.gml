delete ui_info;
delete ui_button;
delete ui_fight;

ui_info = undefined;
ui_button = undefined;
ui_fight = undefined;

delete __turn_info;
delete __menu_item_used_last;

__turn_info = undefined;
__menu_item_used_last = undefined;

if (instance_exists(obj_battle_textwriter))
	instance_destroy(obj_battle_textwriter);

