depth = DEPTH_BATTLE.UI;
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
ui_fight = {};

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
		// feather disable GM1041
		// ui_button.sprite does not work... and it seems fine as is. I printed it, and it was in fact defined.
		static _button_count = array_length(sprite);
		if (_button_count != array_length(sprite))
			_button_count = array_length(sprite);
		// feather enable GM1041
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

with (ui_fight)
{
	visible = false;
	// DO NOT CHANGE THE FUNCTION NAMES UNLESS YOU KNOW WHAT YOU ARE DOING!
	initialize = function()
	{
		visible = true;
		
		sprite_index = spr_battle_menu_fight_bg;
		image_index = 0; // 0 for the pixelated - 1 for the HD
		x = obj_battle_board.x;
		y = obj_battle_board.y;
		image_xscale = 1;
		image_yscale = 1;
		image_angle = 0;
		image_blend = c_white;
		image_alpha = 1;
		
		global.menu_hurt = "de-activated";
		global.deadable = true;

		__dir = choose(DIR.LEFT, DIR.RIGHT);
		__input_acceptable = 1;
		__aim_x = 0;
		__aim_image = 0;
		__aim_angle = 0;
		__aim_confirm = false;

		__effect = false;
		__effect_xscale = 1;
		__effect_yscale = 1;
		__effect_alpha = 1;
		__effect_color = c_white;

		__aim_x = (__dir == DIR.LEFT) ?
				 (x - obj_battle_board.left - sprite_get_width(spr_battle_menu_fight_recticle) / 2):
				 (x + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_recticle) / 2);
		__aim_x_change = (__dir == DIR.LEFT) ?
						 (obj_battle_board.left + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_recticle)):
						-(obj_battle_board.left + obj_battle_board.right + sprite_get_width(spr_battle_menu_fight_recticle));
		__aim_x_target = __aim_x + __aim_x_change;
		__aim_x_tween = TweenFire(self, "", 0, off, 0, 90, "__aim_x>", __aim_x_target);
	}
	
	// Run on BATTLE_MENU.FIGHT_ANIM menu state
	anim = function()
	{
		if ((Battle_GetMenuFightDamage() >= 0) && __aim_confirm == true)
		{
			__aim_confirm = 10;
		    var _enemy_slot = Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy()),
				_enemy_x = Battle_GetEnemyCenterPosX(_enemy_slot),
				_enemy_y = Battle_GetEnemyCenterPosY(_enemy_slot);
    
			var _knife = instance_create_depth(_enemy_x, _enemy_y, 0, obj_battle_menu_fight_anim_knife);
		}
	}
	
	// Run on BATTLE_MENU.FIGHT_DAMAGE menu state
	damage = function()
	{
		
	}
	
	finish = function()
	{
		var _duration = 30;
		TweenFire(self, "", 0, off, 0, _duration, "image_xscale>", 0);
		TweenFire(self, "", 0, off, 0, _duration, "image_alpha>", 0);
		
		other.alarm[1] = _duration;
		
		global.menu_hurt = "activated";
		global.deadable = false;
	}
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
