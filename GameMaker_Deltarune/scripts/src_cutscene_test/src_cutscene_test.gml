function cutscene_test() {
	
	cutscene_text_voice(snd_txtberdly)
	cutscene_text("* Kris ! * J'ai une excellente nouvelle pour toi !", spr_faceberdly_happy)
	cutscene_text("* J'ai décidé de réduire ta dette de 0.01%. * N'est ce pas généreux ?", spr_faceberdly_naughty)
	cutscene_text("* Hello !!!")
	cutscene_wait( cutscene_slide_to(obj_kris, -40, 0, true, 3) )
	cutscene_wait( cutscene_slide_to(obj_kris, 0, 30, true, 3) )
	
	cutscene_text("* Fais ton choix.")
	var _choice = cutscene_choice(["Choix 1", "Choix 2", "Choix 3", "Choix 4"])
	
	cutscene_text("* T'es sûr ?")
	
	switch(_choice) {
		case 0:
			cutscene_text("* Choix 1")
			cutscene_text("* Choix 11")
			break
		case 1:
			cutscene_text("* Choix 2")
			cutscene_text("* Choix 22")
			break
		case 2:
			cutscene_text("* Choix 3")
			cutscene_text("* Choix 33")
			break
		case 3:
			cutscene_text("* Choix 4")
			cutscene_text("* Choix 44")
			break
	}
	
	cutscene_text("* Adieu !!!!!")
}