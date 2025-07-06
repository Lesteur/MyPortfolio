if (place_meeting(x, y, obj_kris) && !contact) {
	contact = true
	obj_kris.can_move = false
	var _transition = instance_create_depth(0, 0, -9999, obj_transition)
	_transition.target_x = target_x
	_transition.target_y = target_y
	_transition.target_rm = target_rm
}