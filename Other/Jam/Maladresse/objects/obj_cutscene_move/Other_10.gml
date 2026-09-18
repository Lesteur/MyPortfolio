/// @description Create Path

var _x1 = actor.x
var _y1 = actor.y
		
var _path = path_add()
path_set_closed(_path, false)
path_add_point(_path, _x1, _y1, 100)
path_add_point(_path, x, y, 100)

var _xx = x - _x1
var _yy = y - _y1

if sprite
{
	var _direction
	if abs(_xx) > abs(_yy)
	{
		if _xx > 0
			_direction = DIRECTIONS.RIGHT
		else
			_direction = DIRECTIONS.LEFT
	} else {
		if _yy > 0
			_direction = DIRECTIONS.DOWN
		else
			_direction = DIRECTIONS.UP
	}
	
	with actor
	{
		current_direction = _direction
		current_state = STATES_PLAYER.WALK
		
		sprite_index = sprites_collection[? (_direction * 3) + STATES_PLAYER.WALK]
		image_speed = 1
	}
}

var _path_length = path_get_length(_path)
var _speed = _path_length / (time * FPS)

with actor
{
	path = _path
	path_start(path, _speed, path_action_stop, 1)
}

setup = true