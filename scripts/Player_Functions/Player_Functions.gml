#region Vitality
#region HP
///@func Player_Hurt(damage, [karma])
///@desc Damage player's HP.
///@param {Real}	damage		The amount of damage.
///@param {Real}	[karma]		The amount of karma. This will only apply if global.kr_enable is true. (Default: 0)
function Player_Hurt(_damage, _karma = 0) {	
	if (_damage >= 0)
	{
		var _hp = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.HP),
			_final_hp = max(_hp - _damage, 0);
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP, _final_hp)
		
		if (global.kr_enable && _karma > 0)
		{
			var _kr = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.KR),
				_final_kr = _karma + _kr;
			Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.KR, _final_kr);
		}
	}
	else
		Player_Heal(-_damage); // Why the hell negative heal???
}

///@func Player_Heal(heal)
///@desc Heal player's HP.
///@param {Real}	heal	The amount of HP to heal.
function Player_Heal(_heal) {
	if (instance_exists(obj_battle_controller))
		obj_battle_controller.kr_timer = 0
		
	if (_heal >= 0)
	{
		var _hp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP),
			_hp_max = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX),
			_final_hp = min(_hp + _heal, _hp_max);
		
		// Whenever the heal will also heal the KR
		if (global.kr_enable && global.kr_overridable)
		{
			var _kr = Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.KR);
			if (_kr > 0 && (_hp + _heal > _hp_max))
			{
				var _final_kr = max(_kr - ((_hp + _heal) - _hp_max), 0);
				Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.KR, _final_kr);
			}
		}
		
		Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP, _final_hp);
	}
	else Player_Hurt(-_heal); // God pls save me why the hell this is needed?
}

///@func Player_SetHp(hp)
///@desc Set player's HP.
///@param {Real}	hp		The amount of HP to set.
function Player_SetHp(_hp) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP, _hp);
}

///@func Player_GetHp()
///@desc Return player's HP.
///@return {Real}
function Player_GetHp() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP);
}

///@func Player_SetHpMax(hp_max)
///@desc Set player's max HP.
///@param {Real}	hp_max		
function Player_SetHpMax(_hp_max) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX, _hp_max);
}

///@func Player_GetHpMax()
///@desc Return player's max HP.
///@return {Real}
function Player_GetHpMax() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX);
}
#endregion
	
#region KR
///@func Player_SetKr(kr)
///@desc Set player's KR (karma).
///@param {Real}	kr		The amount of KR to set.
function Player_SetKr(_kr) {
	Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.KR, _kr);
}

///@func Player_GetKr()
///@desc Return player's KR (karma).
///@return {Real}
function Player_GetKr() {
	return Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.KR);
}
#endregion
#endregion

#region Miscellaneous
///@func Player_CalculateDamage(damage, [damage_min], [damage_max])
///@desc Calculate the damage to deal to the player's HP base on the given base damage and player's DEF.
///@param {Real}	damage_base		The amount of base damage.
///@param {Real}	[damage_min]	The minimum limit of the damage calculation.
///@param {Real}	[damage_max]	The maximum limit of the damage calculation.
///@return {Real}
function Player_CalculateDamage(_damage, _damage_min = 1, _damage_max = infinity) {
	var _hp = Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP),
		_def = Player_GetDefTotal();

	_damage += (_hp >= 20 ? ceil((_hp - 20) / 10) : 0);
	_damage -= _def / 5;
	_damage = round(_damage);

	_damage = clamp(_damage, _damage_min, _damage_max);

	return _damage;
}

///@func Player_IsInBattle()
///@desc Return whenever the player is in battle or not.
///@return {Bool}
function Player_IsInBattle() {
	return (room == room_battle && instance_exists(obj_battle_controller));
}

///@func Player_GetPlot()
///@desc Return the current plot.
///@return {Real}
function Player_GetPlot() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.PLOT);
}

