with obj_camera {
	view_visible[global.current_view] = false
	view_visible[1] = true
	global.current_view = 1
		
	//camera_set_view_target(view_camera[_nb], _target)
}

if keyboard_check_pressed(vk_left)
	turn --
else if keyboard_check_pressed(vk_right)
	turn ++

turn = clamp(turn, 0, 2)