/// @function													cutscene_set_animation(obj, sprite)
/// @description												Make change the sprite of the object.
/// @param {Id.Instance}							obj			The object to change the sprite.
/// @param {Asset.GMSprite}							sprite		The sprite to assign.
/// @self														obj_cutscene

function cutscene_set_animation(_obj, _sprite, _image_speed = 1, _image_index = 0)
{
	var _f = function(_obj, _sprite, _image_speed = 1, _image_index = 0)
	{
		if is_array(_obj)
			_obj = array_alt[_obj[0]]
		
		with _obj
		{
			sprite_index = _sprite
			
			image_speed = _image_speed
			image_index = _image_index
		}
	
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_obj, _sprite, _image_speed, _image_index])
}