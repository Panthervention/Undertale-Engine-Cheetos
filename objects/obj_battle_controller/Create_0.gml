kr_timer = 0;

with (global)
{
	menu_hurt = "de-activated";
	slam_power = 12.5;
	slam_damage = false;
}

instance_create_depth(60, 270, DEPTH_BATTLE.UI_HIGH, obj_battle_textwriter);

ui_info = {};
ui_button = {};

with (ui_info)
{
	x = 30; y = 400; image_blend = c_white; image_alpha = 1;
	
	alpha_name = image_alpha;
	alpha_lv = image_alpha;
	alpha_hp_label = image_alpha;
	alpha_bars = image_alpha;
	alpha_kr = image_alpha;
	alpha_counter = image_alpha;
	
	name = Player_GetName();
	lv = Player_GetLv();
	
	hp_max = Player_GetHpMax();
	hp = Player_GetHp();
	kr = Player_GetKr();
	
	bar_scale = 1.2;
	
	hp_label = "HP";
	kr_label = "KR";
	
	color_name = image_blend;
	color_lv = image_blend;
	color_lv_label = image_blend;
	
	color_hp_label = image_blend;
	color_kr_label = image_blend;
	
	color_kr_idle = image_blend;
	color_kr_active = c_fuchsia;
	
	color_hp_max_bar = c_red;
	color_hp_bar = c_yellow;
	color_kr_bar = color_kr_active;
}

with (ui_button)
{
	sprite		= [spr_battle_button_fight, spr_battle_button_act, spr_battle_button_item, spr_battle_button_mercy];
	position	= [87, 453, 240, 453, 400, 453, 555, 453]; // Even is x, odd is y
	correspond	= [BATTLE_BUTTON.FIGHT, BATTLE_BUTTON.ACT, BATTLE_BUTTON.ITEM, BATTLE_BUTTON.MERCY];
	
	count		= function() { // Return the amount of buttons
		static _button_count = array_length(sprite);
		if (_button_count != array_length(sprite))
			_button_count = array_length(sprite);
		return _button_count;
	}
	
	reset_timer	= function() {
		lerp_timer = array_create(count(), 0);
	}
	
	angle				= array_create(count(), 0);
	alpha_idle			= 0.25;
	alpha_active		= 1;
	alpha				= array_create(count(), 0.25);
	alpha_override		= array_create(count(), 1);
	color_idle			= c_orange;
	color_active		= c_yellow;
	color				= array_create(count(), color_idle);
	scale_idle			= 1;
	scale_active		= 1.2;
	scale				= array_create(count(), scale_idle);
	lerp_scale			= array_create(count(), 0);
	lerp_timer			= array_create(count(), 0);
	sprite_background	= false;
}

#region Private Variables, tamper cautiously!
var _encounter_id = Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.ENCOUNTER);
__enemy_object = [Encounter_GetEnemy(_encounter_id, 0),
				  Encounter_GetEnemy(_encounter_id, 1), 
				  Encounter_GetEnemy(_encounter_id, 2)];

__enemy = [noone, noone, noone];
__enemy_name = ["", "", ""];
__enemy_spareable = [false, false, false];

__enemy_action_number = [0, 0, 0];
__enemy_action_name = [ ["", "", "", "", "", ""], ["", "", "", "", "", ""], ["", "", "", "", "", ""] ];

__enemy_center_pos_x = [0, 0, 0];
__enemy_center_pos_y = [0, 0, 0];

__enemy_def = [0, 0, 0];

__state = -1;
__state_next = -1;

__menu = -1;
__menu_choice_button = 0;
__menu_choice_enemy = 0;
__menu_choice_action = 0;
__menu_choice_item = 0;
__menu_choice_item_first = 0;
__menu_choice_mercy = 0;
__menu_choice_mercy_override = false;
__menu_choice_mercy_override_number = 1;
__menu_choice_mercy_override_name = ["", "", ""];
__menu_fleeable = false;
__menu_mercy_flee_enabled = Encounter_IsMenuMercyFleeEnabled(_encounter_id);
__menu_dialog = Encounter_GetMenuDialog(_encounter_id);

__menu_fight_damage = 0;
__menu_fight_anim_time = 0;
__menu_fight_damage_time = 0;

__menu_item_used_last = {};

__turn_number = 0;
__turn_time = -1;
__turn_info = {};

__dialog_auto_end = true;
__dialog_enemy_auto_end = true;

__reward_gold = 0;
__reward_exp = 0;

__player_temp_atk = 0;
__player_temp_def = 0;
__player_temp_spd = 0;
__player_temp_inv = 0;
#endregion
