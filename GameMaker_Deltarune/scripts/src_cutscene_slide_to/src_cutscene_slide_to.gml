function cutscene_slide_to(_actor, _x, _y, _relative, _time) {
	
	function cutscene_alt_slide_to(_actor, _x2, _y2, _relative, _time) {
	
		var _x1 = _actor.x
		var _y1 = _actor.y
		
		if _relative {
			_x2 += _x1
			_y2 += _y1
		}
		
		var _inst = instance_create(_x2, _y2, obj_cutscene_move)
		_inst.actor = _actor
		_inst.time = _time
		
		with _inst
			event_user(0)
		
		step ++
	
		return _inst
	}
	
	if reset
		return -1
	
	array_push(cutscene, [cutscene_alt_slide_to, [_actor, _x, _y, _relative, _time]])
	return [array_length(cutscene) - 1]
}