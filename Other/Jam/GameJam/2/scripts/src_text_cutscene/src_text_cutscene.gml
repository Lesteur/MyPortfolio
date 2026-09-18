/// @function													cutscene_text(text)
/// @description												Make appear a text in a cutscene
/// @param {String}							text				The text to show.
/// @return {Any}
/// @self														obj_cutscene

function cutscene_text(_text)
{
	var _f = function(_text)
	{
		var _inst
		
		if !instance_exists(obj_text)
			_inst = instance_create_depth(0, 0, depth, obj_text)
		else
			_inst = instance_find(obj_text, 0)
		
		with _inst
		{
			base_text = _text
			
			event_user(0)
		}
		
		next_cutscene()
	
		return _inst
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_text])
	return [count - 1]
}