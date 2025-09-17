function cutscene_set_camera_target(_target) {
	
	function cutscene_alt_set_target(_target) {
	
		camera_set_view_target(view_camera[global.current_view], _target)
		step ++
	
		return 0
	}
	
	if reset
		return -1
	
	array_push(cutscene, [cutscene_alt_set_target, [_target]])
}