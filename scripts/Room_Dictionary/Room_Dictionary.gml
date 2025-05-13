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
	        return lexicon_text("overworld.white_space.room_name");
	}
}
