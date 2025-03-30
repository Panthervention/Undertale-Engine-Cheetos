#region Vitality

	#region HP
	///@param damage
	///@param [kr]
	function Player_Hurt(damage, karma = 0) {	
		if (damage >= 0)
		{
			var hp = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.HP),
				final_hp = max(hp - damage, 0);
			Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP, final_hp)
		
			if (global.kr_enable && karma > 0)
			{
				var kr = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.KR),
					final_kr = karma + kr;
				Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.KR, final_kr);
			}
		}
		else
			Player_Heal(-damage); // Why the hell negative heal???
	}

	///@param heal
	function Player_Heal(heal) {
		if (instance_exists(obj_battle_controller))
			obj_battle_controller.kr_timer = 0
		
		if (heal >= 0)
		{
			var hp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP),
				hp_max = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX),
				final_hp = min(hp + heal, hp_max);
		
			if (global.kr_enable && global.kr_overridable)
			{
				var kr = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.KR);
				if (kr > 0 && (hp + heal > hp_max))
				{
					var final_kr = max(kr - ((hp + heal) - hp_max), 0);
					Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.KR, final_kr);
				}
			}
		
			Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP, final_hp);
		}
		else Player_Hurt(-heal); // God pls save me why the hell this is needed?
	}

	///@param hp
	function Player_SetHp(hp) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP, hp);
	}

	function Player_GetHp() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP);
	}

	///@param hp_max
	function Player_SetHpMax(hp_max) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX, hp_max);
	}

	function Player_GetHpMax() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX);
	}
	#endregion
	
	#region KR
	///@param kr
	function Player_SetKr(kr) {
		return Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.KR, kr);
	}

	function Player_GetKr() {
		return Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.KR);
	}
	#endregion
	
#endregion

#region Miscellaneous

///@param base_damage
///@param [damage_min]
///@param [damage_max]
function Player_CalculateDamage(damage, MIN = 1, MAX = infinity) {
	var hp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP);
	var DEF = Player_GetDefTotal();

	damage += (hp >= 20 ? ceil((hp - 20) / 10) : 0);
	damage -= DEF / 5;
	damage = round(damage);

	damage = clamp(damage, MIN, MAX);

	return damage;
}

function Player_IsInBattle() {
	return instance_exists(obj_battle_controller);
}

function Player_GetPlot() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.PLOT);
}

///@param plot
function Player_SetPlot(plot) {
	return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.PLOT, plot);
}

function Player_GetTextTyperChoice() {
	return Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.TEXTWRITER_CHOICE);
}

#endregion

