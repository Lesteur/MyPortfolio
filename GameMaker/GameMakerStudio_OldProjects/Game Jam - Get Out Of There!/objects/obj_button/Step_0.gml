event_inherited()

if interact {
	instance_create_layer(16, 80, "Instances", obj_gift)
	instance_create_layer(16, 112, "Instances", obj_gift_trick)
	instance_create_layer(16, 144, "Instances", obj_gift_trick)
	instance_create_layer(16, 176, "Instances", obj_gift_trick)
	interact = 0
	global.lock = 0
	show_debug_message("Bip")
}