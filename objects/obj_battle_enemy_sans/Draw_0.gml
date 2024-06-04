draw_sprite_ext(_legs_sprite, 0, x + legs_shake, y, 1, 1, 0, c_white, 1);
draw_sprite_ext(_body_sprite, _body_image, x + _body_init_x * 2 + _body_x * 2 + body_shake, y + _body_init_y * 2 + _body_y * 2, 1, 1, 0, c_white, 1);
draw_sprite_ext(_head_sprite, _head_image, x + _body_init_x * 2 + _body_x * 2 + _head_init_x * 2 + _head_x * 2 + head_shake, y + _body_init_y * 2 + _body_y * 2 + _head_init_y * 2 + _head_y * 2, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_sans_sweat, sweat_image, x + _body_init_x * 2 + _body_x * 2 + _head_init_x * 2 + _head_x * 2 + head_shake, y + _body_init_y * 2 + _body_y * 2 + _head_init_y * 2 + _head_y * 2, 1, 1, 0, c_white, 1);

