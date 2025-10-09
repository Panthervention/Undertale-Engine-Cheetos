Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.ROOM, room);
room_persistent = false;

#region Camera Functions
camera.Reload();
#endregion

#region Overworld Texture Group Loading
var _tg_ow = "texgroup_overworld", _tg_bt = "texgroup_battle",
	_tg_ow_status = texturegroup_get_status(_tg_ow),
	_tg_bt_status = texturegroup_get_status(_tg_bt);

if (Player_IsInBattle())
{
	if (_tg_ow_status == texturegroup_status_fetched)
		texturegroup_unload(_tg_ow);
	if (_tg_bt_status == texturegroup_status_unloaded)
		texturegroup_load(_tg_bt);
}
else
{
	if (_tg_ow_status == texturegroup_status_unloaded)
		texturegroup_load(_tg_ow);
	if (_tg_bt_status == texturegroup_status_fetched)
		texturegroup_unload(_tg_bt);
}
#endregion
