///@func Battle_GetRewardExp()
///@desc Return the amount of total reward EXP of the battle.
///@return {Real}
function Battle_GetRewardExp() {
	return obj_battle_controller.__reward_exp;
}

///@func Battle_RewardExp(reward_exp)
///@desc Add total reward EXP for the battle.
///@param {Real}	reward_exp		The amount of total EXP to add.
function Battle_RewardExp(_reward_exp) {
	obj_battle_controller.__reward_exp += _reward_exp;
}

///@func Battle_GetRewardGold()
///@desc Return the amount of total reward gold of the battle.
///@return {Real}
function Battle_GetRewardGold() {
	return obj_battle_controller.__reward_gold;
}

///@func Battle_RewardGold(reward_gold)
///@desc Add total reward gold for the battle.
///@param {Real}	reward_gold		The amount of total gold to add.
function Battle_RewardGold(_reward_gold) {
	obj_battle_controller.__reward_gold += _reward_gold;
}
