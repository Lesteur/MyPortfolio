function create_cutscene(_function, _free_player = true) {
	var _inst = instance_create_depth(0, 0, 0, obj_cutscene)
	_inst.launcher = id
	_inst.free_player = _free_player
	_inst.func_cutscene = _function
	
	with _inst
		script_execute(_function)
}