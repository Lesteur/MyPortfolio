/// @description Draw

var _cw = camera_get_view_width(view_camera[global.current_view])
var _ch = camera_get_view_height(view_camera[global.current_view])
var _cx = camera_get_view_x(view_camera[global.current_view])
var _cy = camera_get_view_y(view_camera[global.current_view])

if !surface_exists(surf)
{
    surf = surface_create(_cw, _ch)
}
	else
{
	var _time = global.timegame

	surface_set_target(surf)
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_sprite_tiled(spr_background1, 0, _time * 0.5, _time * 0.25)
	gpu_set_blendmode(bm_subtract)

	draw_sprite_ext(spr_background2, 0, 0, 0, 1, 1, 0, c_white, 1)

	gpu_set_blendmode(bm_normal)
	draw_set_alpha(1)
	surface_reset_target()
	
	draw_set_colour(c_black)
    draw_set_alpha(0.5)
    draw_rectangle(_cx, _cy, _cx + _cw, _cy + _ch, false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	
	draw_surface(surf, _cx, _cy)
}

if !surface_exists(surf2)
{
	surf2 = surface_create(193, 64)
}
	else
{
	var _time = global.timegame
	
	surface_set_target(surf2)
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_sprite_tiled(spr_background3, 0, _time * -0.5, _time * -0.25)
	gpu_set_blendmode(bm_subtract)

	draw_sprite(spr_back4, 0, 0, 0)

	gpu_set_blendmode(bm_normal)
	draw_sprite(spr_back4, 1, 0, 0)
	
	surface_reset_target()
	
	for (var _i = 0; _i < 5; _i++)
		draw_surface(surf2, _cx + 50 + 20 * _i, _cy + 50 + 60 * _i)
}