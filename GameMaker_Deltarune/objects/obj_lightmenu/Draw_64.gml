draw_set_font(global.main_font)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

#region Default

// Box Player Name
draw_sprite_stretched(spr_box_menu_light, 0, _xx, _yy, 71, 55)

draw_text(_xx + 6, _yy + 4, "Kris")

// Box Options
draw_sprite_stretched(spr_box_menu_light, 0, _xx, _yy + 58, 71, 74)

draw_text(_xx + 25, _yy + 68, "OBJ.")
draw_text(_xx + 25, _yy + 68 + 72/4, "STATS")
draw_text(_xx + 25, _yy + 68 + 72/2, "TÉL.")

#endregion

#region Objects

// Box Objects
draw_sprite_stretched(spr_box_menu_light, 0, _xx + 78, _yy, 173, 724/4)

for (var _i = 0; _i < 4; _i ++) {
	draw_text(_xx + 88, _yy + 14 + _i*16, "Useless Item")
}

#endregion

/*

// Box Stats
draw_sprite_stretched(spr_box_menu_light, 0, _xx + 78, _yy, 173, 209)

// Box Phone
draw_sprite_stretched(spr_box_menu_light, 0, _xx + 78, _yy, 173, 135)