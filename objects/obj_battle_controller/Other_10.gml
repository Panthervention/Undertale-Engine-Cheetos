/// @description UI - Battle Button

with (ui_button)
{
	var _button_spr		= sprite,
		_button_pos		= position,
		_button_alpha	= alpha,
		_button_scale	= scale,
		_button_color	= color,
		_button_angle	= angle,
		_button_count = count();
	
	var _battle_state = Battle_GetState(), _menu_state = Battle_GetMenu(), _button = Battle_GetMenuChoiceButton();
	
	if (sprite_background)
	{
		shader_set(shd_black_mask); // Prevent background cover the buttons
		var _i = 0; repeat (_button_count) // Initialize buttons
		{
			var _status_check = ( _battle_state == BATTLE_STATE.MENU
								&& _menu_state != BATTLE_MENU.FIGHT_AIM
								&& _menu_state != BATTLE_MENU.FIGHT_ANIM
								&& _menu_state != BATTLE_MENU.FIGHT_DAMAGE);
			var _button_is_chosen = (_button == _i) && _status_check;
			// Draw the button by array order
			var _button_background_color = merge_color(c_white, c_black, 0.5 - (_button_alpha[_i] / 2));
			draw_sprite_ext(_button_spr[_i], _button_is_chosen, _button_pos[_i * 2], _button_pos[_i * 2 + 1], _button_scale[_i], _button_scale[_i], _button_angle[_i], _button_background_color, 1);
		}
		shader_reset();
	}
	
	var _i = 0; repeat (_button_count)
	{
		var _status_check = ( _battle_state == BATTLE_STATE.MENU
							&& _menu_state != BATTLE_MENU.FIGHT_AIM
							&& _menu_state != BATTLE_MENU.FIGHT_ANIM
							&& _menu_state != BATTLE_MENU.FIGHT_DAMAGE);
		var _button_is_chosen = (_button == _i) && _status_check;
		draw_sprite_ext(_button_spr[_i], _button_is_chosen, _button_pos[_i * 2], _button_pos[_i * 2 + 1], _button_scale[_i], _button_scale[_i], _button_angle[_i], _button_color[_i], 1);
		_i++;
	}
}
