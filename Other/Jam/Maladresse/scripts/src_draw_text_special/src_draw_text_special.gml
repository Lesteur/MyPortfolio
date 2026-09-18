/// @function							draw_text_special(x, y, string, z, array_misc)
/// @description						Draw any string in the room with special effects.
/// @param	{Real}			x			The x coordinate of the drawn string.
/// @param	{Real}			y			The y coordinate of the drawn string.
/// @param	{String}		string		The string to draw.
/// @param	{Real}			z			The distance in pixels between lines of text.
/// @param	{Array<Real>}	array_misc	The array with effects to use.

function draw_text_special(_x, _y, _text, _z, _array_misc)
{
	var _x0 = _x
	var _y0 = _y
	var _cc = 1
	
	var _height = 0
	var _width = 0
	var _color = c_white
	var _effect = 0
	var _betw = 0
	
	var _key = -1
	var _argument = 0
	var _nb_misc = 0
	var _nb_require = 0
	
	var _begin = false
	
	var _t = global.timegame
	
	var _amplitude = 2.5
	var _freq = 2
	var _char_size = 1
	
	var _scale = global.default_scale_font
	var _alpha = 1
	
	var _so
	var _shift
	var _shake1
	var _shake2
	
	var _halign = draw_get_halign()
	draw_set_halign(fa_left)
	
	var _valign = draw_get_valign()
	draw_set_valign(fa_bottom)
	
	repeat(string_length(_text))
	{
		//Get current _letter
		var _letter = string_char_at(_text, _cc)
		var _newline = false
		
		if _letter == "#"
		{
			_width = 0
			_height += _z
			_newline = true
		}
		
		_key = -1
		
		while (_nb_misc < array_length(_array_misc)) && (_array_misc[_nb_misc][0] == _cc - 1)
		{
			_key = _array_misc[_nb_misc][1]
			_argument = _array_misc[_nb_misc][2]
			_nb_misc ++
			
			switch(_key)
			{
				case "": //normal
					_effect = 0
					_color = c_white
					_scale = global.default_scale_font
					draw_set_font(global.default_font)
					break
				case "color":
					switch _argument
					{
						case "red":
							_color = c_red
							break
						case "yellow":
							_color = c_yellow
							break
						case "blue":
							_color = c_blue
							break
						case "green":
							_color = c_green
							break
						case "cyan":
							_color = make_color_rgb(0, 255, 255)
							break
						case "orange":
							_color = c_orange
							break
						case "pink":
							_color = make_color_rgb(255, 180, 180)
							break
						case "purple":
							_color = c_purple
							break
						default:
							_color = c_white
							break
					}
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
				case "size": //size
					_scale = real(_argument)
					break
				case "glitch": //glitch
					_effect = 5
				case "choice0":
					if variable_instance_exists(id, "choice") && (choice == 0)
						_color = c_yellow
					break
				case "choice1":
					if variable_instance_exists(id, "choice") && (choice == 1)
						_color = c_yellow
					break
				case "choice2":
					if variable_instance_exists(id, "choice") && (choice == 2)
						_color = c_yellow
					break
				case "choice3":
					if variable_instance_exists(id, "choice") && (choice == 3)
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
				draw_text_transformed_colour(_x + _width, _y + _height, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break

			case 1: //shakey
				_shake1 = random_range(-0.5, 0.5)
				_shake2 = random_range(-0.5, 0.5)
				draw_text_transformed_colour(_x + _width + _shake1, _y + _height + _shake2, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break
    
			case 2: //wave
				_so = _t + _cc
				_shift = sin(_so * pi* _freq/60) * _amplitude
				draw_text_transformed_colour(_x + _width, _y + _height + _shift, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break
    
			case 3: //flat wave
				_so = _t
				_shift = sin(_so* pi * _freq/60) * _amplitude
				draw_text_transformed_colour(_x + _width, _y + _height + _shift, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
				break
    
			case 4: //wave AND colour shift
				_so = _t + _cc
				_shift = sin(_so * pi * _freq/60) * _amplitude
				var _c1 = make_colour_hsv((_t + _cc) mod 255, 255, 255)
				var _c2 = make_colour_hsv((_t + _cc + 45) mod 255, 255, 255)
				draw_text_transformed_colour(_x + _width, _y + _height + _shift, _letter, _scale, _scale, 0, _c1, _c1, _c2, _c2, _alpha)
				break
			
			case 5: //glitch
				var _intervalle = _t mod (5 * 5)
				var _case = floor(_intervalle / 5)
				
				switch _case
				{
					case 0:
						_color = c_olive
						draw_text_transformed_color(_x + _width - 3, _y + _height + 2, _letter, _scale * 0.9, _scale * 1.5, 0, _color, _color, _color, _color, _alpha)
						draw_rectangle_color(_x + _width - 3, _y + _height - 6, _x + _width + _letter_width - 4, _y + _height - 4, _color, _color, _color, _color, false)
						break
					case 1:
						draw_text_transformed_color(_x + _width + 5, _y + _height - 4, _letter, _scale * 1.2, _scale, 5, c_white, c_white, c_silver, c_silver, _alpha)
						break
					case 2:
						var _rand = random(1)
						
						if _rand < 0.5
							_alpha = 0
						else
							_alpha = 1
						
						draw_text_transformed_color(_x + _width, _y + _height, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
						break
					case 3:
						switch string_upper(_letter)
						{
							case "O":
								_letter = "0"
								break
							case "À":
								_letter = "Ã©"
								break
							case "E":
								_letter = "3"
								break
							case "I":
								_letter = "!"
								break
							case "S":
								_letter = "5"
								break
						}
						_letter_width = string_width(_letter)
						draw_text_transformed_color(_x + _width, _y + _height, _letter, _scale, _scale, 0, c_white, c_white, c_silver, c_silver, _alpha)
						break
					default:
						_color = c_red
						_letter = choose("0", "1")
						draw_text_transformed_colour(_x + _width, _y + _height, _letter, _scale, _scale, 0, _color, _color, _color, _color, _alpha)
						break
				}
				break
		}
		_width += (_letter_width + _betw) * _scale
       
		 //Increment variables for next _letter
		_cc += 1
	}
	
	draw_set_halign(_halign)
	draw_set_valign(_valign)
}