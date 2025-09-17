function string_wrap(_text, _width, _array_misc, _textbox = false) {
	var _text_wrapped = ""
	var _space = -1
	var _char_pos = 1
	var _w = 0
	var _c
	var _replace
	
	var _key = -1
	var _nb_misc = 0
	var _nb_require = 0
	
	if _textbox
		_replace = "_"
	else
		_replace = "#"
	
	var _scale = 1
	var _betw = 0
	
	while (string_length(_text) >= _char_pos) {
		
		if _nb_misc < array_length(_array_misc) {
			_nb_require = _array_misc[_nb_misc][0]
			if _nb_require == _char_pos - 1 {
				_key = _array_misc[_nb_misc][1]
				_nb_misc ++
			}
		}
		
		switch(_key) {
			case "": //normal
				_scale = 1
				_betw = 0
				draw_set_font(global.main_font)
				break
			case "mini": //mini
				_scale = 0.5
				break
			case "sans":
				draw_set_font(fnt_sans)
				_betw = 1
				break
			case "papyrus":
				draw_set_font(global.papyrus_font)
				_betw = 1
				break
		}
		
		_c = string_char_at(_text, _char_pos)
		_w += (string_width(_c) + _betw)*_scale
		if draw_get_font() == global.papyrus_font && _c == " "
			_w += 10
		
		if (_w > _width) {
			if (_space != -1) {
				
				if draw_get_font() == global.papyrus_font
					_text_wrapped += string_copy(_text, 1, _space - 1) + "#"
				else
					_text_wrapped += string_copy(_text, 1, _space - 1) + _replace
				
			    _text = string_copy(_text, _space + 1, string_length(_text) - _space)
			    _char_pos = 1
			    _space = -1
				
				if _textbox && draw_get_font() != global.papyrus_font
					_w = string_width("* ")
				else
					_w = 0
				
		    }
		}
		
		if (_c == " ")
			_space = _char_pos
		else if (_c == "*" && _char_pos != 1) {
			_text_wrapped += string_copy(_text, 1, _space - 1) + "#"
			_text = string_copy(_text, _space + 1, string_length(_text) - _space)
			_char_pos = 1
			_space = -1
			_w = 0
		}
		_char_pos += 1
	}
	
	if (string_length(_text) > 0)
		_text_wrapped += _text
	
	draw_set_font(global.main_font)
	return _text_wrapped
}

function string_get_misc(_text) {
	var _letter
	var _code
	var _newtext = ""
	var _discard = 0
	var _array = []
	
	for (var _i = 0; _i < string_length(_text); _i++) {
		
		_letter = string_char_at(_text, _i + 1)
		if _letter == "{" {
			_code = ""
			_i ++
			_discard ++
			_letter = string_char_at(_text, _i + 1)
			while (_letter != "}" && _i < string_length(_text)) {
				_code += _letter
				_i ++
				_discard ++
				_letter = string_char_at(_text, _i + 1)
			}
			array_push(_array, [_i - _discard, _code])
			_discard ++
		} else {
			_newtext += _letter
		}
		
	}
	
	return [_newtext, _array]
}

