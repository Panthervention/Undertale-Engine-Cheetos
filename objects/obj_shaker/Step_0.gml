if (object_exists(target) && instance_exists(target))
{
    var _obj = target;
    target = instance_find(_obj, 0);
    var _i = 1; repeat (instance_number(_obj) - 1)
    {
        var _inst_find = instance_find(_obj, _i);
        if (instance_exists(inst_find))
        {
            var _inst = instance_create_depth(0, 0, 0, obj_shaker);
            _inst.target = _inst_find;
            _inst.var_name = var_name;
            _inst.shake_distance = shake_distance;
            _inst.shake_speed = shake_speed;
            _inst.shake_random = shake_random;
            _inst.shake_decrease = shake_decrease;
        }
        _i += 1;
    }
}

if (instance_exists(target) && !object_exists(target) && variable_instance_exists(target, var_name) && shake_distance > 0)
{
    if (!is_real(__shake_base))
        __shake_base = variable_instance_get(target, var_name);
    
    if (__shake_time > 0)
        __shake_time -= 1;
    else
    {
        if (!shake_random)
        {
            if (__shake_positive)
                __shake_pos = shake_distance;
            else
            {
                shake_distance -= shake_decrease;
                __shake_pos = -shake_distance;
            }
            __shake_positive = !__shake_positive;
        }
        else
        {
            __shake_pos = random_range(-shake_distance, shake_distance);
            shake_distance -= shake_decrease;
        }
        __shake_time = shake_speed;
    }
    variable_instance_set(target, var_name, __shake_base + __shake_pos);
}
else
    instance_destroy();
	