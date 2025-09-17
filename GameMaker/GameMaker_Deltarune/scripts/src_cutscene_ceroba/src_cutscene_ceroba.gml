function cutscene_ceroba() {
	
	cutscene_text_voice(snd_txtceroba)
	cutscene_text("* Tu as besoin de quelque chose, Kris ?", spr_faceceroba_neutral)
	var _choice = cutscene_choice(["{choice0}Famille", "{choice1}Ville", "{choice2}Travail", "{choice3}Rien"])
	
	switch(_choice) {
		case 0:
		
			if launcher.flag_family == false {
				cutscene_text("* Alors comme ça, tu t'intéresses à ma vie privée... ?", spr_faceceroba_annoyed_b)
				cutscene_text("* Tu es quelqu'un de plutôt indiscret, on te l'a déjà dit ?", spr_faceceroba_tired)
				cutscene_text("* ... Qu'est ce que tu veux savoir ?", spr_faceceroba_neutral)
				var _choice2 = cutscene_choice(["{choice0}Chujin", "{choice1}Kanako", "{choice2}Toi"])
				
				switch (_choice2) {
					case 0:
					
						cutscene_text("* Chujin est mon époux. * Il est professeur de sciences à l'université.", spr_faceceroba_neutral)
						cutscene_text("* Nous vivions ensemble ici depuis la naissance de notre fille.", spr_faceceroba_neutral)
						cutscene_text("* Mais il a dû partir vivre ailleurs à cause de son travail.", spr_faceceroba_neutral_side)
						cutscene_text("* Ça n'a plus été pareil pour nous depuis... * Il a tellement fait ici.", spr_faceceroba_down)
						cutscene_text("* Mais malgré tout, il a toujours gardé le contact avec nous.", spr_faceceroba_down_smile)
						cutscene_text("* Il nous appelle chaque soir pour nous demander comment on va...", spr_faceceroba_down_smile)
						cutscene_text("* J'attendais avec impatience qu'il revienne nous voir.", spr_faceceroba_pleased)
						break
					case 1:
					
						cutscene_text("* Kanako, c'est ma petite fille adorée. * Je l'aime plus que tout.", spr_faceceroba_down_smile)
						cutscene_text("* Toujours pleine d'énergie, jamais fatiguée, si créative...", spr_faceceroba_smile)
						cutscene_text("* Et vraiment très douée pour provoquer des bêtises.", spr_faceceroba_annoyed_b)
						cutscene_text("* ... Hmm ? Où elle est ?", spr_faceceroba_neutral)
						cutscene_text("* Oh, elle n'est pas ici malheureusement, elle est en voyage scolaire.", spr_faceceroba_neutral_side)
						cutscene_text("* Elle doit être en train de s'amuser avec son ami.", spr_faceceroba_down_smile)
						cutscene_text("* Ces deux-là ne se quittent jamais.", spr_faceceroba_down_smile)
						cutscene_text("* D'ailleurs c'est drôle, tu lui ressembles un peu, Kris.", spr_faceceroba_smile)
						break
					default:
					
						cutscene_text("* ... Sur... sur moi ??", spr_faceceroba_shock)
						cutscene_text("* Heu... Honnêtement, il n'y a pas grand-chose à dire sur moi-même.", spr_faceceroba_confused)
						break
				}
			} else {
				cutscene_text("* Dis-moi, tu voulais que je parle de ma famille.", spr_faceceroba_neutral)
				cutscene_text("* Je dois avouer que maintenant, je suis un peu curieuse, moi aussi.", spr_faceceroba_neutral_side)
				cutscene_text("* Comment est ta famille, à toi ?", spr_faceceroba_smile)
				var _choice2 = cutscene_choice(["Mes parents#ont divorcé", "{choice1}Mon frère est#à l'université", "{choice2}C'est un peu compliqué..."])
				
				switch (_choice2) {
					case 0:
					
						cutscene_text("* O-Oh ! Je... Je... heu...", spr_faceceroba_shock_b)
						cutscene_text("* ...", spr_faceceroba_sad)
						cutscene_text("* Excuse-moi, Kris... * Je... Je ne pouvais pas savoir...", spr_faceceroba_down)
						cutscene_text("* Ça... ça n'a pas dû être facile à gérer, n'est ce pas... ?", spr_faceceroba_down)
						break
					case 1:
					
						cutscene_text("* Alors, ton frère est à l'université, lui aussi, hein ?", spr_faceceroba_neutral)
						cutscene_text("* Et tu dis qu'il te manque...", spr_faceceroba_down)
						cutscene_text("* ... Oui, je comprends ce que tu traverses.", spr_faceceroba_down_smile)
						cutscene_text("* Nos vies ne sont plus vraiment pareilles...", spr_faceceroba_neutral)
						cutscene_text("* ... quand les gens qu'on aime doivent partir précipitamment.", spr_faceceroba_neutral)
						
						cutscene_text("* Si tu veux, j'ai écrit un roman qui parle de ça.", spr_faceceroba_smile_side)
						cutscene_text("* J'y ai écrit comment pouvoir gérer tout ça.", spr_faceceroba_neutral)
						cutscene_text("* Bon, normalement c'est pour les adultes mais...", spr_faceceroba_confused)
						break
					default:
					
						cutscene_text("* J'ai oublié ce que je voulais dire. * Encore.", spr_faceceroba_confused)
						break
				}
			}
		break
		case 1:
		
			cutscene_text("* Oh tu sais... * Ici c'est juste une petite ville.", spr_faceceroba_neutral_side)
			break
		case 2:
		
			cutscene_text("* Oh, qu'est ce que je fais dans la vie ? * Eh bien...", spr_faceceroba_neutral_side)
			cutscene_text("* Je suis autrice. * J'écris des romans en tout genre.", spr_faceceroba_smile)
			cutscene_text("* Bon, ce n'est peut-être pas le boulot le mieux payé mais...", spr_faceceroba_neutral)
			cutscene_text("* Au moins, il a le mérite de ne pas trop me fatiguer.", spr_faceceroba_happy)
			cutscene_text("* Par exemple, je peux rester tranquillement chez moi.", spr_faceceroba_happy)
			cutscene_text("* Il y a la liberté artistique, personne pour venir m'énerver...", spr_faceceroba_happy)
			cutscene_text("* Et je peux aussi regarder mon émission favorite en même temps !", spr_faceceroba_happy)
			cutscene_text("* Il faut juste faire attention au syndrôme de la page blanche...", spr_faceceroba_annoyed_b)
			cutscene_text("* L'envie inévitable de proscratiner durant les heures de travail...", spr_faceceroba_annoyed_b)
			cutscene_text("* Et aux deadlines très très strictes...", spr_faceceroba_confused)
			break
		default:
		
			cutscene_text("* N'hésite pas à m'appeler si il y a un souci.", spr_faceceroba_smile)
			break
	}
}