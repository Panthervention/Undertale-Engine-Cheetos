var _user = user_char;
var _result = false;
if (instance_exists(obj_char))
{
    with (obj_char)
    {
        if (char_id == _user || _user == -1)
        {
            _result = place_meeting(x, y, other);
            if (_result)
                break;
        }
    }
}
if (!__triggered && _result)
{
    event_user(0);
    __collided_previous = true;
}
else if (__triggered && __collided_previous && !_result)
{
    event_user(1);
    __collided_previous = false;
}
