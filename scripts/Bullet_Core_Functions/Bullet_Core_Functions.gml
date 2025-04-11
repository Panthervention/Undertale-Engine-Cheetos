///@func Battle_IsBulletValid(bullet)
///@desc Return whenever the specified bullet object/id instance is a valid bullet or not.
///@param {Asset.GMObject, Id.Instance}		bullet		The bullet object/id instance to check for validation.
///@return {Bool}
function Battle_IsBulletValid(_bullet) {
	if (!object_exists(_bullet) && instance_exists(_bullet))
		_bullet = _bullet.object_index;
	return (object_exists(_bullet)) ? (_bullet == obj_battle_bullet || object_get_base_parent(_bullet) == obj_battle_bullet) : false;	
}

///@func Battle_CallBulletEventSoulCollision()
///@desc Execute the collision event of the bullet object.
function Battle_CallBulletEventSoulCollision() {
	if (Battle_IsBulletValid(other))
	{
	    with (other)
	        event_user(BATTLE_BULLET_EVENT.SOUL_COLLISION);
	}
}

///@func Battle_BulletDestroy()
///@desc Destroy all the battle bullet.
function Battle_BulletDestroy() {
	instance_destroy(obj_battle_bullet);
}
