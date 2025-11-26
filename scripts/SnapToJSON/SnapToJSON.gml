// Feather disable all
/// @return JSON string that encodes the struct/array nested data
/// 
/// @param struct/array                The data to be encoded. Can contain structs, arrays, strings, and numbers.   N.B. Will not encode ds_list, ds_map etc.
/// @param [pretty=false]              (bool) Whether to format the string to be human readable
/// @param [alphabetizeStructs=false]  (bool) Sorts struct variable names is ascending alphabetical order as per array_sort()
/// @param [accurateFloats=false]      (bool) Whether to output floats at a higher accuracy than GM normally defaults to. Setting this to <true> confers a performance penalty
/// @param [useFieldOrder=true]        (bool) Whether to respect the special .__snapFieldOrder array when writing struct fields
/// 
/// Juju Adams 2025-10-10

function SnapToJSON(_ds, _pretty = false, _alphabetise = false, _accurateFloats = false, _useFieldOrder = true)
{
    var _buffer = buffer_create(1024, buffer_grow, 1);
    SnapBufferWriteJSON(_buffer, _ds, _pretty, _alphabetise, _accurateFloats, _useFieldOrder);
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _string = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    return _string; 
}
