/// @description Setup

width_end = camera_get_view_width(view_camera[camera_target])
height_end = camera_get_view_height(view_camera[camera_target])

border_x_end = camera_get_view_border_x(view_camera[camera_target])
border_y_end = camera_get_view_border_y(view_camera[camera_target])

x_end = target.x - border_x_end
y_end = target.y - border_y_end

if camera_target == 2
	y_end -= 40

if x_end + width_end > room_width
	x_end = room_width - width_end
else if x_end < 0
	x_end = 0

if y_end + width_end > room_height
	y_end = room_height - height_end
else if y_end < 0
	y_end = 0

width_l = (width_end - width_begin)/count
height_l = (height_end - height_begin)/count

x_l = (x_end - x_begin)/count
y_l = (y_end - y_begin)/count

camera_transition = camera_create_view(x_begin, y_begin, width_begin, height_begin, 0, noone, 0, 0, border_x_begin, border_y_begin)

view_visible[global.current_view] = false

view_camera[7] = camera_transition
view_visible[7] = true
global.current_view = 7

setup = true