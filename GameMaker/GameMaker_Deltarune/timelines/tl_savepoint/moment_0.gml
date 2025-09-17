if !instance_exists(obj_textbox)
	var _inst = textbox_create()

with _inst {
	array = ["* Tes amis et toi vous retrouvez dans une drôle de pièce.", "* Le pouvoir du débogage de jeux vidéo brille en toi."]
	
	event_user(0)
}

save_file(1)