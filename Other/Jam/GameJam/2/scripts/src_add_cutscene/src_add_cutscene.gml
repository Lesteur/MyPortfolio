/// @function								add_cutscene(_command)
/// @description							Add a new command to the cutscene
/// @param {Function}	 f					The function to execute.
/// @param {Array<Any>}	 array_arguments	The array containing the arguments.
/// @self									obj_cutscene

function add_cutscene(_f, _array_arguments)
{
	ds_queue_enqueue(cutscene, [_f, _array_arguments])
	count ++
}