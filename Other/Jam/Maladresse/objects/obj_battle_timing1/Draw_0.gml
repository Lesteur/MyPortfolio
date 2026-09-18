/// @description Draw Bar

draw_self()

draw_sprite_stretched(spr_bar_arrow_1, 0, x + (var_begin - 50) * 2, y + 10, (var_end - var_begin) * 2, 6)

//var _val = animcurve_channel_evaluate(channel, t)
draw_sprite(spr_bar_arrow, 0, x - 100 + value * 2, y + 10)