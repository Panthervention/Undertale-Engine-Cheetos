scribble($"[font_damage][fa_center][fa_middle]{damage}").blend(color, 1).draw(x, y);

if (bar_visible && is_real(damage) && damage >= 0)
{
    draw_sprite_ext(spr_pixel, 0, xstart - bar_width / 2, ystart + 18, bar_width, 13, 0, c_dkgray, 1);
    draw_sprite_ext(spr_pixel, 0, xstart - bar_width / 2, ystart + 18, bar_width / bar_hp_max * __bar_hp, 13, 0, c_lime, 1);
}
