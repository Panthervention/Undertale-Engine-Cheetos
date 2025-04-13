/// @description Button Display

var _button_slot = Battle_GetMenuChoiceButton();
var _button_spr = button_spr;
var _button_pos = button_pos;
var _button_alpha = button_alpha;
var _button_scale = button_scale;
var _button_color = button_color; 
var _battle_state = Battle_GetState();
var _menu_state = Battle_GetMenu(); 

for (var i = 0; i < array_length(_button_spr); ++i) // Button create
{
	if (Item_Count() <= 0 && i == 2) // If no item left then button commit gray
		button_color_target[2] = [ [54,54,54],[54,54,54] ];
	
	var status_check = ( _battle_state == BATTLE_STATE.MENU
						 && _menu_state != BATTLE_MENU.FIGHT_AIM
						 && _menu_state != BATTLE_MENU.FIGHT_ANIM
						 && _menu_state != BATTLE_MENU.FIGHT_DAMAGE);
	var select = (Battle_GetMenuChoiceButton() == i && status_check) // Check if the button is chosen
	
	draw_sprite_ext(_button_spr[i], select, _button_pos[i][0], _button_pos[i][1], _button_scale[i], _button_scale[i], 0, make_color_rgb(_button_color[i][0],_button_color[i][1],_button_color[i][2]), _button_alpha[i]);
	
	if status_check // Animation updating because fuck yes
	{
		if _button_slot == i // The chosen button
		{
			if (_menu_state == BATTLE_MENU.BUTTON)
			{
				_button_scale[_button_slot] += (button_scale_target[1] - _button_scale[_button_slot]) / 6;
				_button_alpha[_button_slot] += (button_alpha_target[1] - _button_alpha[_button_slot]) / 6;
				_button_color[_button_slot][0] += (button_color_target[_button_slot][1][0] - _button_color[_button_slot][0]) / 6;
				_button_color[_button_slot][1] += (button_color_target[_button_slot][1][1] - _button_color[_button_slot][1]) / 6;
				_button_color[_button_slot][2] += (button_color_target[_button_slot][1][2] - _button_color[_button_slot][2]) / 6;					
			}
		}
		else // Other buttons if they aren't chosen
		{
			_button_scale[i] += (button_scale_target[0] - _button_scale[i]) / 6;
			_button_alpha[i] += (button_alpha_target[0] - _button_alpha[i]) / 6;
			_button_color[i][0] += ((button_color_target[i][0][0]) - (_button_color[i][0])) / 6;
			_button_color[i][1] += ((button_color_target[i][0][1]) - (_button_color[i][1])) / 6;
			_button_color[i][2] += ((button_color_target[i][0][2]) - (_button_color[i][2])) / 6;
		}
	}
	else // If the menu state is over
	{
		_button_scale[i] += (button_scale_target[0] - _button_scale[i]) / 6;
		_button_alpha[i] += (button_alpha_target[0] - _button_alpha[i]) / 6;
		_button_color[i][0] += ((button_color_target[i][0][0]) - (_button_color[i][0])) / 6;
		_button_color[i][1] += ((button_color_target[i][0][1]) - (_button_color[i][1])) / 6;
		_button_color[i][2] += ((button_color_target[i][0][2]) - (_button_color[i][2])) / 6;
	}
}
