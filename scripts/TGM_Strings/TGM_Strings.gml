
/// Feather ignore all

/// @desc Converts all string characters to a character. Useful for passwords.
/// @param {string} str Text string.
/// @param {string} char The character to convert.
/// @returns {string} 
function string_password(str, char="*") {
	return string_repeat(char, string_length(str));
}

/// @desc Adds some zeros to the string.
/// @param {string} str Text string.
/// @param {real} zero_amount The amount of zeros to be added.
/// @returns {string} 
function string_zeros(str, zero_amount) {
	return string_replace_all(string_format(str, zero_amount, 0), " ", "0");
}

/// @desc Add an ellipsis to the string if it is longer than the given width.
/// @param {string} str Text string.
/// @param {real} width The maximum text width.
/// @returns {string} 
function string_limit(str, width) {
	var _len = width / string_width("M");
	return string_width(str) < width ? str : string_copy(str, 1, _len) + "...";
}

/// @desc Add an ellipsis to the string if it is longer than the given width, for non-monospace fonts.
/// @param {string} str Text string.
/// @param {real} width The maximum text width.
/// @returns {string} 
function string_limit_nonmono(str, width) {
	if (string_width(str) < width) return str;
	var _str = "", _char = "",
	i = 1, isize = string_length(str), _ww = 0;
	repeat(isize) {
		_char = string_char_at(str, i);
		_ww += string_width(_char);
		if (_ww < width) _str += _char;
		++i;
	}
	return _str + "...";
}

/// @desc Leave each character in the string with random case.
/// @param {string} str Text string.
/// @param {bool} first_is_upper Is the first letter uppercase?
/// @param {real} sequence Sequence in which the letters will be changed.
/// @param {bool} skip_char Define if will skip a character.
/// @param {string} char The character to skip.
/// @returns {string} 
function string_random_letter_case(str, first_is_upper=true, sequence=1, skip_char=true, char=" ") {
	var _str_final = "", _f1 = undefined, _f2 = undefined;
	if (first_is_upper) {
		_f1 = string_lower;
		_f2 = string_upper;
	} else {
		_f1 = string_upper;
		_f2 = string_lower;
	}
	var i = 1, isize = string_length(str), _index = 1;
	repeat(isize) {
		var _char = string_char_at(str, i);
		_str_final += (_index % (sequence+1) == 0) ? _f1(_char) : _f2(_char);
		if (!skip_char || _char != char) _index++;
		++i;
	}
	return _str_final;
}

/// @desc Capitalize the first letter of the string
/// @param {string} str Text string.
/// @returns {string} 
function string_first_letter_upper_case(str) {
	var _string = string_lower(str),
	_str_final = "",
	i = 1, isize = string_length(str);
	repeat(isize) {
		var _char = string_char_at(_string, i);
		_str_final += (i == 1) ? string_upper(_char) : _char;
		++i;
	}
	return _str_final;
}

/// @desc Capitalizes each word in the string.
/// @param {string} str Text string.
/// @returns {string} 
function string_word_first_letter_upper_case(str) {
	var _string = string_lower(str),
	_str_final = "",
	i = 1, isize = string_length(str);
	repeat(isize) {
		var _char = string_char_at(_string, i);
		var _pchar = string_char_at(_string, i-1);
		_str_final += (_pchar == " " || i == 1) ? string_upper(_char) : _char;
		++i;
	}
	return _str_final;
}

/// @desc Uppercase letters become lowercase and vice-versa.
/// @param {string} str Text string.
/// @returns {string} 
function string_case_reverse(str) {
	var _str_final = "",
	i = 1, isize = string_length(str);
	repeat(isize) {
		var _char = string_char_at(str, i),
		_char_upper = string_upper(_char),
		_char_lower = string_lower(_char);
		_str_final += (_char == _char_upper) ? _char_lower : _char_upper;
		++i;
	}
	return _str_final;
}

/// @desc Put string characters in reverse order.
/// @param {string} str Text string.
/// @returns {string} 
function string_reverse(str) {
	var _str_final = "",
	isize = string_length(str), i = isize;
	repeat(isize) {
		_str_final += string_char_at(str, i);
		--i;
	}
	return _str_final;
}
/**
	Converts a string to an array
	@param {string} string	The string to convert the array to
 */
