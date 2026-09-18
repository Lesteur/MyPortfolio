/// @function													cutscene_custom(f, array)
/// @description												Use a custom function in the cutscene.
/// @param {Function}								f			The function to use.
/// @param {Array}									array		The array containing the arguments.
/// @self														obj_cutscene

function cutscene_custom(_f, _array = [])
{
	if reset
		return -1
	
	add_cutscene(_f, [_array])
	return [count - 1]
}