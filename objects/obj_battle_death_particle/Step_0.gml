if (__line < 480)
{
    repeat (4)
    {
        var _x = 0; repeat (640 / 2)
        {
            if (position_meeting(_x, __line, __inst))
                part_particles_create(__part_system, _x, __line, __part_type, 1);
            _x += 2;
        }
        __line += 2;
    }
}

if (instance_exists(__inst) && __line > y - sprite_get_yoffset(sprite) * scale_y + sprite_get_height(sprite) * scale_y && part_particles_count(__part_system) == 0)
    instance_destroy();
