///@arg bullet_obj/inst
function Battle_IsBulletValid(bullet)
{
	if (!object_exists(bullet) && instance_exists(bullet))
	    bullet = bullet.object_index;
	if (object_exists(bullet))
	    return (bullet == obj_battle_bullet || object_get_base_parent(bullet) == obj_battle_bullet);
	else
	    return false;
}

function Battle_CallBulletEventSoulCollision()
{
	if (Battle_IsBulletValid(other))
	{
	    with (other)
	        event_user(BATTLE_BULLET_EVENT.SOUL_COLLISION);
	}
	else
	    return false;
}

function Battle_BulletDestroy()
{
	instance_destroy(obj_battle_bullet);
	return true;
}