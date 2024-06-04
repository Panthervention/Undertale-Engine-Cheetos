draw_sprite_ext(spr_pixel, 0, 16, 16, 610, 450, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, 22, 22, 598, 438, 0, c_black, 1);
    
draw_sprite_ext(spr_pixel, 0, 321, 94, 1, 300, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, 323, 94, 1, 300, 0, c_white, 1);

var i = 0;
repeat (10)
{
	if (!Item_IsValid(Item_Get(i)) && i < 8)
        draw_sprite_ext(spr_pixel, 0, 80, 93 + 32 * i, 180, 1, 0, c_red, 1);
		
    if (!Item_IsValid(Box_ItemGet(_box_slot, i)))
        draw_sprite_ext(spr_pixel, 0, 382, 93 + 32 * i, 180, 1, 0, c_red, 1);
    i++;
}
	
draw_set_format(font_dt_sans, _color);
draw_set_align(fa_middle);
draw_text_transformed(170, 30, _label_inventory, 2, 2, 0);
draw_text_transformed(472, 30, _label_box, 2, 2, 0);
draw_text_transformed(320, 406, _label_finish, 2, 2, 0);
draw_set_align();


_label_item_inventory.draw(68, 72);
_label_item_box		 .draw(370, 72);
draw_set_color(c_white);

draw_sprite_ext(spr_battle_soul, 0, 49 + 302 * _choice_mode, 91 + 32 * _choice_item, 1, 1, 0, c_red, 1);
