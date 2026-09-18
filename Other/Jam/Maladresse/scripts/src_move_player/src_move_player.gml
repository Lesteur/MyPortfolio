/// @function		move_player()
/// @description	Allow the player to move the character in control.
/// @self			obj_player

function move_player()
{
	// Get Input Player
	var _up = input_check(INPUT.UP)
	var _down = input_check(INPUT.DOWN)
	var _left = input_check(INPUT.LEFT)
	var _right = input_check(INPUT.RIGHT)
	
	var _run = input_check(INPUT.BACK) || global.autorun

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
	switch (current_locate)
	{
		// On the ground
		case STATES_WORLD.GROUND:
			if _downleft
				current_direction = DIRECTIONS.DOWNLEFT
			else if _downright
				current_direction = DIRECTIONS.DOWNRIGHT
			else if _upleft
				current_direction = DIRECTIONS.UPLEFT
			else if _upright
				current_direction = DIRECTIONS.UPRIGHT
			else if _down
				current_direction = DIRECTIONS.DOWN
			else if _up
				current_direction = DIRECTIONS.UP
			else if _right
				current_direction = DIRECTIONS.RIGHT
			else if _left
				current_direction = DIRECTIONS.LEFT

			if _run && _move
				current_state = STATES_PLAYER.RUN
			else if _move
				current_state = STATES_PLAYER.WALK
			else
				current_state = STATES_PLAYER.IDLE
			
			current_sprite = (current_direction * 3) + current_state
			
			break
		// If climbing a wall
		case STATES_WORLD.WALL:
			if _up
				current_direction = DIRECTIONS.UP
			else if _down
				current_direction = DIRECTIONS.DOWN
			
			if _move
				current_state = STATES_PLAYER.WALK
			else
				current_state = STATES_PLAYER.IDLE
			
			break
	}

	// Finally, make move the player
	x += _hsp
	y += _vsp
	
	// Add coordinates for the followers
	if _move
		ds_queue_enqueue(following_queue, [_hsp, _vsp, current_state, current_direction])
	else {
		// Check interaction with an event
		if input_check_pressed(INPUT.CONFIRM)
		{
			var _event = noone
			
			switch current_direction
			{
				case DIRECTIONS.LEFT:
					_event = instance_place(x - 3, y, obj_event)
					break
				case DIRECTIONS.RIGHT:
					_event = instance_place(x + 3, y, obj_event)
					break
				case DIRECTIONS.UP:
					_event = instance_place(x, y - 3, obj_event)
					break
				case DIRECTIONS.DOWN:
					_event = instance_place(x, y + 3, obj_event)
					break
			}
			
			if _event != noone && _event.current_floor == current_floor
			{
				with _event
					event_user(0)
			}
		}
	}
}