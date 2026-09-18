/// @function													cutscene_move_to(actor, x, y, relative, time)
/// @description												Make slide a character to another position.
/// @param {Id.Instance}							actor		The object to move.
/// @param {Real}									x			The x-position to go.
/// @param {Real}									y			The y-position to go.
/// @param {Bool}									relative	If the position is relative.
/// @param {Real}									time		The time for the shift.
/// @return {Any}
/// @self														obj_cutscene

function cutscene_move_to(_actor, _x, _y, _relative, _time)
{
	var _f = function(_actor, _x2, _y2, _relative, _time)
	{
		var _x1 = _actor.x
		var _y1 = _actor.y
		
		if _relative
		{
			_x2 += _x1
			_y2 += _y1
		}
		
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
	
	add_cutscene(_f, [_actor, _x, _y, _relative, _time])
	return [count - 1]
}