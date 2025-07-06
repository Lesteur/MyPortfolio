/// @description Insert description here
// You can write your code in this editor

var _x1 = actor.x
var _y1 = actor.y
		
var _pth = path_add()
path_set_closed(_pth, false)
path_add_point(_pth, _x1, _y1, 100)
path_add_point(_pth, x, y, 100)
		
actor.path = _pth
		
with actor
	path_start(_pth, 3, path_action_stop, 1)

go = true