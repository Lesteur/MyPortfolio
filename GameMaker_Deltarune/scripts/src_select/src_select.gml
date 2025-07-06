function select(_variable, _number, _horizontal = true) {
	
	var _key1, _key2
	if _horizontal {
		_key1 = global._vk_left
		_key2 = global._vk_right
	} else {
		_key1 = global._vk_up
		_key2 = global._vk_down
	}
	
	if keyboard_check_pressed(_key1) {
		_variable --
		
		if _variable < 0
			_variable = _number
	} else if keyboard_check_pressed(_key2) {
		_variable ++
		
		if _variable > _number
			_variable = 0
	}
	
	return _variable
}