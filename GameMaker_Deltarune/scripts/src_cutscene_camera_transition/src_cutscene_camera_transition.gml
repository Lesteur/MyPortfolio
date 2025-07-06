function cutscene_camera_transition(_name, _target) {
	
	function cutscene_alt_camera_transition(_name, _target) {
	
		var _nb
		switch _name {
			case "default":
				_nb = 0
				break
			case "battle":
				_nb = 1
				break
			case "bigplan":
				_nb = 2
				break
			default:
				_nb = 0
				break
		}
	
		var _inst = instance_create(0, 0, obj_camera_transition)
	
		with _inst {
			camera_target = _nb
			target = _target
		
			event_user(0)
		}
	
		step ++
	
		return _inst
	}
	
	if reset
		return -1
	
	array_push(cutscene, [cutscene_alt_camera_transition, [_name, _target]])
	return [array_length(cutscene) - 1]
}