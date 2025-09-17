display_set_gui_size(width*2, height*2)

for (var _i = 0; _i < array_length(team); _i ++) {
	
	var _battler = obj_partymember
	switch (team[_i]) {
		case "kris":
			_battler = obj_kris
			break
		case "susie":
			_battler = obj_susie
			break
		case "noelle":
			_battler = obj_noelle
			break
		case "berdly":
			_battler = obj_berdly
			break
	}
	
	if (turn == _i) {
        if (mmy[_i] > -32)
            mmy[_i] -= 2
        if (mmy[_i] > -24)
            mmy[_i] -= 4
        if (mmy[_i] > -16)
            mmy[_i] -= 6
        if (mmy[_i] > -8)
            mmy[_i] -= 8
        if (mmy[_i] < -32)
            mmy[_i] = -64
    } else if (mmy[_i] < -14)
        mmy[_i] += 15
    else
        mmy[_i] = 0
	
	var _y = mmy[_i]
	var _color = -1
	var _image = -1
	
	if _i == turn {
		_color = _battler.color
		_image = 0
	} else {
		_color = make_color_rgb(51, 32, 51)
		_image = 1
	}
	
	draw_sprite_ext(spr_banner_chara_fight, _image, _i * 213, 397 + _y, 1, 1, 0, _color, 1)
	draw_sprite(spr_banner_misc, 0, _i * 213, 397 + _y)
	
	draw_set_color(_battler.color)
	
	if _i == turn
		draw_selectionmatrix(_i * 213, 363 + _y)
	
	draw_sprite(spr_banner_fight, 0, 20 +_i * 213, 365 + _y)
	
	var _action = spr_banner_act
	if _battler != obj_kris
		_action = spr_banner_magic
		
	draw_sprite(_action, 0, 55 +_i * 213, 365 + _y)
	draw_sprite(spr_banner_item, 0, 90 +_i * 213, 365 + _y)
	draw_sprite(spr_banner_spare, 0, 125 +_i * 213, 365 + _y)
	draw_sprite(spr_banner_defend, 0, 160 +_i * 213, 365 + _y)
	
	draw_healthbar(128 + _i * 213, 347 + _y, 203 + _i * 213, 355 + _y, 90, make_color_rgb(128, 0, 0), _battler.color, _battler.color, 0, true, false)
	
	var _icon = _battler.head_icon
	draw_sprite(_icon, 0, 12 + _i * 213, 335 + _y)
	
	var _name = _battler.name_sprite
	draw_sprite(_name, 0, 51 + _i * 213, 339 + _y)
}

draw_sprite(spr_background_fight, 0, 0, 480)

display_set_gui_size(width, height)

draw_text_special(15, 187.5, "* Début du combat... ? ", 20, 1000, [])