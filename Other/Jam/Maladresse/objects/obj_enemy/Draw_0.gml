/// @description Draw shock points

// Inherit the parent event
event_inherited()

var _alpha = (0.5 * (sin(timer * 0.05) + 1))

if shock_turn_left > 0
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_black, _alpha)