function cutscene_play_sound(_sound) {
	
	function cutscene_alt_play_sound(_sound) {
	
		var _inst = audio_play_sound(_sound, 10, false)
		step ++
	
		return _inst
	}
	
	if reset
		return -1
	
	array_push(cutscene, [cutscene_alt_play_sound, [_sound]])
	return [array_length(cutscene) - 1]
}