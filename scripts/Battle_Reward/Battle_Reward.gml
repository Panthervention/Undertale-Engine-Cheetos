function Battle_GetRewardExp() {
	return obj_battle_controller.__reward_exp;
}

///@param reward_exp
function Battle_RewardExp(EXP) {
	obj_battle_controller.__reward_exp += EXP;
}

function Battle_GetRewardGold() {
	return obj_battle_controller.__reward_gold;
}

///@param reward_gold
function Battle_RewardGold(GOLD) {
	obj_battle_controller.__reward_gold += GOLD;
}