///@func Player_SetPlot(plot)
///@desc Set the current plot.
///@param {Real}	plot	The number of the plot.
function Player_SetPlot(_plot) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.PLOT, _plot);
}

///@func Player_GetTextTyperChoice()
///@desc 
///@return {Real}
function Player_GetTextTyperChoice() {
	return Flag_Get(FLAG_TYPE.TEMP, FLAG_TEMP.TEXTWRITER_CHOICE);
}
#endregion

#region Stats
#region Name
///@func Player_GetName()
///@desc Return the name of the player.
///@return {String}
function Player_GetName() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.NAME);
}

///@func Player_SetName(name)
///@desc Set the name for the player.
///@param {String}		name	The name to set to player.	
function Player_SetName(_name) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.NAME, _name);
}
#endregion
	
#region Lv
///@func Player_GetLv()
///@desc Return player's LV.
///@return {Real}
function Player_GetLv() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.LV);
}

///@func Player_SetLv(lv)
///@desc Set player's LV.
///@param {Real}	lv		The amount of LV to set.
function Player_SetLv(_lv) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.LV, _lv);
}
#endregion
	
#region Exp
///@func Player_GetExp()
///@desc Return player's EXP.
///@return {Real}
function Player_GetExp() {
	return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.EXP);
}

///@func Player_SetExp(exp)
///@desc Set player's EXP.
///@param {Real}	exp		The amount of EXP to set.
function Player_SetExp(_exp) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.EXP, _exp);
}
#endregion
	
#region Atk
///@func Player_GetAtk()
///@desc Return player's ATK (attack).
///@return {Real}
function Player_GetAtk() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK);
}

///@func Player_SetAtk(atk)
///@desc Set player's ATK (attack).
///@param {Real}	atk		The amount of ATK (attack) to set.
function Player_SetAtk(_atk) {
	return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ATK, _atk);
}

#endregion
	
#region Def
///@func Player_GetDef()
///@desc Return player's DEF (defense).
///@return {Real}
function Player_GetDef() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF);
}

///@func Player_SetDef(def)
///@desc Set player's DEF (defense).
///@param {Real}	def		The amount of DEF (defense) to set.
function Player_SetDef(_def) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.DEF, _def);
}
#endregion
	
#region Spd
///@func Player_GetSpd()
///@desc Return player's SPD (speed).
///@return {Real}
function Player_GetSpd() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.SPD);
}

///@func Player_SetSpd()
///@desc Set player's SPD (speed).
///@param {Real}	spd		The amount of SPD (speed) to set.
function Player_SetSpd(_spd) {
	return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.SPD, _spd);
}
#endregion
	
#region Inv
///@func Player_GetInv()
///@desc Return player's INV (invincibility).
///@return {Real}
function Player_GetInv() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.INV);
}

///@func Player_SetInv()
///@desc Set player's INV (invincibility).
///@param {Real}	inv		The amount of INV (invincibility) to set.
function Player_SetInv(inv) {
	return Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.INV, inv);
}
	
#endregion
	
#region Item
#region Atk
///@func Player_GetAtkItem()
///@desc Return item's ATK (attack).
///@return {Real}
function Player_GetAtkItem() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.ATK_ITEM);
}

///@func Player_SetAtkItem(atk)
///@desc Set item's ATK (attack).
///@param {Real}	atk		The amount of ATK (attack) to set.
function Player_SetAtkItem(_atk) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ATK_ITEM, _atk);
}
#endregion
		
#region Def
///@func Player_GetDefItem()
///@desc Return item's DEF (defense).
///@return {Real}
function Player_GetDefItem() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.DEF_ITEM);
}

///@func Player_SetDefItem()
///@desc Set item's DEF (defense).
///@param {Real}	def		The amount of DEF (defense) to set.
function Player_SetDefItem(def) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.DEF_ITEM, def);
}
#endregion
		
#region Spd
///@func Player_GetSpdItem()
///@desc Return item's SPD (speed).
///@return {Real}
function Player_GetSpdItem() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.SPD_ITEM);
}