function string_to_array(str) {
	gml_pragma("forceinline");
	var i = 1, n = string_length(str), arr = [];
	repeat n array_push(arr, string_copy(str, i++, 1));
	return arr;
}
/**
	Converts a array to a string
	@param {Array<string>} array	The array to convert the string to
*/
function array_to_string(arr) {
	gml_pragma("forceinline");
	var i = 0, n = array_length(arr), txt = "";
	repeat n txt += arr[i++];
	return txt;
}

// replaces all Unicode escapes in a string with corresponding characters
function string_replace_unicode(str) {
	gml_pragma("forceinline");
    var ucode_idx = string_pos_ext("\\u", str, 0);
    while ucode_idx >= 1 {
        // replace a Unicode escape with its corresponding character
        var hex = string_copy(str, ucode_idx + 2, 4),
			character = chr_from_hex(hex);
        str = string_copy(str, 1, ucode_idx - 1) + character + string_delete(str, 1, ucode_idx + 3);
        // the next Unicode sequence will be after the recently found one
        ucode_idx = string_pos_ext("\\u", str, ucode_idx);
    }
    return str;
}

// parses a hexadecimal number to a corresponding character
function chr_from_hex(str) {
	gml_pragma("forceinline");
    str = string_upper(str);
    var result = 0, length = string_length(str);
    for (var i = 1; i <= length; i++) {
        var c = string_char_at(str, i), val = string_pos(c, "0123456789ABCDEF")-1;
        result = (result << 4) + val;
    }
    return chr(result);
}

/**
	Returns a given value as a string of hexadecimal digits.
	Hexadecimal strings can be padded to a minimum length.
	Note: If the given value is negative, it will
	be converted using its two's complement form.
	@param  {real}      dec		integer
	@param  {real}      len		minimum number of digits
*/
function dec_to_hex(dec, len = 1) {
	gml_pragma("forceinline");
    var hex = "";

    if (dec < 0) {
        len = max(len, ceil(logn(16, 2 * abs(dec))));
    }

    var dig = "0123456789ABCDEF";
    while (len-- || dec) {
        hex = string_char_at(dig, (dec & $F) + 1) + hex;
        dec = dec >> 4;
    }

    return hex;
}

function buffer_read_utf8(_buffer) { // To help read UTF8 strings
	var _value = buffer_read(_buffer, buffer_u8);
	if ((_value & 0xE0) == 0xC0) { //two-byte
		_value  = (_value & 0x1F) <<  6;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F);
	} else if ((_value & 0xF0) == 0xE0) { //three-byte
		_value  = ( _value & 0x0F) << 12;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F) <<  6;
		_value +=  buffer_read(_buffer, buffer_u8) & 0x3F;
	} else if ((_value & 0xF8) == 0xF0)  { //four-byte
		_value  = (_value & 0x07) << 18;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F) << 12;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F) <<  6;
		_value +=  buffer_read(_buffer, buffer_u8) & 0x3F;
	}
		
	return _value;	
}

// Lowers a string using the buffer method, this is faster than the built-in string_lower()
// Credits to TabularElf
function string_lower_buffer(_string) {
	gml_pragma("forceinline");
	static _strBuffer = buffer_create(1024, buffer_grow, 1);
	
	// Exit early
	var _len = string_byte_length(_string)
	if (_len == 0) return _string;
	
	buffer_seek(_strBuffer, buffer_seek_start, 0);
	buffer_write(_strBuffer, buffer_text, _string);
	buffer_seek(_strBuffer, buffer_seek_start, 0);
	repeat(_len) {
		var _value = buffer_read_utf8(_strBuffer);
		if (_value >= 0x41) && (_value <= 0x5A) {
			buffer_seek(_strBuffer, buffer_seek_relative, -1);
			buffer_write(_strBuffer, buffer_u8, _value + 32);
		}
	}
	
	buffer_write(_strBuffer, buffer_u8, 0); // NULL byte, so we can read back what we've changed.
	buffer_seek(_strBuffer, buffer_seek_start, 0);
	return buffer_read(_strBuffer, buffer_text);
}
