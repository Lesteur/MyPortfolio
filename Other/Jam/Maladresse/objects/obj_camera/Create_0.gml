/// @description Init

x = 0
y = 0

width = 640
height = 360

scale_window = 2
angle = 0
target = obj_player

camera_default = camera_create_view(x, y, width, height, angle, target, -1, -1, width/2, height/2)
camera_battle = camera_create_view(x, y, width * 2, height * 2, angle, target, -1, -1, width, height)
camera_bigplan = camera_create_view(x, y, width/4, height/4, angle, target, -1, -1, width/8, height/8)

window_set_size( width * scale_window, height * scale_window )
display_set_gui_size(width, height)
window_center()

view_enabled = true

view_camera[0] = camera_default
view_camera[1] = camera_battle
view_camera[2] = camera_bigplan

view_visible[global.current_view] = true