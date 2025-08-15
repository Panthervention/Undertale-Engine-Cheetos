///@desc Soul Collision
if (image_alpha >= 1)
{
	if (Battle_SoulBulletCollisionTypeCheck(type)) {
		Battle_CallSoulEventHurt();
		Player_Hurt(dmg, kr);
		kr = 1;
	}
}
