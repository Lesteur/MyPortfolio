depth = -bbox_bottom

if (ds_queue_size(following.following_queue) > 12) {
	var _point = ds_queue_dequeue(following.following_queue)
	
	x += _point[0]
	y += _point[1]
	//player_state = _point[2]
	var _direct = _point[3]
	
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
	
	if image_speed == 0
		image_index = 1
	
	image_speed = 1
	
	ds_queue_enqueue(following_queue, _point)
} else {
	image_speed = 0
	image_index = 0
}