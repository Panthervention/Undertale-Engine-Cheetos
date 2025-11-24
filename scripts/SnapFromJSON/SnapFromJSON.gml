// Feather disable all

/// @return Nested struct/array data that represents the contents of the JSON string
/// 
/// @param string                   The JSON string to be decoded
/// @param [trackFieldOrder=false]  Whether to track the order of struct fields as they appear in the JSON string (stored in __snapFieldOrder field on each GML struct)
/// 
/// Juju Adams 2025-10-10

function SnapFromJSON(_string, _trackFieldOrder = false)
{
    var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    var _data = SnapBufferReadJSON(_buffer, 0, _trackFieldOrder);
    buffer_delete(_buffer);
    return _data;
}