///@func Player_SetSpdItem(spd)
///@desc Set item's SPD (speed).
///@param {Real}	spd		The amount of SPD (speed) to set.
function Player_SetSpdItem(_spd) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.SPD_ITEM, _spd);
}
#endregion
		
#region Inv
///@func Player_GetInvItem()
///@desc Return item's INV (invincibility).
///@return {Real}
function Player_GetInvItem() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.INV_ITEM);
}

///@func Player_SetInvItem(inv)
///@desc Set item's INV (invincibility).
///@param {Real}	inv		The amount of INV (invincibility) to set.
function Player_SetInvItem(_inv) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.INV_ITEM, _inv);
}	
#endregion	
#endregion
	
#region Total
///@func Player_GetAtkTotal()
///@desc Return the total amount of ATK (attack) the player is currently possessing from various sources.
///@return {Real}
function Player_GetAtkTotal() {
	var _is_in_battle = Player_IsInBattle(),
		_atk = Player_GetAtk(),
		_atk_item = Player_GetAtkItem(),
		_atk_temp = Battle_GetPlayerTempAtk(),
		_atk_total = _atk + _atk_item + (_is_in_battle ? _atk_temp : 0);
	return _atk_total;
}

///@func Player_GetDefTotal()
///@desc Return the total amount of DEF (defense) the player is currently possessing from various sources.
///@return {Real}	
function Player_GetDefTotal() {
	var _is_in_battle = Player_IsInBattle(),
		_def = Player_GetDef(),
		_def_item = Player_GetDefItem(),
		_def_temp = Battle_GetPlayerTempDef(),
		_def_total = _def + _def_item + (_is_in_battle ? _def_temp : 0);
	return _def_total;
}

///@func Player_GetSpdTotal()
///@desc Return the total amount of SPD (speed) the player is currently possessing from various sources.
///@return {Real}
function Player_GetSpdTotal() {
	var _is_in_battle = Player_IsInBattle(),
		_spd = Player_GetSpd(),
		_spd_item = Player_GetSpdItem(),
		_spd_temp = Battle_GetPlayerTempSpd(),
		_spd_total = _spd + _spd_item + (_is_in_battle ? _spd_temp : 0);
	return _spd_total;
}

///@func Player_GetInvTotal()
///@desc Return the total amount of INV (invincibility) the player is currently possessing from various sources.
///@return {Real}
function Player_GetInvTotal() {
	var _is_in_battle = Player_IsInBattle(),
		_inv = Player_GetInv(),
		_inv_item = Player_GetInvItem(),
		_inv_temp = Battle_GetPlayerTempInv(),
		_inv_total = _inv + _inv_item + (_is_in_battle ? _inv_temp : 0);
	return _inv_total;
}
#endregion
	
#region Gold
///@func Player_GetGold()
///@desc Return the amount of gold the player has.
///@return {Real}
function Player_GetGold() {
	return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.GOLD);
}

///@func Player_SetGold(gold)
///@desc Set the amount of gold the player has.
///@param {Real}	gold	The amount of gold to set.
function Player_SetGold(_gold) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD, _gold);
}
#endregion
	
#region Kill Count
///@func Player_GetKills()
///@desc Return the amount of kill the player has.
///@return {Real}
function Player_GetKills() {
	return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.KILLS);
}

///@func Player_SetKills(kills)
///@desc Set the amount of kill the player has.
///@param {Real}	kills	The amount of kill to set.
function Player_SetKills(_kills) {
	Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.KILLS, _kills);
}
#endregion
#endregion

#region LV Up
///@func Player_GetLvHpMax(lv)
///@desc Return the amount of max HP corresponding to the amount of LV.
///@param {Real}	lv		The LV amount to check.
///@return {Real}
function Player_GetLvHpMax(_lv) {
	return (_lv % 20 == 0) ? 99 * _lv : ((20 * (floor(_lv / 20) + 1)) + ((_lv - 1) * 4));
}