function draw_text_special(_x, _y, _text, _z, _w, _array_misc) {
	
	var _x0 = _x
	var _y0 = _y
	
	var _cc = 1
	
	var _height = 0
	var _width = 0
	var _color = c_white
	var _effect = 0
	var _betw = 0
	
	var _key = -1
	var _nb_misc = 0
	var _nb_require = 0
	
	var _begin = false
	
	var _t = global.total_time
	
	var _amplitude = 2.5
	var _freq = 2
	var _char_size = 1
	var _scale = 1
	var _dark = global.world && object_index == obj_textbox
	var _darkcolor = make_color_rgb(0, 0, 100)
	var _alpha = 1
	
	var _so
	var _shift
	var _shake1
	var _shake2
	
	var _halign = draw_get_halign()
	draw_set_halign(fa_left)
	var _carac
	switch _halign {
		case fa_right:
			_carac = string_pos("#", _text)
			if _carac == 0
				_x = _x0  - string_width(_text)
			else
				_x = _x0 - string_width(string_copy(_text, 1, _carac - 1))
			break
		case fa_center:
			_carac = string_pos("#", _text)
			if _carac == 0
				_x = _x0 - string_width(_text)/2
			else
				_x = _x0 - string_width(string_copy(_text, 1, _carac - 1))/2
			break
	}
	
	var _valign = draw_get_valign()
	var _count = string_count("#", _text)
	draw_set_valign(fa_top)
	switch _valign {
		case fa_bottom:
			_y = _y0 - string_height_ext(string_hash_to_newline(_text), _z, _w) + 1
			break
		case fa_middle:
			_count = 2 - (_count mod 2)
			_y = _y0 - (string_height_ext(string_hash_to_newline(_text), _z, _w) - _count)/2
			break
	}
	
	repeat(string_length(_text)) {
		
		//Get current _letter
		var _letter = string_char_at(_text, _cc)
		var _newline = false
		
		if _letter == "#" {
			_width = 0
			_height += _z
			_newline = true
		} else if _letter == "_" {
			_width = string_width("*")*_scale
			_height += _z
			_letter = " "
			_newline = true
		}
		
		if (_newline) {
			_carac = string_pos_ext("#", _text, _cc)
			var _carac2 = string_pos_ext("#", _text, _carac + 1)
			if _carac2 == 0
				_carac2 = 1000
			switch _halign {
				case fa_right:
					_x = _x0 - string_width(string_copy(_text, _carac + 1, _carac2 - _carac - 1))
					break
				case fa_center:
					_x = _x0 - string_width(string_copy(_text, _carac + 1, _carac2 - _carac - 1))/2
					break
			}
		}
		
		_key = -1
		
		while _nb_misc < array_length(_array_misc) && _array_misc[_nb_misc][0] == _cc - 1 {
			_key = _array_misc[_nb_misc][1]
			_nb_misc ++
			
			switch(_key) {
				case "": //normal
					_effect = 0
					_scale = 1
					_color = c_white
					draw_set_font(global.main_font)
					break
				case "yellow":
					_color = c_yellow
					break
				case "red":
					_color = c_red
					break
				case "shake": //shakey
					_effect = 1
					break
				case "wave": //wave
					_effect = 2
					break
				case "flatwave": //flat wave
					_effect = 3
					break
				case "rainbow": //wave AND colour shift
					_effect = 4
					break
				case "mini": //mini
					_scale = 0.5
					break
				case "transalpha":
					if variable_instance_exists(id, "sub_avance")
						_alpha = sub_avance + 1
					break
				case "sans":
					draw_set_font(fnt_sans)
					_betw = 1
					break
				case "papyrus":
					draw_set_font(global.papyrus_font)
					_betw = 1
					break
				case "choice0":
					if (variable_instance_exists(id, "choice") && choice == 0)
						_color = c_yellow
					break
				case "choice1":
					if (variable_instance_exists(id, "choice") && choice == 1)
						_color = c_yellow
					break
				case "choice2":
					if (variable_instance_exists(id, "choice") && choice == 2)
						_color = c_yellow
					break
				case "choice3":
					if (variable_instance_exists(id, "choice") && choice == 3)
						_color = c_yellow
					break
			}
		}
		
		var _letter_width = string_width(_letter)
		if string_char_at(_text, _cc) == "#"
			_letter_width = 0
		
		_letter = string_hash_to_newline(_letter)
	
		switch(_effect) {
			case 0: //normal
				if _dark
					draw_text_transformed_colour(_x + _width + 0.5, _y + _height + 0.5, _letter, _scale, _scale, 0, _darkcolor, _darkcolor, _darkcolor, _darkcolor, _alpha)
				draw_text_transformed_colour(_x + _width, _y + _height, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break

			case 1: //shakey
				_shake1 = random_range(-0.5,0.5)
				_shake2 = random_range(-0.5,0.5)
				if _dark
					draw_text_transformed_colour(_x + _width + _shake1 + 1, _y + _height + _shake2 + 1, _letter, _scale, _scale, 0, _darkcolor, _darkcolor, _darkcolor, _darkcolor, _alpha)
				draw_text_transformed_colour(_x + _width + _shake1, _y + _height + _shake2, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break
    
			case 2: //wave
				_so = _t + _cc
				_shift = sin(_so*pi*_freq/60)*_amplitude
				if _dark
					draw_text_transformed_colour(_x + _width + 1, _y + _height + _shift + 1, _letter, _scale, _scale, 0, _darkcolor, _darkcolor, _darkcolor, _darkcolor, _alpha)
				draw_text_transformed_colour(_x + _width, _y + _height + _shift, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break
    
			case 3: //flat wave
				_so = _t;
				_shift = sin(_so*pi*_freq/60)*_amplitude
				if _dark
					draw_text_transformed_colour(_x + _width + 1, _y + _height + _shift + 1, _letter, _scale, _scale, 0, _darkcolor, _darkcolor, _darkcolor, _darkcolor, _alpha)
				draw_text_transformed_colour(_x + _width, _y + _height + _shift, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break
    
			case 4: //wave AND colour shift
				_so = _t + _cc
				_shift = sin(_so*pi*_freq/60)*_amplitude
				var _c1 = make_colour_hsv((_t + _cc) mod 255, 255, 255)
				var _c2 = make_colour_hsv((_t + _cc + 45) mod 255, 255, 255)
				if _dark
					draw_text_transformed_colour(_x + _width + 1, _y + _height + _shift + 1, _letter, _scale, _scale, 0, _darkcolor, _darkcolor, _darkcolor, _darkcolor, _alpha)
				draw_text_transformed_colour(_x + _width, _y + _height + _shift, _letter, _scale, _scale, 0, _c1, _c1, _c2, _c2, _alpha)
				break
		}
		_width += (_letter_width + _betw)*_scale
		if draw_get_font() == global.papyrus_font && _letter == " "
			_width += 10
       
		 //Increment variables for next _letter
		_cc += 1
	}
	
	draw_set_halign(_halign)
	draw_set_valign(_valign)
	draw_set_font(global.main_font)
}