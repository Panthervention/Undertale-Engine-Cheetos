function Battle_GetRewardExp() {
	return obj_battle_controller._reward_exp;
}

///@arg reward_exp
function Battle_RewardExp(EXP) {
	obj_battle_controller._reward_exp += EXP;
	return true;
}

function Battle_GetRewardGold() {
	return obj_battle_controller._reward_gold;
}

///@arg reward_gold
function Battle_RewardGold(GOLD) {
	obj_battle_controller._reward_gold += GOLD;
	return true;
}
