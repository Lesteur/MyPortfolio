destroy = true

f1 = function()
{
	cutscene_black(true)
	cutscene_wait( cutscene_text("{size 4}{shake}ERREUR !!!{}#Ce jeu n'est pas compatible avec votre appareil.#{size 1}Désolé") )
	cutscene_black(false)
}