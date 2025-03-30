///@desc End 
var _duration = 30;
TweenFire(id, "", 0, off, 0, _duration, "image_xscale>", 0);
TweenFire(id, "", 0, off, 0, _duration, "image_alpha>", 0);

alarm[1] = _duration;
global.menu_hurt = "activated";
global.deadable = false;
