/// @function				change_floor(number)
/// @description			Change the player at collisions and depth.
/// @param  {Real}	number	Number of floors to climb or down.
/// @self					obj_player

function change_floor(_number)
{
	var _layer1 = get_current_floor_instance()
	
	global.floor += _number
	
	var _layer2 = get_current_floor_instance()
	
	var _l1 = global.objets_by_floor[? _layer1]
	var _n1 = array_length(_l1)
	
	var _l2 = global.objets_by_floor[? _layer2]
	var _n2 = array_length(_l2)
	
	var _min, _max
	if _n1 < _n2
	{
		_min = _n1
		_max = _n2
	} else {
		_min = _n2
		_max = _n1
	}
	
	for (var _i = 0; _i < _min; _i ++)
	{
		with _l1[_i] event_user(1)
		
		with _l2[_i] event_user(1)
	}
	
	for (var _i = _min; _i < _max; _i ++)
	{
		if _i < _n1
			with _l1[_i] event_user(1)
		
		if _i < _n2
			with _l2[_i] event_user(1)
	}
}