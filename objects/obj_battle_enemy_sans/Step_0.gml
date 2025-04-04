if (follow_board_y == true)
    y = obj_battle_board.y - obj_battle_board.up - obj_battle_board.frame_thickness - 6;

var num = sprite_get_number(__body_sprite);

__body_image += __body_speed;
if (__body_image >= num)
{
    if (__body_loop)
        __body_image = 0;
    else
    {
        __body_image = num - 1;
        __body_speed = 0;
    }
}
if (__wiggle)
{
    __wiggle_sin++;
    if (__wiggle_sin % 1 == 0)
    {
        if (sans_is_alive == true)
        {
            __body_x = sin(__wiggle_sin * 0.1) * 1;
            __body_y = sin(__wiggle_sin * 0.2) * 0.7;
            __head_x = sin(__wiggle_sin * 0.1) * 0.1;
            __head_y = sin(__wiggle_sin * 0.2) * 0.1;
        }
        else if (sans_is_alive == false)
        {
            __body_y = sin(__wiggle_sin * 0.1) * 0.35;
            __head_y = sin(__wiggle_sin * 0.1) * 0.05;
        }
    }
}
else
    __wiggle_sin = 0;

if (action == SANS_ACTION.STATIC)
{
    if (__action_step != 1)
    {
        __body_sprite = spr_sans_body;
        __body_x = 0;
        __body_y = 0;
        __body_image = 0;
        __body_speed = 0;
        __body_loop = true;
        __wiggle = false;
        __action_step = 1;
    }
}
else if (action == SANS_ACTION.IDLE)
{
    if (__action_step != 1)
    {
        __body_sprite = spr_sans_body;
        __body_x = 0;
        __body_y = 0;
        __body_image = 0;
        __body_speed = 0;
        __body_loop = true;
        __wiggle = true;
        __action_step = 1;
    }
}
else if (action == SANS_ACTION.LEFT)
{
    if (__action_step < 5)
    {
        switch (__action_step)
        {
            case 0:
                __body_sprite = spr_sans_slam_horizontal;
                __body_x = 0;
                __body_y = 0;
                __body_image = 0;
                __body_loop = 0;
                __wiggle = 0;
                break;
            case 1:
                __body_x = 5;
                __body_image = 1;
                break;
            case 2:
                __body_x = 6;
                break;
            case 3:
                __body_x = -3;
                __body_image = 2;
                break;
            case 4:
                __body_x = -2;
                __body_image = 3;
                break;
            case 5:
                __body_x = 0;
                __body_image = 0;
                __body_sprite = spr_sans_body;
                action = SANS_ACTION.IDLE;
                break;
        }
        __action_step += 0.25;
    }
}
else if (action == SANS_ACTION.RIGHT)
{
    if (__action_step < 5)
    {
        switch (__action_step)
        {
            case 0:
                __body_sprite = spr_sans_slam_horizontal;
                __body_x = 0;
                __body_y = 0;
                __body_image = 0;
                __body_loop = 0;
                __wiggle = 0;
                break;
            case 1:
                __body_x = -5;
                __body_image = 3;
                break;
            case 2:
                __body_x = -6;
                __body_image = 2;
                break;
            case 3:
                __body_x = 3;
                break;
            case 4:
                __body_x = 2;
                __body_image = 1;
                break;
            case 5:
                __body_x = 0;
                __body_image = 0;
                __body_sprite = spr_sans_body;
                action = SANS_ACTION.IDLE;
                break;
        }
        __action_step += 0.25;
    }
}
else if (action == SANS_ACTION.DOWN)
{
    if (__action_step < 4)
    {
        switch (__action_step)
        {
            case 0:
                __body_sprite = spr_sans_slam_vertical;
                __body_x = 0;
                __body_y = -1;
                __body_image = 0;
                __body_speed = 0;
                __body_loop = false;
                __wiggle = false;
                break;
            case 1:
                __body_y = -3;
                __body_image = 1;
                break;
            case 2:
                __body_y = 3;
                __body_image = 2;
                break;
            case 3:
                __body_y = 2;
                __body_image = 3;
                break;
            case 4:
                __body_y = 0;
                __body_image = 0;
                __body_sprite = spr_sans_body;
                action = SANS_ACTION.IDLE;
                break;
        }
        __action_step += 0.25;
    }
}
else if (action == SANS_ACTION.UP)
{
    if (__action_step < 4)
    {
        switch (__action_step)
        {
            case 0:
                __body_sprite = spr_sans_slam_vertical;
                __body_x = 0;
                __body_y = 3;
                __body_image = 0;
                __body_speed = 0;
                __body_loop = false;
                __wiggle = false;
                break;
            case 1:
                __body_y = 3;
                __body_image = 3;
                break;
            case 2:
                __body_y = -3;
                __body_image = 2;
                break;
            case 3:
                __body_y = -2;
                __body_image = 1;
                break;
            case 4:
                __body_y = 0;
                __body_image = 0;
                __body_sprite = spr_sans_body;
                action = SANS_ACTION.IDLE;
                break;
        }
        __action_step += 0.25;
    }
}
