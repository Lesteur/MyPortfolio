if setup {

	width_begin += width_l
	height_begin += height_l
	
	x_begin += x_l
	y_begin += y_l

	camera_set_view_size(camera_transition, width_begin, height_begin)
	camera_set_view_pos(camera_transition, x_begin, y_begin)

	count --

	if count <= 0 {
		
		view_visible[7] = false
		view_visible[camera_target] = true
		camera_set_view_target(view_camera[camera_target], target)
		
		global.current_view = camera_target
	
		camera_destroy(camera_transition)
		instance_destroy()
	}

}