var DIALOG = obj_battle_controller._dialog[0];

if (instance_exists(DIALOG))
{
    var SLOT = Battle_ConvertEnemySlotToMenuChoiceEnemy(enemy_slot);
    var X = DIALOG.x + DIALOG.width + 32;
    var Y = obj_battle_board.y - obj_battle_board.up + 25 + 32 * SLOT;
    draw_sprite_ext(spr_pixel, 0, X, Y, width, 17, 0, c_red, 1);
    draw_sprite_ext(spr_pixel, 0, X, Y, width / hp_max * hp, 17, 0, c_lime, 1);
}
