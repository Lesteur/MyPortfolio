depth = -bbox_bottom

#region Control Player

if global.can_move {

	var _right_key = keyboard_check(global._vk_right)
	var _left_key = keyboard_check(global._vk_left)
	var _up_key = keyboard_check(global._vk_up)
	var _down_key = keyboard_check(global._vk_down)
	var _total = _right_key + _left_key + _up_key + _down_key
	
	var _direct = -1
	
	if _right_key && _total == 1
		_direct = 0//sprite_index = spr_right
	else if _left_key && _total == 1
		_direct = 1//sprite_index = spr_left
	else if _down_key && _total == 1
		_direct = 2//sprite_index = spr_down
	else if _up_key && _total == 1
		_direct = 3//sprite_index = spr_up
	
	//Movement

	var _xspd = (_right_key - _left_key) * move_spd
	var _yspd = (_down_key - _up_key) * move_spd
	
	//Collision
	
	if place_meeting(x + _xspd, y, obj_wall)
		_xspd = 0
	
	if place_meeting(x, y + _yspd, obj_wall)
		_yspd = 0
	
	//Animate
	
	if _xspd > 0 && _yspd == 0
		_direct = 0//sprite_index = spr_right
	else if _xspd < 0 && _yspd == 0
		_direct = 1//sprite_index = spr_left
	else if _yspd > 0 && _xspd == 0
		_direct = 2//sprite_index = spr_down
	else if _yspd < 0 && _xspd == 0
		_direct = 3//sprite_index = spr_up
	
	switch _direct {
		case 0:
			sprite_index = spr_right
			break
		case 1:
			sprite_index = spr_left
			break
		case 2:
			sprite_index = spr_down
			break
		case 3:
			sprite_index = spr_up
			break
	}
	
	x += _xspd
	y += _yspd
	
	if (_xspd != 0 || _yspd != 0) {
		
		if image_speed == 0
			image_index = 1
		
		image_speed = 1
		
		ds_queue_enqueue(following_queue, [_xspd, _yspd, "walk", _direct])
		
	} else {
		image_speed = 0
		image_index = 0
	}
	
} else {
	image_speed = 0
	image_index = 0
	image_move = 0
}

#endregion

if path_position == 1 {
	path_end()
	path_delete(path)
	path = -1
	path_position = 0
}