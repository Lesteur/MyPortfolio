/// @description Manage Depth, Sprite and Shadow

// Update Depth
depth = layer_get_depth(current_floor) - y

// Set the sprite
if !sprite_lock
	sprite_index = sprites_collection[? current_sprite]
	
// Handle the shadow

layer_sprite_change(shadow, sprite_index)
layer_sprite_index(shadow, image_index)
layer_sprite_x(shadow, x)
layer_sprite_y(shadow, bbox_bottom - 3)
layer_sprite_xscale(shadow, image_xscale)