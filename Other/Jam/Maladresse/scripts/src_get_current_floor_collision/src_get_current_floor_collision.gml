/// @function		get_current_floor_collision()
/// @description	Get the ID value for the current layer collisions.
/// @self			obj_player

function get_current_floor_collision()
{
	return layer_tilemap_get_id("Collisions_F" + string(global.floor))
}