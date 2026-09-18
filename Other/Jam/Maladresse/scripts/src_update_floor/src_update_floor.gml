/// @function		update_floor()
/// @description	Change the player at collisions and depth.
/// @self			obj_player

function update_floor()
{
	number_floor = global.floor
	current_floor = get_current_floor_instance()
	tilemap_collision = get_current_floor_collision()
	
	layer = current_floor
	depth = layer_get_depth(current_floor) - y
}