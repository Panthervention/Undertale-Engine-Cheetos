var _enemy_slot = Battle_ConvertEnemySlotToMenuChoiceEnemy(enemy_slot);
var _x = (obj_battle_board.y - obj_battle_board.up - 5 + 20) + 32 + obj_battle_textwriter.enemy_name_width_max;
var _y = (obj_battle_board.y - obj_battle_board.up + 25) + (32 * _enemy_slot);
draw_sprite_ext(spr_pixel, 0, _x, _y, width, 17, 0, c_red, 1);
draw_sprite_ext(spr_pixel, 0, _x, _y, width / hp_max * hp, 17, 0, c_lime, 1);

