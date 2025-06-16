///@desc Soul Collision
if (Battle_SoulBulletCollisionTypeCheck(type)) {
	Battle_CallSoulEventHurt();
	Player_Hurt(dmg, kr);
	kr = 1;
}