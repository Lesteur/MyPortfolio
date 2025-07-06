function cutscene_camera(_name, _target) {
	
	function cutscene_alt_camera(_name, _target) {
	
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
	
		with obj_camera {
			view_visible[global.current_view] = false
			view_visible[_nb] = true
			global.current_view = _nb
		
			camera_set_view_target(view_camera[_nb], _target)
		}
	
		step ++
	
		return 0
	}
	
	if reset
		return -1
	
	array_push(cutscene, [cutscene_alt_camera, [_name, _target]])
}