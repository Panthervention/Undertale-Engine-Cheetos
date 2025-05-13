///@desc Soul Collision
if (image_alpha >= 1)
{
	Battle_CallSoulEventHurt();
	Player_Hurt(dmg, kr);
	kr = 1;
}
