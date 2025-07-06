function cutscene_text(_txt, _face = noone, _text_end = true, _destroy = true) {
	
	// Function
	function cutscene_alt_text(_txt, _face = noone, _destroy = true) {
	
		var _inst
		if !instance_exists(obj_textbox)
			_inst = textbox_create()
		else
			_inst = instance_find(obj_textbox, 0)
	
		with _inst {
			if text_end
				event_user(1)
		
			destroy = _destroy
		}
	
		textbox_add(_txt, _face)
		step ++
	}
	
	if reset
		return -1
	
	var _length = array_length(cutscene)
	if _length != 0 && cutscene[_length - 1][0] == cutscene_alt_wait_message {
		array_pop(cutscene)
	}
	
	array_push(cutscene, [cutscene_alt_text, [_txt, _face, _destroy]])
	if _text_end
		array_push(cutscene, [cutscene_alt_wait_message, []])
}