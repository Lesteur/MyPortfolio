/// @function								cutscene_destroy_object(obj)
/// @description							Destroy an object.
/// @param {Id.instance}	obj				The object to destroy.
/// @self					obj_cutscene


function cutscene_destroy_object(_obj)
{
	var _f = function(_obj)
	{
		if is_array(_obj)
			_obj = array_alt[_obj[0]]
		
		if instance_exists(_obj)
			instance_destroy(_obj)
		
		next_cutscene()
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_obj])
}