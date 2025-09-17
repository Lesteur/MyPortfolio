/// @description End

if instance_exists(obj_textbox) {
	timeline_position = timeline_position - 1
} else {
	timeline_running = false
	timeline_position = 0
	contact = false
	obj_kris.can_move = true
}