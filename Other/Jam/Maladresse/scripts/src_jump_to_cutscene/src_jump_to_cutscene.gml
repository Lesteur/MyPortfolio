/// @function													cutscene_jump_to(actor, x, y, relative, time)
/// @description												Make jump a character to another position.
/// @param {Id.Instance OR Asset.GMObject}			actor		The object to move.
/// @param {Real}									x			The x-position to go.
/// @param {Real}									y			The y-position to go.
/// @param {Bool}									relative	If the position is relative.
/// @param {Real}									time		The time for the shift.
/// @return {Any}
/// @self														obj_cutscene

function cutscene_jump_to(_actor, _x, _y, _relative, _time)
{
	var _f = function(_actor, _x2, _y2, _relative, _time)
	{
		if is_array(_actor)
			_actor = array_alt[_actor[0]]
		
		var _make_jump = function(_x1, _y1, _x2, _y2, _spd = 100)
		{
			var _path = path_add()
			
			path_set_kind(_path, true)
			path_set_closed(_path, false)
			
			path_add_point(_path, _x1, _y1, _spd)
			path_add_point(_path, (_x2 + _x1)/2, _y2 - 15, _spd)
			path_add_point(_path, _x2, _y2, _spd)
			
			return _path
		}
		
		var _x1 = _actor.x
		var _y1 = _actor.y
		
		if _relative
		{
			_x2 += _x1
			_y2 += _y1
		}
		
		var _path = _make_jump(_x1, _y1, _x2, _y2)
		
		var _inst = instance_create_depth(_x2, _y2, depth, obj_cutscene_move)
		
		with _inst
		{
			actor = _actor
			actor.path = _path
			time = _time
			
			setup = true
		}
		
		with _actor
			path_start(path, 3, path_action_stop, 1)
		
		next_cutscene()
	
		return _inst
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_actor, _x, _y, _relative, _time])
	return [count - 1]
}