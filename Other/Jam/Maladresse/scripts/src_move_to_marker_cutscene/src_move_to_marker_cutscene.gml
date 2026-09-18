/// @function													cutscene_move_to_marker(actor, marker, time, x, y)
/// @description												Make slide a character to another position.
/// @param {Id.Instance}							actor		The object to move.
/// @param {Id.Instance}							marker		The object where to go.
/// @param {Real}									time		The time for the shift.
/// @param {Real}									x			The x-decalage.
/// @param {Real}									y			The y-decalage.
/// @return {Any}
/// @self														obj_cutscene

function cutscene_move_to_marker(_actor, _marker, _time, _x = 0, _y = 0)
{
	var _f = function(_actor, _marker, _time, _x = 0, _y = 0)
	{
		if is_array(_actor)
			_actor = array_alt[_actor[0]]
		
		var _x1 = _actor.x
		var _y1 = _actor.y
		
		var _x2 = _marker.x + _x
		var _y2 = _marker.y + _y
		
		var _inst = instance_create_depth(_x2, _y2, depth, obj_cutscene_move)
		
		with _inst
		{
			actor = _actor
			time = _time
			event_user(0)
		}
		
		next_cutscene()
	
		return _inst
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_actor, _marker, _time, _x, _y])
	return [count - 1]
}