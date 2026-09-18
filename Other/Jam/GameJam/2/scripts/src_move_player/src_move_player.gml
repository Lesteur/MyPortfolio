/// @function		move_player()
/// @description	Allow the player to move the character in control.
/// @self			obj_player

function move_player()
{
	// Get Input Player
	var _down = get_input_check(INPUT.DOWN)
	var _up = get_input_check(INPUT.UP)
	var _right = get_input_check(INPUT.RIGHT)
	var _left = get_input_check(INPUT.LEFT)
	var _run = get_input_check(INPUT.BACK) || global.autorun

	// Calcule Directions
	var _downleft = _down && _left
	var _downright = _down && _right
	var _upleft = _up && _left
	var _upright = _up && _right

	// Calculate movements according to collisions
	var _move, _layer_player, _layer_collision, _bbox_side, _collision1, _collision2
	var _hsp = 0
	var _vsp = 0
	
	var _move_h = _right - _left
	
	if _move_h != 0
	{
		if (_move_h > 0) _bbox_side = bbox_right else _bbox_side = bbox_left
		
		_collision1 = place_meeting(x + _move_h * 3, y, obj_box_collision) || tilemap_get_at_pixel(tilemap_collision, _bbox_side + _move_h * 3, bbox_top) || tilemap_get_at_pixel(tilemap_collision, _bbox_side + _move_h * 3, bbox_bottom)
		
		_hsp = _move_h * (1 + _run) * !_collision1
	}
	
	
	var _move_v = _down - _up
	
	if _move_v != 0
	{
		if (_move_v > 0) _bbox_side = bbox_bottom else _bbox_side = bbox_top
		
		_collision2 = place_meeting(x, y + _move_v * 3, obj_box_collision) || tilemap_get_at_pixel(tilemap_collision, bbox_left, _bbox_side + _move_v * 3) || tilemap_get_at_pixel(tilemap_collision, bbox_right, _bbox_side + _move_v * 3)
		
		_vsp = _move_v * (1 + _run) * !_collision2
	}

	_move = abs(_hsp) + abs(_vsp)
	
	// Get Player Direction
	switch (locate)
	{
		// On the ground
		case STATES_WORLD.GROUND:
			if _downleft
				player_direction = DIRECTIONS.DOWNLEFT
			else if _downright
				player_direction = DIRECTIONS.DOWNRIGHT
			else if _upleft
				player_direction = DIRECTIONS.UPLEFT
			else if _upright
				player_direction = DIRECTIONS.UPRIGHT
			else if _down
				player_direction = DIRECTIONS.DOWN
			else if _up
				player_direction = DIRECTIONS.UP
			else if _right
				player_direction = DIRECTIONS.RIGHT
			else if _left
				player_direction = DIRECTIONS.LEFT

			if _run && _move
				player_state = STATES_PLAYER.RUN
			else if _move
				player_state = STATES_PLAYER.WALK
			else
				player_state = STATES_PLAYER.IDLE
			break
		// If climbing a wall
		case STATES_WORLD.WALL:
			if _up
				player_direction = DIRECTIONS.UP
			else if _down
				player_direction = DIRECTIONS.DOWN
			
			if _move
				player_state = STATES_PLAYER.WALK
			else
				player_state = STATES_PLAYER.IDLE
			break
	}

	// Finally, make move the player
	x += _hsp
	y += _vsp
	
	// Check interaction with an event
	var _event = instance_place(x, y, obj_event)
	
	if _event != noone
	{
		with _event
			event_user(0)
	}
}