///@func Player_GetLvAtk(lv)
///@desc Return the amount of ATK (attack) corresponding to the amount of LV.
///@param {Real}	lv		The LV amount to check.
///@return {Real}
function Player_GetLvAtk(_lv) {
	return 10 + (_lv - 1) * 2;
}

///@func Player_GetLvDef(lv)
///@desc Return the amount of DEF (defense) corresponding to the amount of LV.
///@param {Real}	lv		The LV amount to check.
///@return {Real}
function Player_GetLvDef(_lv) {
	return 10 + ceil((_lv - 4) / 4);
}

///@func Player_GetLvExp(lv)
///@desc Return the amount of total EXP needed corresponding to the amount of LV.
///@param {Real}	lv		The LV amount to check.
///@return {Real}
function Player_GetLvExp(_lv){
	if (_lv > 0 && _lv <= 20)
	{
		static _result = [-1,   0,   10,   30,   70,  120,   200,   300,   500,   800,  1200, 
							 1700, 2500, 3500, 5000, 7000, 10000, 15000, 25000, 50000, 99999];
		return _result[_lv];
	}
	return -1;
}

///@func Player_LvUp(lv)
///@desc Update all the stats corresponding to the amount of LV.
///@param {Real}	lv		The LV amount to check.
function Player_LvUp(lv) {
	Player_SetLv(lv);
	Player_SetHpMax(Player_GetLvHpMax(lv));
	Player_SetAtk(Player_GetLvAtk(lv));
	Player_SetDef(Player_GetLvDef(lv));
}

///@func Player_UpdateLv()
///@desc Update the current LV for the player and execute Player_LvUp() if needed, and return
///		 whenever the player can level up or not.
///@return {Bool}
function Player_UpdateLv() {
	var _lv_up = (Player_GetLvExp(Player_GetLv() + 1) != -1 && Player_GetExp() >= Player_GetLvExp(Player_GetLv() + 1));
	if (_lv_up)
	{
		while (Player_GetLvExp(Player_GetLv() + 1) != -1 && Player_GetExp() >= Player_GetLvExp(Player_GetLv() + 1))
			Player_LvUp(Player_GetLv() + 1);
		return true;
	}
	return false;
}
#endregion

#region Save - Load
///@func Player_Save(slot)
///@desc Save player's data to a save slot.
///@param {Real}	slot	The number of the save slot.
function Player_Save(_slot) {
	Flag_SetSaveSlot(_slot);
	
	var _lv   = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.LV),
		_time = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.TIME),
		_room = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.ROOM),
		_name = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.NAME);
		
	Flag_Save(FLAG_TYPE.STATIC);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.LV,   _lv);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.TIME, _time);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.ROOM, _room);
	Flag_Set(FLAG_TYPE.INFO, FLAG_INFO.NAME, _name);
	Flag_Save(FLAG_TYPE.INFO);	
}

///@func Player_Load(slot)
///@desc Load player's data to a save slot.
///@param {Real}	slot	The number of the save slot.
function Player_Load(_slot) {
	Flag_SetSaveSlot(_slot);

	Flag_Load(FLAG_TYPE.STATIC);
	Flag_Load(FLAG_TYPE.DYNAMIC);
	Flag_Load(FLAG_TYPE.INFO);
}

///@func Player_SaveExists(slot)
///@desc Return whenever the save file exists or not.
///@param {Real}	slot	The number of the save slot to check for existence.
///@return {Bool}
function Player_SaveExists(_slot)
{
	Flag_SetSaveSlot(_slot);
	return (file_exists(Flag_GetSavePath(FLAG_TYPE.STATIC)) && file_exists(Flag_GetSavePath(FLAG_TYPE.DYNAMIC)) && file_exists(Flag_GetSavePath(FLAG_TYPE.INFO)));
}

#endregion
