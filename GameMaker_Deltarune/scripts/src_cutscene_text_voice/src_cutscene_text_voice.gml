function cutscene_text_voice(_voice) {
	
	function cutscene_alt_text_voice(_voice) {
	
		var _inst
		if !instance_exists(obj_textbox)
			_inst = textbox_create()
		else
			_inst = instance_find(obj_textbox, 0)
	
		textbox_voice(_voice)
		step ++
	
		return 0
	}
	
	if reset
		return -1
		
	array_push(cutscene, [cutscene_alt_text_voice, [_voice]])
}