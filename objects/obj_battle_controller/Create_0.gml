kr_timer = 0;

global.menu_hurt = "de-activated";
global.slam_power = 12.5;
global.slam_damage = false;

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
var ENCOUNTER = Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.ENCOUNTER);
_enemy_object = [Encounter_GetEnemy(ENCOUNTER,0),
				 Encounter_GetEnemy(ENCOUNTER,1), 
				 Encounter_GetEnemy(ENCOUNTER,2)];

//敌人实例
_enemy = [noone,noone,noone];
//敌人名字
_enemy_name = ["","",""];
//敌人可饶恕状态
_enemy_spareable = [false,false,false];

//敌人行动列表
_enemy_action_number = [0,0,0];
_enemy_action_name = [ ["","","","","",""], ["","","","","",""], ["","","","","",""] ];
//敌人中心位置
_enemy_center_pos_x = [0,0,0];
_enemy_center_pos_y = [0,0,0];

//敌人属性
_enemy_def = [0,0,0];

//状态
_state = -1;
_state_next = -1;

//菜单
_menu = -1;
_menu_choice_button = 0;
_menu_choice_enemy = 0;
_menu_choice_action = 0;
_menu_choice_item = 0;
_menu_choice_item_first = 0;
_menu_choice_mercy = 0;
_menu_choice_mercy_override = false;
_menu_choice_mercy_override_number = 1;
_menu_choice_mercy_override_name = ["","",""];
_menu_fleeable = false;
_menu_mercy_flee_enabled = Encounter_IsMenuMercyFleeEnabled(ENCOUNTER);
_menu_dialog = Encounter_GetMenuDialog(ENCOUNTER);

_menu_fight_damage = 0;
_menu_fight_anim_time = 0;
_menu_fight_damage_time = 0;

_menu_item_used_last = -1;

_turn_number = 0;
_turn_time = -1;
_turn_info = {};

_dialog = [noone,noone];
_dialog_auto_end = true;
_dialog_enemy_auto_end = true;

_reward_gold = 0;
_reward_exp = 0;

_player_temp_atk = 0;
_player_temp_def = 0;
_player_temp_spd = 0;
_player_temp_inv = 0;
#endregion
