/// @function													cutscene_create_object(x, y, obj)
/// @description												Create a new object
/// @param {Real}									x			The x position.
/// @param {Real}									y			The y position.
/// @param {Asset.GMObject}							obj			The object index.
/// @self														obj_cutscene


function cutscene_create_object(_x, _y, _obj)
{
	var _f = function(_x, _y, _obj)
	{
		var _inst = instance_create_layer(_x, _y, "Instances_general", _obj)
		
		next_cutscene()
	
		return _inst
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [ _x, _y, _obj])
	return [count - 1]
}