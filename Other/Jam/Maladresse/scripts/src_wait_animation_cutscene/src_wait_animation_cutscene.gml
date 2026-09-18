/// @function							cutscene_wait_animation(obj)
/// @description						Make wait for an animation to finish.
/// @param	{Id.Instance}	obj			The object to wait.
/// @self								obj_cutscene

function cutscene_wait_animation(_obj, _stop = true)
{
	var _f = function(_obj, _stop = true)
	{
		wait = true
		
		if _obj.image_index >= _obj.image_number - 1
		{
			wait = false
			
			if _stop
			{
				with _obj
				{
					image_speed = 0
					image_index = image_number - 1
				}
			}
			
			next_cutscene()
			
			return 0
		}
	
		return -1
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_obj, _stop])
}