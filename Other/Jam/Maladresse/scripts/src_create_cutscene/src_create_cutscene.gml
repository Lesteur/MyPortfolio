/// @function						create_cutscene(function, free_player = true)
/// @description					Create a new cutscene.
/// @param {Function}	function	The function with the cutscene.
/// @param {Array}		array_args	The array containing the arguments.
/// @param {Bool}		free_player	If the player must be free at the end.
/// @return {Id.Instance}
/// @self							obj_cutscene

function create_cutscene(_function, _args = [], _free_player = true)
{
	var _inst = instance_create_depth(0, 0, 0, obj_cutscene)
	var _id = id
	
	with _inst
	{
		launcher = _id
		free_player = _free_player
		func_cutscene = _function
		args = _args
		
		script_execute_ext(func_cutscene, args)
	}
	
	return _inst
}