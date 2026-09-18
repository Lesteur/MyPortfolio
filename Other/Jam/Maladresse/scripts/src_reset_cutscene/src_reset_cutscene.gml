/// @function								reset_cutscene(_vaiable)
/// @description							Reset the cutscene. It is used for the branches of the cutscene.
/// @param {Any}	 variable				The variable to add.
/// @self									obj_cutscene

function reset_cutscene(_variable)
{
	array_push(variables, _variable)
	wait = false
	reset = true
	array_alt = []
	current_variable = 0
	script_execute_ext(func_cutscene, args)
	next_cutscene()
}