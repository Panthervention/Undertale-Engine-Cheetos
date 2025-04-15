if (sprite_exists(sprite))
{
    __part_system = part_system_create();
    __part_type = part_type_create();
    part_system_depth(__part_system, DEPTH_BATTLE.ENEMY);
    part_type_alpha2(__part_type, 1, 0);
    part_type_color1(__part_type, c_white);
    part_type_shape(__part_type, pt_shape_pixel);
    part_type_life(__part_type, 20, 60);
    part_type_scale(__part_type, 2, 2);
    part_type_direction(__part_type, 70, 110, 0, 0);
    part_type_speed(__part_type, 0.1, 0.5, 0.2, 0);
    
    __inst = instance_create_depth(x, y, 0, obj_battle_death_particle_collision);
    __inst.sprite_index = sprite;
    __inst.image_xscale = scale_x;
    __inst.image_yscale = scale_y;
    __line = y - sprite_get_yoffset(sprite) * scale_y;
    if (__line < 0)
        __line = 0;
}
else
    instance_destroy();
