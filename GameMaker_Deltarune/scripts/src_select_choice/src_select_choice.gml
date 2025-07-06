function select_choice(_variable, _max, _updown) {
	var _button1, _button2
	if _updown {
		_button1 = global._vk_up
		_button2 = global._vk_down
	} else {
		_button1 = global._vk_left
		_button2 = global._vk_right
	}
	var _press1 = keyboard_check_pressed(_button1)
	var _press2 = keyboard_check_pressed(_button2)
	
	if (_press1) {
		_variable --
		if _variable < 0
			_variable = _max - 1
	} else if (_press2) {
		_variable ++
		if _variable >= _max
			_variable = 0
	}
	
	return _variable
}