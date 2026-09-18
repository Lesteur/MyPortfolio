/// @function					string_get_misc(text)
/// @description				Take a string and get theirs misc.
/// @param	{String}	text	The text to get the misc.

function string_get_misc(_text)
{
	var _letter
	var _code
	var _newtext = ""
	var _discard = 0
	var _array = []
	
	for (var _i = 0; _i < string_length(_text); _i++)
	{
		_letter = string_char_at(_text, _i + 1)
		
		if _letter == "{"
		{
			_code = ""
			_i ++
			_discard ++
			_letter = string_char_at(_text, _i + 1)
			
			while (_letter != "}" && _i < string_length(_text))
			{
				_code += _letter
				_i ++
				_discard ++
				_letter = string_char_at(_text, _i + 1)
			}
			
			var _param = ""
			var _space = string_pos(" ", _code)
			
			if _space != 0
			{
				_param = string_copy(_code, _space + 1, 100)
				_code = string_copy(_code, 1, _space - 1)
			}
			
			array_push(_array, [_i - _discard, _code, _param])
			_discard ++
		} else
			_newtext += _letter
		
	}
	
	return [_newtext, _array]
}