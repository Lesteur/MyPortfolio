/// @function		get_current_floor_instance()
/// @description	Get the ID value for the current layer instances.
/// @self			obj_player

function get_current_floor_instance()
{
	return layer_get_id("Instances_F" + string(global.floor))
}