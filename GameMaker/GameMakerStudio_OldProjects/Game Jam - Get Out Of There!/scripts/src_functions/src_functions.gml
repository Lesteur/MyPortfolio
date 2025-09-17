function move()
{
	var _right = keyboard_check(vk_right)
	var _left = keyboard_check(vk_left)
	var _up = keyboard_check(vk_up)
	var _down = keyboard_check(vk_down)
	
	var _move_h = 0
	var _move_v = 0
	
	var _collision1 = place_meeting(x + 3, y, obj_collision)
	var _collision2 = place_meeting(x - 3, y, obj_collision)
	var _collision3 = place_meeting(x, y - 3, obj_collision)
	var _collision4 = place_meeting(x, y + 3, obj_collision)
	
	if (!_collision1 && _right) || (!_collision2 && _left)
		_move_h = _right - _left

	x += _move_h
	
	if (!_collision3 && _up) || (!_collision4 && _down)
		_move_v = _down - _up

	y += _move_v

	var _move = abs(_move_h) + abs(_move_v)

	if _left
		sprite_index = spr_pock_left
	else if _right
		sprite_index = spr_pock_right
	else if _up
		sprite_index = spr_pock_up
	else if _down
		sprite_index = spr_pock_down

	if _move {
		image_speed = 1
	} else {
		image_speed = 0
		image_index = 0
	}
}

function interaction()
{
	var _player = obj_pock
	if ((place_meeting(x + 3, y, _player) && _player.sprite_index == spr_pock_left)
	||  (place_meeting(x - 3, y, _player) && _player.sprite_index == spr_pock_right)
	||  (place_meeting(x, y + 3, _player) && _player.sprite_index == spr_pock_up)
	||  (place_meeting(x, y - 3, _player) && _player.sprite_index == spr_pock_down))
	&& count == 0
	&& keyboard_check_pressed(vk_space) {
		global.lock = 1
		interact = 1
		count ++
	}
}