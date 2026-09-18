/// @function		draw_shadow()
/// @description	Draw a shadow behind the object.
/// @self			obj_player

function draw_shadow()
{
	gpu_set_fog(true, c_black, 0, 1)
	draw_sprite_pos(sprite_index, image_index,
	x - 10 + 20,
	y - 30,
	x + 10 + 20,
	y - 30,
	x + 10,
	y - 2,
	x - 10,
	y - 2,
	0.5)
	gpu_set_fog(false, c_white, 0, 0)
}