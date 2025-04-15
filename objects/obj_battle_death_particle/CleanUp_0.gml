if (instance_exists(__inst))
{
    part_type_destroy(__part_type);
    part_system_destroy(__part_system);
    surface_free(__surface);
    instance_destroy(__inst);
}
