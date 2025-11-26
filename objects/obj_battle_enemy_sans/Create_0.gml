event_inherited();
hp = 1;
hp_max = 1;

__check_status = 0;
__check_dialog[0] = Lexicon("battle.enemy.sans.check.0").Get();
__check_dialog[1] = Lexicon("battle.enemy.sans.check.1").Get();

__body_init_x = 0;
__body_init_y = -12;
__body_sprite = spr_sans_body;
__body_x = 0;
__body_y = 0;
__body_image = 0;
__body_speed = 0;
__body_loop = true;

action = SANS_ACTION.IDLE;
__action_step = 1;

__wiggle = true;
__wiggle_sin = 0;

__head_init_x = 0;
__head_init_y = -29;
__head_sprite = spr_sans_head;
__head_x = 0;
__head_y = 0;
__head_image = 0;

__legs_sprite = spr_sans_legs;

sweat_image = 0;
follow_board_y = true;
sans_is_alive = true;
body_shake = 0;
head_shake = 0;
legs_shake = 0;
