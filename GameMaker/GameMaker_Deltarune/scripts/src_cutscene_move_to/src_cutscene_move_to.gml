function cutscene_move_to(_actor, _x, _y, _relative, _time, _facing, _after) {
	
	function cutscene_alt_move_to(_actor, _x2, _y2, _relative, _time, _facing, _after) {
	
		var _x1 = _actor.x
		var _y1 = _actor.y
		
		if _relative {
			_x2 += _x1
			_y2 += _y1
		}
	
		var _inst = instance_create(_x2, _y2, obj_cutscene_move)
	
		with _inst {
			actor = _actor
			time = _time
			facing = _facing
			after = _after
		
			event_user(0)
		}
		
		step ++
	
		return _inst
	}
	
	if reset
		return -1
	
	array_push(cutscene, [cutscene_alt_move_to, [_actor, _x, _y, _relative, _time, _facing, _after]])
	return [array_length(cutscene) - 1]
}