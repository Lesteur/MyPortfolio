function cutscene_set_sprite(_actor, _sprite, _image = 0, _speed = 0) {
	
	function cutscene_alt_set_sprite(_actor, _sprite, _image, _speed) {
	
		with _actor {
			sprite_index = _sprite
			image_speed = _speed
			image_index = _image
		}
	
		step ++
	
		return 0
	}
	
	if reset
		return -1
	
	array_push(cutscene, [cutscene_alt_set_sprite, [_actor, _sprite, _image, _speed]])
	return [array_length(cutscene) - 1]
}