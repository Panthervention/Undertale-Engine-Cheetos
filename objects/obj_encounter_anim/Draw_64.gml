if (__draw_player)
    draw_sprite_ext(obj_char_player.sprite_index, obj_char_player.image_index, (obj_char_player.x - camera.x) * 2, (obj_char_player.y - camera.y) * 2, obj_char_player.image_xscale * 2, obj_char_player.image_yscale * 2, obj_char_player.image_angle, obj_char_player.image_blend, obj_char_player.image_alpha);
if (__draw_black)
    draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, 1);
if (__draw_soul)
    draw_sprite_ext(spr_battle_soul, 0, __draw_soul_x, __draw_soul_y, 1, 1, DIR.DOWN, c_red, 1);
