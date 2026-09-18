/// @description Draw

for (var _i = 0; _i < string_length(damage); _i ++)
{
	var _x = x
	var _y = y - animcurve_channel_evaluate(channel, t)
	var _char = string_char_at(damage, _i + 1)
		
	draw_set_color(c_red)
	draw_sprite(spr_numbers_2, real(_char), _x + 8 * _i, _y)
	draw_set_color(c_white)
}