/// @function							string_wrap(text, width, array_misc)
/// @description						Take a string and add line breaks so that it doesn't overflow the maximum width.
/// @param	{String}		text		The text to wrap.
/// @param	{Real}			width		The maximum width of the text before a line break is inserted.
/// @param	{Array<Any>}	array_misc	The array of parameters to use.

function string_wrap(_text, _width, _array_misc)
{
	var _text_wrapped = ""
	var _space = -1
	var _char_pos = 1
	var _w = 0
	var _c
	
	var _key = -1
	var _argument = -1
	var _nb_misc = 0
	var _nb_require = 0
	
	var _scale = global.default_scale_font
	var _betw = 0
	
	while string_length(_text) >= _char_pos
	{
		if _nb_misc < array_length(_array_misc)
		{
			_nb_require = _array_misc[_nb_misc][0]
			
			if _nb_require == _char_pos - 1
			{
				_key = _array_misc[_nb_misc][1]
				_argument = _array_misc[_nb_misc][2]
				_nb_misc ++
			}
		}
		
		switch(_key)
		{
			case "": //normal
				_betw = 0
				_scale = global.default_scale_font
				draw_set_font(global.default_font)
				break
			case "size": //mini
				_scale = real(_argument)
				break
		}
		
		_c = string_char_at(_text,_char_pos)
		
		if _c != "#"
			_w += string_width(_c) * _scale
		else {
			_space = -1
			_w = 0
		}
		
	    if _w > _width
	    {
			if _space != -1
	        {
		        _text_wrapped += string_copy(_text, 1, _space - 1) + "#"
		        _text = string_copy(_text, _space + 1, string_length(_text) - _space)
		        _char_pos = 1
		        _space = -1
				_w = 0
	        }
	    }
		
	    if string_char_at(_text, _char_pos) == " "
			_space = _char_pos
		
	    _char_pos += 1
	}
		
	if string_length(_text) > 0
		_text_wrapped += _text
	
	return _text_wrapped
}