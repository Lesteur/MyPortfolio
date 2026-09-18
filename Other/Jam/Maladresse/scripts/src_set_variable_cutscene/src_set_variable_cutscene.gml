/// @function													cutscene_set_variable(instance, variable, value)
/// @description												Set a variable up in a cutscene
/// @param {Id.Instance}					instance			The instance to check.
/// @param {String}							variable			The variable to change.
/// @param {Any}							value				The value to set.
/// @return {Any}
/// @self														obj_cutscene

function cutscene_set_variable(_instance, _variable, _value)
{
	var _f = function(_instance, _variable, _value)
	{
		if is_array(_instance)
			_instance = array_alt[_instance[0]]
		
		variable_instance_set(_instance, _variable, _value)
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_instance, _variable, _value])
}