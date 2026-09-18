/// @function				input_check_released(action)
/// @description			Check if an input has been released or not.
/// @param  {Real}	action	Input to check.
/// @self					obj_player

function input_check_released(_action)
{
    var _mapping = global.input_map[? _action]
	var _input_keyboard
	var _input_gamepad
	var _input_stick
			
	if global.gamepad_control
	{
		//Check the gamepad
		_input_keyboard = false
		_input_gamepad = gamepad_button_check_released(global.gamepad_index, _mapping.gamepad)
		
		var _axis
		var _axe
		var _global
		switch _action
		{
			case INPUT.UP:
				_axis = gp_axislv
				_axe = false
				_global = 0
				break
			case INPUT.DOWN:
				_axis = gp_axislv
				_axe = true
				_global = 1
				break
			case INPUT.LEFT:
				_axis = gp_axislh
				_axe = false
				_global = 2
				break
			case INPUT.RIGHT:
				_axis = gp_axislh
				_axe = true
				_global = 3
				break
			default:
				_axis = -1
				break
		}
		
		if _axis != -1
		{
			var _input = gamepad_axis_value(global.gamepad_index, _axis)
			var _abs = abs(_input)
			var _positif = _input > 0
			
			_input_stick = (_abs > 0.3) && (_positif == _axe)
			
			if (global.axis_pressed[_global] == 0) && _input_stick
			{
				global.axis_pressed[_global] = 1
				_input_stick = false
			} else if (global.axis_pressed[_global] == 1) && _input_stick
				_input_stick = false
			else if (global.axis_pressed[_global] == 1) && !_input_stick
			{
				global.axis_pressed[_global] = 0
				_input_stick = true
			}
			
		} else {
			_input_stick = false
		}
		
	} else {
		//Check the keyboard
		_input_keyboard = keyboard_check_released(_mapping.key)
		_input_gamepad = false
		_input_stick = false
	}

    return _input_keyboard || _input_gamepad || _input_stick
}