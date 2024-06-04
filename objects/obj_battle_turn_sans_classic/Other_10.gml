///@desc Turn Preparation Start
event_inherited();
var _turn = turn;
var dialog = instance_create_depth(420, (obj_battle_enemy_sans.y - 100), 0, obj_battle_dialog_enemy);
if (_turn >= 0 && _turn <= 5)
    dialog.text = $"[voice, snd_text_voice_sans, 1][font_sans]{lexicon_text($"battle.enemy.sans.turn.{_turn}")}";
else
	dialog.text = $"[voice, snd_text_voice_sans, 1][font_sans]{lexicon_text($"battle.enemy.sans.turn.empty")}";

