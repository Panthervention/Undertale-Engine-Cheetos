kr_timer = 0;

with (global)
{
	menu_hurt = "de-activated";
	slam_power = 12.5;
	slam_damage = false;
}

instance_create_depth(60, 270, DEPTH_BATTLE.UI_HIGH, obj_battle_textwriter);

#region Button Functions
button_spr = [spr_battle_button_fight,spr_battle_button_act,spr_battle_button_item,spr_battle_button_mercy];
button_pos = [ [87,453], [240,453], [400,453], [555,453] ];
button_alpha = [0.25, 0.25, 0.25, 0.25];
button_scale = [1, 1, 1, 1];
button_color = [ [242,101,34], [242,101,34], [242,101,34], [242,101,34] ];
button_alpha_target = [0.25, 1];
button_scale_target = [1, 1.2];
button_color_target = [ [ [242,101,34], [255,255,0] ],
						[ [242,101,34], [255,255,0] ],
						[ [242,101,34], [255,255,0] ],
						[ [242,101,34], [255,255,0] ] 
					  ];
#endregion

#region UI Functions
ui_x = 275;
ui_y = 400;
ui_alpha = 1;
#endregion

#region TML Stuffs I don't understand and it's so :skull:
var _encounter_id = Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.ENCOUNTER);
__enemy_object = [Encounter_GetEnemy(_encounter_id, 0),
				 Encounter_GetEnemy(_encounter_id, 1), 
				 Encounter_GetEnemy(_encounter_id, 2)];

//敌人实例
__enemy = [noone,noone,noone];
//敌人名字
__enemy_name = ["","",""];
//敌人可饶恕状态
__enemy_spareable = [false,false,false];

//敌人行动列表
__enemy_action_number = [0,0,0];
__enemy_action_name = [ ["","","","","",""], ["","","","","",""], ["","","","","",""] ];
//敌人中心位置
__enemy_center_pos_x = [0,0,0];
__enemy_center_pos_y = [0,0,0];

//敌人属性
__enemy_def = [0,0,0];

//状态
__state = -1;
__state_next = -1;

//菜单
__menu = -1;
__menu_choice_button = 0;
__menu_choice_enemy = 0;
__menu_choice_action = 0;
__menu_choice_item = 0;
__menu_choice_item_first = 0;
__menu_choice_mercy = 0;
__menu_choice_mercy_override = false;
__menu_choice_mercy_override_number = 1;
__menu_choice_mercy_override_name = ["","",""];
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

__dialog = [noone,noone];
__dialog_auto_end = true;
__dialog_enemy_auto_end = true;

__reward_gold = 0;
__reward_exp = 0;

__player_temp_atk = 0;
__player_temp_def = 0;
__player_temp_spd = 0;
__player_temp_inv = 0;
#endregion
