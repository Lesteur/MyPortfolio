/// @description Setup Solid

if get_current_floor_instance() == current_floor
{
	my_solid = instance_create_layer(x, y, current_floor, obj_box_collision)
	
	my_solid.sprite_index = sprite_index
	my_solid.image_xscale = image_xscale
	my_solid.image_yscale = image_yscale
} else {
	if instance_exists(my_solid)
	{
		with my_solid
			instance_destroy()
	}
}