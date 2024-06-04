Battle_BoardMaskSet(true, true)
draw_self();
if (image_alpha == 1)
	draw_sprite_ext(spr_battle_menu_fight_aim, _aim_image, _aim_x, y, 1, 1, _aim_angle, c_white, 1);
Battle_BoardMaskReset();

Battle_BoardMaskSet(true, false);
if (_aim_x == 320 && _effect && _effect_alpha > 0)
{
    _effect_xscale += 0.1;
    _effect_yscale += 0.1;
    _effect_alpha -= 0.05;
    draw_sprite_ext(spr_battle_menu_fight_aim, _aim_image, _aim_x, y, _effect_xscale, _effect_yscale, _aim_angle, _effect_color, _effect_alpha);
}
Battle_BoardMaskReset();
