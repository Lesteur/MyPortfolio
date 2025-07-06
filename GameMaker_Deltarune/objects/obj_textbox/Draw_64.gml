//draw_sprite_stretched(textbox_sprite, 0, position_x, position_y, textbox_width, textbox_height)
//draw_sprite_stretched(spr_box_menu_dark, 0, position_x - 4, position_y - 4, textbox_width + 8, textbox_height + 8)

var _x = 0
var _y = 0
if textbox_sprite == spr_box_menu_dark {
	_x = 4
	dark_spr += dark_a
}

draw_sprite_stretched(textbox_sprite, dark_spr, position_x - _x, position_y - _x, textbox_width + _x*2, textbox_height + _x*2)

if setup {

	var _offset_x

	if (array_length(array) > page && array[page] != 0) {
		_offset_x = array_text_x_offset[page]
		var _drawtest  = string_copy(array_text[page], 1, ceil(draw_char))

		if (array_length(array_speaker_sprite) > page && array_speaker_sprite[page] != noone)
			draw_sprite(array_speaker_sprite[page], textbox_image, position_x + border_text_x, position_y + textbox_height/2)//(textbox_height - sprite_get_height(array_speaker_sprite[page]))/2)// + border_text_y)

		draw_text_special(_offset_x + position_x + border_text_x, position_y + border_text_y, _drawtest, line_sep, line_width, array_text_misc[page])
	}

	var _sub_avance = sub_avance*5
	var _alpha = sub_avance + 1
	var _c = c_white

	//Sub dialogue 1
	if (array_length(array_sub1) > page && array_sub1[page] != 0) {
		if array_speaker_sprite_sub1[page] != noone
			draw_sprite_ext(array_speaker_sprite_sub1[page], 0, _sub_avance + position_x + border_text_x + sub_x1, position_y + (border_text_y + textbox_height/2)/2 + sub_y1, 0.5, 0.5, 0, c_white, _alpha)
	
		_offset_x = array_text_x_offset_sub1[page]
		//draw_text_ext_transformed_colour(_sub_avance + _offset_x + position_x + border_text_x + sub_x1, position_y + border_text_y + sub_y1, array_text_sub1[page], line_sep, line_width, 0.5, 0.5, 0, _c, _c, _c, _c, _alpha)
		draw_text_special(_sub_avance + _offset_x + position_x + border_text_x + sub_x1, position_y + border_text_y + sub_y1, array_text_sub1[page], line_sep/2, line_width, array_text_misc_sub1[page])
	}

	//Sub dialogue 2
	if (array_length(array_sub2) > page && array_sub2[page] != 0) {
		if array_speaker_sprite_sub2[page] != noone
			draw_sprite_ext(array_speaker_sprite_sub2[page], 0, _sub_avance + position_x + border_text_x + sub_x2, position_y + (border_text_y + textbox_height/2)/2 + sub_y2, 0.5, 0.5, 0, c_white, _alpha)
	
		_offset_x = array_text_x_offset_sub2[page]
		//draw_text_ext_transformed_colour(_sub_avance + _offset_x + position_x + border_text_x + sub_x2, position_y + border_text_y + sub_y2, array_text_sub2[page], line_sep, line_width, 0.5, 0.5, 0, _c, _c, _c, _c, _alpha)
		draw_text_special(_sub_avance + _offset_x + position_x + border_text_x + sub_x2, position_y + border_text_y + sub_y2, array_text_sub2[page], line_sep/2, line_width, array_text_misc_sub2[page])
	}

	//Sub dialogue 3
	if (array_length(array_sub3) > page && array_sub3[page] != 0) {
		if array_speaker_sprite_sub3[page] != noone
			draw_sprite_ext(array_speaker_sprite_sub3[page], 0, _sub_avance + position_x + border_text_x + sub_x3, position_y + (border_text_y + textbox_height/2)/2 + sub_y3, 0.5, 0.5, 0, c_white, _alpha)
	
		_offset_x = array_text_x_offset_sub3[page]
		//draw_text_ext_transformed_colour(_sub_avance + _offset_x + position_x + border_text_x + sub_x3, position_y + border_text_y + sub_y3, array_text_sub3[page], line_sep, line_width, 0.5, 0.5, 0, _c, _c, _c, _c, _alpha)
		draw_text_special(_sub_avance + _offset_x + position_x + border_text_x + sub_x3, position_y + border_text_y + sub_y3, array_text_sub3[page], line_sep/2, line_width, array_text_misc_sub3[page])
	}

}

if (nb_choice > 0) {
	
	if choice == -1
		draw_sprite(spr_small_soul_red, 0, position_x + textbox_width/2 - 4, position_y + border_text_y + line_sep + 4)
	
	var _color
	
	for (var _i = 0; _i < nb_choice; _i ++) {
		
		if choice == _i {
			_x = 0
			_y = 0
			
			switch choice {
				case 0:
					_x = -10
					_y = -3
					break
				case 1:
					_x = -10 - string_width(string_hash_to_newline(array_text_choice[_i]))
					_y = -3
					break
				case 2:
					_x = -10 - string_width(string_hash_to_newline(array_text_choice[_i]))/2
					_y = (string_height_ext(string_hash_to_newline(array_text_choice[_i]), line_sep, 5000))/2 - 4
					break
				case 3:
					_x = -10 - string_width(string_hash_to_newline(array_text_choice[_i]))/2
					_y = -(string_height_ext(string_hash_to_newline(array_text_choice[_i]), line_sep, 5000))/2 - 3
					break
			}
			
			draw_sprite(spr_small_soul_red, 0, position_x + array_x_choice[_i] + _x, position_y + array_y_choice[_i] + _y)
		}
		
		draw_set_halign(array_halign_choice[_i])
		draw_set_valign(array_valign_choice[_i])
		
		//draw_text_ext_color(position_x + array_x_choice[_i], position_y + array_y_choice[_i], string_hash_to_newline(array_text_choice[_i]), line_sep - 3, 5000, _color, _color, _color, _color, 1)
		draw_text_special(position_x + array_x_choice[_i], position_y + array_y_choice[_i], array_text_choice[_i], line_sep - 3, 5000, array_text_misc_choice[_i])
	}
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}