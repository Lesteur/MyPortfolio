/// @function													cutscene_set_sprite_scale(obj, x, y)
/// @description												Make change the scale of the object.
/// @param {Id.Instance}							obj			The object to change the sprite.
/// @param {Real}									x			The new xscale.
/// @param {Real}									y			The new yscale.
/// @self														obj_cutscene

function cutscene_set_sprite_scale(_obj, _x = 0, _y = 0)
{
	var _f = function(_obj, _x = 0, _y = 0)
	{
		if is_array(_obj)
			_obj = array_alt[_obj[0]]
		
		with _obj
		{
			if _x != 0
				image_xscale = _x
			
			if _y != 0
				image_yscale = _y
		}
	
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_obj, _x, _y])
}