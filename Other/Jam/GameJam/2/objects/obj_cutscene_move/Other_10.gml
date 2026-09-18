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
		lock = true
		player_direction = _direction
		sprite_index = sprites_grid[# player_direction, STATES_PLAYER.WALK]
	}
}

var _path_length = path_get_length(_path)
var _speed = _path_length / (time * 60)
		
with actor
{
	path = _path
	path_start(path, _speed, path_action_stop, 1)
}

setup = true