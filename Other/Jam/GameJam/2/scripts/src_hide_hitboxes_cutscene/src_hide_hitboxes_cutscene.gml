function hide_hitboxes_cutscene(_bool)
{
	var _count = instance_number(obj_box_collision)
	
	if _bool == true
	{
		for (var _i = 0; _i < _count; _i ++)
		{
			var _inst = instance_find(obj_box_collision, _i)
			_inst.x = -1
			_inst.y = -1
		}
		
	} else {
		for (var _i = 0; _i < _count; _i ++)
		{
			var _inst = instance_find(obj_box_collision, _i)
			_inst.x = _inst.x_real
			_inst.y = _inst.y_real
		}
	}
}