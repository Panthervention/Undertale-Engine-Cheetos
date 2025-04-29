///@func Player_GetRoomName(room)
///@desc Return the assigned name corresponding to the room asset.
///@param {Asset.GMRoom}	room	The current room to check and get its name.
///@return {String}
function Player_GetRoomName(_room)
{
	static _room_name = "";
	switch (_room)
	{
	    case -1:
	        _room_name = "--";
	    case room_area_0:
	        _room_name = lexicon_text("overworld.white_space.room_name");
	}
	return _room_name;
}
