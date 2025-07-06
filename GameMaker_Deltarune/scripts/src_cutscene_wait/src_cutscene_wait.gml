function cutscene_wait(_command) {
	
	function cutscene_alt_wait(_command) {
	
		wait = true
	
		if !instance_exists(array_alt[_command[0]]) && !audio_exists(array_alt[_command[0]]) {
			wait = false
			step ++
			return 0
		}
	
		return -1
	}

	function cutscene_alt_wait_sec(_sec) {
	
		wait = true
		if sec >= _sec {
			sec = 0
			wait = false
			step ++
			return 0
		} else {
			sec ++
		}
	
		return -1
	}
	
	if reset
		return -1
	
	if is_real(_command)
		array_push(cutscene, [cutscene_alt_wait_sec, [_command * game_get_speed(gamespeed_fps)]])
	else
		array_push(cutscene, [cutscene_alt_wait, [_command]])
}

function cutscene_alt_wait_message() {
	
	wait = true
	if (!instance_exists(obj_textbox) || obj_textbox.text_end) {
		wait = false
		step ++
		return 0
	}
	
	return -1
}

function cutscene_wait_message() {

	array_push(cutscene, [cutscene_alt_wait_message, []])
}