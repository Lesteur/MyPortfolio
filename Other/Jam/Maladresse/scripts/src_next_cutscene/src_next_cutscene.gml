/// @function		next_cutscene()
/// @description	Pass the next command of the cutscene
/// @self			obj_cutscene

function next_cutscene()
{
	count --
	return ds_queue_dequeue(cutscene)
}