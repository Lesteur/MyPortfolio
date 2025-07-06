/// @description Setup

page = 0
page_number = array_length(array)

for (var _i = 0; _i < array_length(array); _i++) {
	var _a = string_get_misc(array[_i])
	var _str = _a[0]
	var _misc = _a[1]
	
	//Get the x position for the textbox when there is no character portrait
	var _offset_x = 0
	if (array_length(array_speaker_sprite) > _i && array_speaker_sprite[_i] != noone)
		_offset_x = 45 + border_text_x
	
	array_push(array_text_x_offset, _offset_x)
	array_push(array_text, string_wrap(_str, line_width - _offset_x , _misc, true))
	array_push(array_text_misc, _misc)
	array_push(array_text_length, string_length(_str))
	
	if (array_length(array_sub1) > _i) {
		_str = 0
		_offset_x = 0
		_misc = []
		
		if array_sub1[_i] != 0 {
			
			_a = string_get_misc("{mini}{transalpha}" + array_sub1[_i])
			_str = _a[0]
			_misc = _a[1]
			
			if (array_speaker_sprite_sub1[_i] != noone)
				_offset_x = (45 + border_text_x)/2
		
		}
		
		array_push(array_text_x_offset_sub1, _offset_x)
		array_push(array_text_sub1, _str)
		array_push(array_text_misc_sub1, _misc)
	}
	
	if (array_length(array_sub2) > _i) {
		_str = 0
		_offset_x = 0
		_misc = []
		
		if array_sub2[_i] != 0 {
			
			_a = string_get_misc("{mini}{transalpha}" + array_sub2[_i])
			_str = _a[0]
			_misc = _a[1]
			
			if (array_speaker_sprite_sub2[_i] != noone)
				_offset_x = (45 + border_text_x)/2
		
		}
		
		array_push(array_text_x_offset_sub2, _offset_x)
		array_push(array_text_sub2, _str)
		array_push(array_text_misc_sub2, _misc)
	}
	
	if (array_length(array_sub3) > _i) {
		_str = 0
		_offset_x = 0
		_misc = []
		
		if array_sub3[_i] != 0 {
			
			_a = string_get_misc("{mini}{transalpha}" + array_sub3[_i])
			_str = _a[0]
			_misc = _a[1]
			
			if (array_speaker_sprite_sub3[_i] != noone)
				_offset_x = (45 + border_text_x)/2
		
		}
		
		array_push(array_text_x_offset_sub3, _offset_x)
		array_push(array_text_sub3, _str)
		array_push(array_text_misc_sub3, _misc)
	}
}

setup = true