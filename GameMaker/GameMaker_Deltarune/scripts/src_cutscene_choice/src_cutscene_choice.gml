function cutscene_alt_choice(_array, _number) {
	
	var _inst = instance_find(obj_textbox, 0)
	
	if _inst.nb_choice == 0 {
		
		if _inst.page != array_length(_inst.array) - 1 {
			wait = true
			return -1
		}
	
		with _inst {
		
			for (var _i = 0; _i < array_length(_array); _i++) {
				var _a = string_get_misc(_array[_i])
				var _str = _a[0]
				var _misc = _a[1]
			
				array_push(array_text_choice, _str)
				array_push(array_text_misc_choice, _misc)
			}
		
			nb_choice = array_length(_array)
			setup = false
			
		}
		
	} else {
		
		_inst = instance_find(obj_textbox, 0)
	
		if _inst.choice_final == -1 {
			wait = true
			return -1
		}
	
		wait = false
		current_answer = 0
		answers[_number] = _inst.choice_final
		global.answer = _inst.choice_final
	
		with _inst
			event_user(1)
		
		reset = true
		script_execute(func_cutscene)
		
		step ++
		
		return -1
	}
}

function cutscene_choice(_array) {
	if reset {
		var _answer = answers[current_answer]
		current_answer ++
		
		if current_answer == array_length(answers)
			reset = false
		
		return _answer
	} else {
		cutscene_text("",, false)
		array_push(cutscene, [cutscene_alt_choice, [_array, array_length(answers)]])
		array_push(answers, -1)
		reset = true
	
		return -1
	}
}