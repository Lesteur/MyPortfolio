event_inherited()

if interact {
	image_index = 1
	instance_create_layer(48, 32, "Instances", obj_door)
	interact = 0
	global.lock = 0
	show_debug_message("Cadeau")
}