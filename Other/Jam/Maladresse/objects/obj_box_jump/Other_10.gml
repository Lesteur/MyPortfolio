/// @description Interaction Player

global.lock = true
lock = true
	
var _inst, _x, _y
	
_inst = instance_find(obj_player, 0)
_x = _inst.x
_y = _inst.y
	
var _x2, _y2
	
if place_meeting(x - 3, y, _inst) || place_meeting(x + 3, y, _inst)
{
	if _x < x
		_x2 = 40
	else
		_x2 = -40
		
	_y2 = 0
} else {
		
	if _y < y
		_y2 = 40
	else
		_y2 = -40
		
	_x2 = 0
}

create_cutscene(cutscene, [_inst, _x2, _y2])