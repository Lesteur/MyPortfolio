/// @description Execute scene one by one

if (step < array_length(cutscene)) {
	
	do {
		
		current_action = cutscene[step]
		var _act = script_execute_ext(current_action[0], current_action[1])
		
		if _act != -1
			array_push(array_alt, _act)
		
	} until wait || step >= array_length(cutscene)
	
} else {
	instance_destroy()
}