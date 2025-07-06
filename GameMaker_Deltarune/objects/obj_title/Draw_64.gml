switch menu {
	case 0:
		draw_set_font(fnt_determination)
		draw_set_halign(fa_center)
		draw_text(160, 200, array_text[0])
		break
	case 1:
		draw_set_font(fnt_determination)
		draw_set_halign(fa_left)
		draw_text(49, 20, array_text[1])
		for (var _i = 0; _i < 3; _i ++) {
			draw_sprite_stretched(spr_box_menu_light_2px, 0, 50, 40 + 48*_i, 220, 45)
			draw_text(76, 45 + 48*_i, array_text[2])
			draw_text(220, 45 + 48*_i, "--|--")
			draw_text(56, 65 + 48*_i, "------------")
		}
		draw_sprite_ext(spr_soul_red, 0, 61, 53 + 48*choice_file, 0.5, 0.5, 0, c_white, 1)
		break
	case 2:
		draw_set_font(fnt_determination)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_text_special(50, 10, array_text[3], 15, 1000, array_text_misc[3])
}