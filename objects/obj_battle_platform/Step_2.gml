xdelta = x - xprevious;
ydelta = y - yprevious;

if destroyable
{
	var destroy = false;
	var end_point = length;
	
	if (destroydir == DIR.UP and y < 0)
	or (destroydir == DIR.DOWN and y > 480)
	or (destroydir == DIR.LEFT and x < 0)
	or (destroydir == DIR.RIGHT and y > 640)
		destroy = true;
	else if y < -end_point or y > (480 + end_point) or x < -end_point or x > (640 + end_point)
		destroy = true;
	
	if destroy
		instance_destroy();
}
if (Battle_GetState() != BATTLE_STATE.IN_TURN)
	instance_destroy();

