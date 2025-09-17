function cutscene_spamton() {
	
	cutscene_text("* ALLONS, KRIS. * TU SAIS QUE TU N'AS PAS [Le Choix].")
	cutscene_text("* ACCEPTE NOTRE [Deal].")
	
	functions_alt[0] = cutscene_choice(["{choice0}Oui", "{choice1}Non"])
	
	if functions_alt[0] == 0 {
		cutscene_text("* MARCHE CONCLU !!!!!!")
	} else if functions_alt[0] == 1 {
		cutscene_text("* Faux")
	}
}

