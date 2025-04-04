draw_sprite_ext(__legs_sprite, 0, x + legs_shake, y, 1, 1, 0, c_white, 1);
draw_sprite_ext(__body_sprite, __body_image, x + __body_init_x * 2 + __body_x * 2 + body_shake, y + __body_init_y * 2 + __body_y * 2, 1, 1, 0, c_white, 1);
draw_sprite_ext(__head_sprite, __head_image, x + __body_init_x * 2 + __body_x * 2 + __head_init_x * 2 + __head_x * 2 + head_shake, y + __body_init_y * 2 + __body_y * 2 + __head_init_y * 2 + __head_y * 2, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_sans_sweat, sweat_image, x + __body_init_x * 2 + __body_x * 2 + __head_init_x * 2 + __head_x * 2 + head_shake, y + __body_init_y * 2 + __body_y * 2 + __head_init_y * 2 + __head_y * 2, 1, 1, 0, c_white, 1);

