function textbox_create() {
	var _inst
	
	if !instance_exists(obj_textbox)
		_inst = instance_create_depth(0, 0, 0, obj_textbox)
	
	if launcher.y > camera_get_view_y(view_camera[global.current_view]) + (camera_get_view_height(view_camera[global.current_view]))/2
		_inst.position_y = 4
	
	return _inst
}

function textbox_add(_txt, _face = noone) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst {
		
		array_push(array, _txt)
		array_push(array_speaker_sprite, _face)
		array_push(array_text_sound, current_voice)
		
		var _a = string_get_misc(_txt)
		var _str = _a[0]
		var _misc = _a[1]
	
		//Get the x position for the textbox when there is no character portrait
		var _offset_x = 0
		if (_face != noone)
			_offset_x = 45 + border_text_x
	
		array_push(array_text_x_offset, _offset_x)
		array_push(array_text, string_wrap(_str, line_width - _offset_x , _misc, true))
		array_push(array_text_misc, _misc)
		array_push(array_text_length, string_length(_str))
	
		array_push(array_sub1, 0)
		array_push(array_speaker_sprite_sub1, noone)
		array_push(array_text_x_offset_sub1, 0)
		array_push(array_text_misc_sub1, [])
		
		array_push(array_sub2, 0)
		array_push(array_speaker_sprite_sub2, noone)
		array_push(array_text_x_offset_sub2, 0)
		array_push(array_text_misc_sub2, [])
		
		array_push(array_sub3, 0)
		array_push(array_speaker_sprite_sub3, noone)
		array_push(array_text_x_offset_sub3, 0)
		array_push(array_text_misc_sub3, [])
		
		page_number = array_length(array)
		
		setup = true
	}
}

function textbox_add_sub1(_txt, _face) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst {
		
		var _length = array_length(array_sub1) - 1
		array_sub1[_length] = _txt
		array_speaker_sprite_sub1[_length] = _face
		
		var _str = 0
		var _misc = []
		if _txt != 0 {
			
			var _a = string_get_misc("{mini}{transalpha}" + _txt)
			_str = _a[0]
			_misc = _a[1]
			
			if (_face != noone)
				_offset_x = (45 + border_text_x)/2
		
		}
		
		array_text_x_offset_sub1[_length] = _offset_x
		array_text_sub1[_length] = _str
		array_text_misc_sub1[_length] = _misc
		
		setup = true
	}
}

function textbox_pos_sub1(_x, _y) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst {
		sub_x1 = _x
		sub_y1 = _y
	}
}

function textbox_add_sub2(_txt, _face) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst {
		
		var _length = array_length(array_sub2) - 1
		array_sub2[_length] = _txt
		array_speaker_sprite_sub2[_length] = _face
		
		var _str = 0
		var _misc = []
		if _txt != 0 {
			
			var _a = string_get_misc("{mini}{transalpha}" + _txt)
			_str = _a[0]
			_misc = _a[1]
			
			if (_face != noone)
				_offset_x = (45 + border_text_x)/2
		
		}
		
		array_push(array_text_x_offset_sub2, _offset_x)
		array_push(array_text_sub2, _str)
		array_push(array_text_misc_sub2, _misc)
		
		setup = true
	}
}

function textbox_pos_sub2(_x, _y) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst {
		sub_x2 = _x
		sub_y2 = _y
	}
}

function textbox_add_sub3(_txt, _face) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst {
		
		var _length = array_length(array_sub3) - 1
		array_sub3[_length] = _txt
		array_speaker_sprite_sub3[_length] = _face
		
		var _str = 0
		var _misc = []
		if _txt != 0 {
			
			var _a = string_get_misc("{mini}{transalpha}" + _txt)
			_str = _a[0]
			_misc = _a[1]
			
			if (_face != noone)
				_offset_x = (45 + border_text_x)/2
		
		}
		
		array_push(array_text_x_offset_sub3, _offset_x)
		array_push(array_text_sub3, _str)
		array_push(array_text_misc_sub3, _misc)
		
		setup = true
	}
}

function textbox_pos_sub3(_x, _y) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst {
		sub_x3 = _x
		sub_y3 = _y
	}
}

function textbox_voice(_voice) {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst
		current_voice = _voice
}

function textbox_start() {
	var _inst = instance_find(obj_textbox, 0)
	
	with _inst
		event_user(0)
	
	return _inst
}