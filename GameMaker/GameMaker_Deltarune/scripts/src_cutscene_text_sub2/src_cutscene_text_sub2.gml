function cutscene_text_sub2(_txt, _face = noone, _text_end = true) {
	
	// Function
	function cutscene_alt_text_sub2(_txt, _face = noone) {
	
		var _inst
		if !instance_exists(obj_textbox)
			_inst = textbox_create()
		else
			_inst = instance_find(obj_textbox, 0)
	
		textbox_add_sub2(_txt, _face)
		step ++
	
		return 0
	}
	
	if reset
		return -1
	
	var _length = array_length(cutscene)
	if _length != 0 && cutscene[_length - 1][0] == cutscene_alt_wait_message {
		array_pop(cutscene)
	}
	
	array_push(cutscene, [cutscene_alt_text_sub2, [_txt, _face]])
	if _text_end
		array_push(cutscene, [cutscene_alt_wait_message, []])
}