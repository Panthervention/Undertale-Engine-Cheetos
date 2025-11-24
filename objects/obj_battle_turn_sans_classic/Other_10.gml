///@desc Turn Preparation Start
event_inherited();
var _turn = turn;
var _dialog = instance_create_depth(420, (obj_battle_enemy_sans.y - 100), 0, obj_battle_dialog_enemy);
var _text;
if (_turn >= 0 && _turn <= 5)
    _text = Lexicon($"battle.enemy.sans.turn.{_turn}").Get();
else
	_text = Lexicon($"battle.enemy.sans.turn.empty").Get();
	
_dialog.text = $"[voice, voice_sans][font_sans]{_text}";