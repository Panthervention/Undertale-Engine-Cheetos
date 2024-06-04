var _beam = [image_xscale, image_alpha];
if (!global.inv && (_beam[1] >= 0.8 and _beam[0] > 0.05) && place_meeting(x, y, obj_battle_soul))
	Battle_CallSoulEventBulletCollision();
