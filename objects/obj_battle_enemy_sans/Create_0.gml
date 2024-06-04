event_inherited();
hp = 1;
hp_max = 1;

_check_status = 0;
_check_dialog[0] = lexicon_text("battle.enemy.sans.check.0");
_check_dialog[1] = lexicon_text("battle.enemy.sans.check.1");

_body_init_x = 0;
_body_init_y = -12;
_body_sprite = spr_sans_body;
_body_x = 0;
_body_y = 0;
_body_image = 0;
_body_speed = 0;
_body_loop = true;

action = SANS_ACTION.IDLE;
_action_step = 1;

_wiggle = true;
_wiggle_sin = 0;

_head_init_x = 0;
_head_init_y = -29;
_head_sprite = spr_sans_head;
_head_x = 0;
_head_y = 0;
_head_image = 0;

_legs_sprite = spr_sans_legs;

sweat_image = 0;
follow_board_y = true;
sans_is_alive = true;
body_shake = 0;
head_shake = 0;
legs_shake = 0;
