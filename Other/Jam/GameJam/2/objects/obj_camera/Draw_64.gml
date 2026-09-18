/// @description Black Screen

if black
	draw_rectangle_color(0, 0, width, height, c_black, c_black, c_black, c_black, false)
	
	show_debug_message(view_current)
	
	var _cam = view_camera[view_current]
	show_debug_message(camera_get_view_width(_cam))
//show_debug_message(window_get_width())
//show_debug_message(window_get_height())