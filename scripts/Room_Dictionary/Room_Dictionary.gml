///@param room
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
