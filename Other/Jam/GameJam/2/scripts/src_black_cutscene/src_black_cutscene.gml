function cutscene_black(_bool)
{
	var _f = function(_bool)
	{
		obj_manager.black = _bool
		
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_bool])
}