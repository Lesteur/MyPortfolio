function player_interaction() {
	var _player = obj_kris
	if !contact {
		if((place_meeting(x+xbord, y, _player) && _player.sprite_index == _player.spr_left)
		|| (place_meeting(x-xbord, y, _player) && _player.sprite_index == _player.spr_right)
		|| (place_meeting(x, y+ybord, _player) && _player.sprite_index == _player.spr_up)
		|| (place_meeting(x, y-ybord, _player) && _player.sprite_index == _player.spr_down))
		&& keyboard_check_pressed(global._vk_confirm)
			return true
	}
}