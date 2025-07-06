depth = -bbox_bottom

if player_interaction() {
	contact = true
	global.can_move = false
	
	var _player = obj_kris
	
	if _player.sprite_index == _player.spr_left
		sprite_index = spr_right
	else if _player.sprite_index == _player.spr_right
		sprite_index = spr_left
	else if _player.sprite_index == _player.spr_down
		sprite_index = spr_up
	else
		sprite_index = spr_down
	
	create_cutscene(cutscene)
}

if path_position == 1 {
	path_end()
	path_delete(path)
	path = -1
	path_position = 0
}