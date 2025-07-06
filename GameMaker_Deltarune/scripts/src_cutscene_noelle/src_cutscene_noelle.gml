function cutscene_noelle() {

	cutscene_text_voice(snd_txtnoelle)
	cutscene_text("* Salut, Kris ! * Contente de te retrouver !", spr_facenoelle_smile_closed)
	cutscene_text("* Tu veux qu'on discute tous les deux ?", spr_facenoelle_smile)
	var _choice = cutscene_choice(["{choice0}Susie", "{choice1}Berdly", "{choice2}Soirée", "{choice3}Rien"])
	
	var _choice1 = function() {
		cutscene_text("* Dis Kris, j'ai vu que tu t'entendais bien avec Susie, non ?", spr_facenoelle_blush_finger)
		cutscene_text("* Oh je veux dire... C'est super que vous soyez devenus amis !", spr_facenoelle_surprise_smile_b)
		cutscene_text("* Je voulais te demander... Vous avez fait quoi ensemble ?", spr_facenoelle_smile_closed_b)
		cutscene_text("* J'ai l'impression que tout a commencé depuis ce jour...", spr_facenoelle_confused_surprise_b)
		cutscene_text("* Quand vous êtes allés chercher des craies dans le placard.", spr_facenoelle_confused_surprise)
		cutscene_text("* Dis moi franchement, Kris... Vous avez fait quoi dedans ???", spr_facenoelle_smile_closed_b)
	}
	
	var _choice2 = function() {
		cutscene_text("* Je suis contente que vous vous appréciez mieux, Berdly et toi.", spr_facenoelle_smile_closed)
		cutscene_text("* Il se montre souvent réservé mais il n'est pas méchant, tu sais.", spr_facenoelle_smile_side)
		cutscene_text("* Pourtant, vous avez plus en commun qu'on ne le croit !", spr_facenoelle_smile_closed_b)
		cutscene_text("* Vous avez même joué à Super Smashing Fighters toute la nuit !", spr_facenoelle_blush_finger)
	}
	
	var _choice3 = function() {
		cutscene_text("* Ça fait longtemps que je ne n'étais pas venue chez toi, Kris.", spr_facenoelle_smile_closed)
		cutscene_text("* Dire que c'est déjà les vacances... Le temps passe si vite.", spr_facenoelle_smile)
		cutscene_text("* Tu sais, les choses sont devenues un peu compliquées...", spr_facenoelle_smile_side)
		cutscene_text("* Avec mon père, Asriel qui est parti, tes parents... et Dess...", spr_facenoelle_dejected)
		cutscene_text("* Ça semble faire une éternité qu'on a pas eu de vrais bons moments.", spr_facenoelle_dejected)
		cutscene_text("* ...", spr_facenoelle_smile_side)
		cutscene_text("* E-Excuse moi, je voulais pas casser l'ambiance...", spr_facenoelle_smile_closed)
		cutscene_text("* Puisque c'est les vacances, il faut qu'on en profite, pas vrai ?", spr_facenoelle_smile_closed_b)
		cutscene_text("* Profitons de cette soirée pour passer un bon moment ensemble !", spr_facenoelle_smile_closed_b)
	}
	
	var _choice4 = function() {
		cutscene_text("* Au revoir, Kris ! * Passe le bonjour à Azzy de ma part !", spr_facenoelle_smile_closed)
	}
	
	//cutscene_path([_choice1, _choice2, _choice3, _choice4])
	switch(_choice) {
		case 0:
			script_execute(_choice1)
			break
		case 1:
			script_execute(_choice2)
			break
		case 2:
			script_execute(_choice3)
			break
		case 3:
			script_execute(_choice4)
			break
	}
}