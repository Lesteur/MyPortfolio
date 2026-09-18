/// @function							select_choice(variable, nb, vertical, incr)
/// @description						Allow to make a selection among many options
/// @param	{Real}		variable		The variable to handle.
/// @param	{Real}		nb				The distance in pixels between lines of text.
/// @param	{Bool}		vertical		If we have to use vertical commands or not.
/// @param	{Real}		incr			The increase between each move.


function set_effect_affinity(_)
{
	var _side1
	var _side2
	
	if _vertical
	{
		_side1 = INPUT.UP
		_side2 = INPUT.DOWN
	} else {
		_side1 = INPUT.LEFT
		_side2 = INPUT.RIGHT
	}
	
	if input_check_pressed(_side1)
	{
		_variable -= _incr
		
		if _variable < 0
			_variable = _nb - 1
		
	} else if input_check_pressed(_side2) {
		_variable += _incr
		
		if _variable >= _nb
			_variable = 0
	}
	
	return _variable
}