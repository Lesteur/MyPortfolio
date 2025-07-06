x = 0
y = 0

width = 320
height = 240

scale_window = global.window_scale
angle = 0
target = obj_kris

camera_default = camera_create_view(x, y, width, height, angle, target, -1, -1, width/2, height/2)
camera_battle = camera_create_view(x, y, width * 2, height * 2, angle, target, -1, -1, width, height)
camera_bigplan = camera_create_view(x, y, width/4, height/4, angle, target, -1, -1, width/8, height/8 - 20)

window_set_size( width * scale_window, height * scale_window )
display_set_gui_size(width, height)
show_debug_message(display_get_gui_width())
show_debug_message(display_get_gui_height())
window_center()