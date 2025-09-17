cutscene = function() {
	
	cutscene_play_sound(snd_savepoint)
	if global.forced_run {
		cutscene_text("* Tu sens le pouvoir dans tes mains.")
	} else {
		cutscene_text("* Tes amis et toi vous retrouvez dans une drôle de pièce.")
		cutscene_text("* Le pouvoir du débogage de jeux vidéo brille en toi.")
	}
}