/// @description Clear variables

if path_exists(path)
	path_delete(path)

//ds_grid_destroy(sprites_grid)
ds_map_destroy(sprites_collection)

layer_sprite_destroy(shadow)