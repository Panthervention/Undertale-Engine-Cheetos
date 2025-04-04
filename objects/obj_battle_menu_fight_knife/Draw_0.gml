Battle_BoardMaskSet(true, true)
draw_self();
if (image_alpha == 1)
	draw_sprite_ext(spr_battle_menu_fight_aim, __aim_image, __aim_x, y, 1, 1, __aim_angle, c_white, 1);
Battle_BoardMaskReset();

Battle_BoardMaskSet(true, false);
if (__aim_x == 320 && __effect && __effect_alpha > 0)
{
    __effect_xscale += 0.1;
    __effect_yscale += 0.1;
    __effect_alpha -= 0.05;
    draw_sprite_ext(spr_battle_menu_fight_aim, __aim_image, __aim_x, y, __effect_xscale, __effect_yscale, __aim_angle, __effect_color, __effect_alpha);
}
Battle_BoardMaskReset();