#region Stats

	#region Name
	
	function Player_GetName() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.NAME);
	}

	///@param name
	function Player_SetName(name) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.NAME, name);
	}
	
	#endregion
	
	#region Lv
	
	function Player_GetLv() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.LV);
	}
	
	///@param lv
	function Player_SetLv(lv) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.LV, lv);
	}
	
	#endregion
	
	#region Exp
	
	function Player_GetExp() {
		return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.EXP);
	}

	///@param exp
	function Player_SetExp(Exp) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.EXP, Exp);
	}
	
	#endregion
	
	#region Atk
	
	function Player_GetAtk() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK);
	}

	///@param atk
	function Player_SetAtk(atk) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ATK, atk);
	}

	#endregion
	
	#region Def
	
	function Player_GetDef() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF);
	}
	
	///@param def
	function Player_SetDef(def) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.DEF, def);
	}
	
	#endregion
	
	#region Spd
	
	function Player_GetSpd() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.SPD);
	}
	
	///@param spd
	function Player_SetSpd(spd) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.SPD, spd);
	}

	#endregion
	
	#region Inv
	
	function Player_GetInv() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.INV);
	}
	
	///@param inv
	function Player_SetInv(inv) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.INV, inv);
	}
	
	#endregion
	
	#region Item
	
		#region Atk
		
		function Player_GetAtkItem() {
			return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK_ITEM);
		}

		///@param atk_item
		function Player_SetAtkItem(atk) {
			return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ATK_ITEM, atk);
		}
		
		#endregion
		
		#region Def
		
		function Player_GetDefItem() {
			return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF_ITEM);
		}
		
		///@param def_item
		function Player_SetDefItem(def) {
			return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.DEF_ITEM, def);
		}
		
		#endregion
		
		#region Spd
		
		function Player_GetSpdItem() {
			return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.SPD_ITEM);
		}
		
		///@param spd_item
		function Player_SetSpdItem(spd) {
			return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.SPD_ITEM, spd);
		}
		
		#endregion
		
		#region Inv
		
		function Player_GetInvItem() {
			return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.INV_ITEM);
		}
		
		///@param inv_item
		function Player_SetInvItem(inv) {
			return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.INV_ITEM, inv);
		}
		
		#endregion
	
	#endregion
	
	#region Total
		
	function Player_GetAtkTotal() {
		var in_battle = Player_IsInBattle(),
			atk = Player_GetAtk(),
			atk_item = Player_GetAtkItem(),
			atk_temp = Battle_GetPlayerTempAtk(),
			atk_total = atk + atk_item + (in_battle ? atk_temp : 0);
		return atk_total;
	}
		
	function Player_GetDefTotal() {
		var in_battle = Player_IsInBattle(),
			def = Player_GetDef(),
			def_item = Player_GetDefItem(),
			def_temp = Battle_GetPlayerTempDef(),
			def_total = def + def_item + (in_battle ? def_temp : 0);
		return def_total;
	}

	function Player_GetSpdTotal() {
		var in_battle = Player_IsInBattle(),
			spd = Player_GetSpd(),
			spd_item = Player_GetSpdItem(),
			spd_temp = Battle_GetPlayerTempSpd(),
			spd_total = spd + spd_item + (in_battle ? spd_temp : 0);
		return spd_total;
	}
	
	function Player_GetInvTotal() {
		var in_battle = Player_IsInBattle(),
			inv = Player_GetInv(),
			inv_item = Player_GetInvItem(),
			inv_temp = Battle_GetPlayerTempInv(),
			inv_total = inv + inv_item + (in_battle ? inv_temp : 0);
		return inv_total;
	}
	
	#endregion
	
	#region Gold
	
	function Player_GetGold() {
		return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.GOLD);
	}

	///@param gold
	function Player_SetGold(gold) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD, gold);
	}

	#endregion
	
	#region Kill Count
	
	function Player_GetKills() {
		return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.KILLS);
	}
	
	///@param kills
	function Player_SetKills(kills_count) {
		return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.KILLS, kills_count);
	}
	
	#endregion
	
#endregion

#region LV Up

///@param lv
function Player_GetLvHpMax(lv) {
	return (lv % 20 == 0) ? 99 * lv : ((20 * (floor(lv / 20) + 1)) + ((lv - 1) * 4));
}

///@param lv
function Player_GetLvAtk(lv) {
	return 10 + (lv - 1) * 2;
}

///@param lv
function Player_GetLvDef(lv) {
	return 10 + ceil((lv-4) / 4);
}

///@param lv
function Player_GetLvExp(lv){
	if (lv > 0 && lv <= 20)
	{
		static result = [-1,   0,   10,   30,   70,  120,   200,   300,   500,   800,  1200, 
							1700, 2500, 3500, 5000, 7000, 10000, 15000, 25000, 50000, 99999] ;
		return result[lv];
	}
	return -1;
}

///@param lv
function Player_LvUp(lv) {
	Player_SetLv(lv);
	Player_SetHpMax(Player_GetLvHpMax(lv));
	Player_SetAtk(Player_GetLvAtk(lv));
	Player_SetDef(Player_GetLvDef(lv));

	return true;
}

function Player_UpdateLv() {
	var result = false;

	while ( Player_GetLvExp(Player_GetLv() + 1) != -1 && 
			Player_GetExp() >= Player_GetLvExp(Player_GetLv() + 1) )
	{
	    Player_LvUp(Player_GetLv() + 1);
	    result = true;
	}
	return result;
}

#endregion

#region Save - Load

///@param slot
function Player_Save(slot) {
	Flag_SetSaveSlot(slot);
	
	var LV   = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.LV),
		TIME = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.TIME),
		ROOM = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.ROOM),
		NAME = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.NAME);
		
	Flag_Save(FLAG_TYPE.STATIC);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.LV,   LV);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.TIME, TIME);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.ROOM, ROOM);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.NAME, NAME);
	Flag_Save(FLAG_TYPE.INFO);	
	
	return true;
}

///@param slot
function Player_Load(slot) {
	Flag_SetSaveSlot(slot);

	Flag_Load(FLAG_TYPE.STATIC);
	Flag_Load(FLAG_TYPE.DYNAMIC);
	Flag_Load(FLAG_TYPE.INFO);

	return true;
}

#endregion
