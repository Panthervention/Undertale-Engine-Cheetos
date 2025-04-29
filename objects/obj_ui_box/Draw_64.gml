draw_sprite_ext(spr_pixel, 0, 16, 16, 610, 450, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, 22, 22, 598, 438, 0, c_black, 1);
    
draw_sprite_ext(spr_pixel, 0, 321, 94, 1, 300, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, 323, 94, 1, 300, 0, c_white, 1);

var _i = 0; repeat (10)
{
	if (!Item_IsValid(Item_Get(_i)) && _i < 8)
        draw_sprite_ext(spr_pixel, 0, 80, 93 + (32 * _i), 180, 1, 0, c_red, 1);
		
    if (!Item_IsValid(Box_ItemGet(__box_slot, _i)))
        draw_sprite_ext(spr_pixel, 0, 382, 93 + (32 * _i), 180, 1, 0, c_red, 1);
    _i++;
}
	
draw_set_format(font_dt_sans, __color);
draw_set_align(fa_center);
draw_text_transformed(170, 30, __label_inventory, 2, 2, 0);
draw_text_transformed(472, 30, __label_box, 2, 2, 0);
draw_text_transformed(320, 406, __label_finish, 2, 2, 0);
draw_set_align();

var _item_inventory = "", _item_box = "";
var	_i = 0; repeat (10)
{
	if (_i < 8)
	{
		_item_inventory += Item_GetName(Item_Get(_i));
		_item_inventory += "\n";
	}
	
	_item_box += Item_GetName(Box_ItemGet(__box_slot, _i));
	_item_box += "\n";
	
	_i++;
}
scribble($"{__prefix}{_item_inventory}").draw(68, 72);
scribble($"{__prefix}{_item_box}").draw(370, 72);
draw_set_color(c_white);

draw_sprite_ext(spr_battle_soul, 0, 49 + 302 * __choice_mode, 91 + 32 * __choice_item, 1, 1, DIR.DOWN, c_red, 1);
