///@func Player_GetRoomName(room)
///@desc Return the assigned name corresponding to the room asset.
///@param {Asset.GMRoom}	room	The current room to check and get its name.
///@return {String}
function Player_GetRoomName(_room)
{
	switch (_room)
	{
	    case -1:
	        return "--";
	    case room_area_0:
	        return Lexicon("overworld.white_space.room_name").Get();
		default:
			return Lexicon("overworld.{0}.room_name", room_get_name(room)).Get();
	}
}
