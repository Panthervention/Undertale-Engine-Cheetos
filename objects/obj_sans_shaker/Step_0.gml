if (time > 0)
    time--;


if (time % 2 == 0)
{
    with (obj_battle_enemy_sans)
    {
        legs_shake = random_range(-other.lshake, other.lshake);
        body_shake = random_range(-other.bshake, other.bshake);
        head_shake = random_range(-other.hshake, other.hshake);
    }
}

if (time == 0)
{
    with (obj_battle_enemy_sans)
    {
        legs_shake = 0;
        body_shake = 0;
        head_shake = 0;
    }
    instance_destroy();
}

