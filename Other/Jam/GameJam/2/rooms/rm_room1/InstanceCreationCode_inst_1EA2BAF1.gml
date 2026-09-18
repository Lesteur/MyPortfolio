destroy = true

f1 = function()
{
	cutscene_black(true)
	cutscene_wait( cutscene_text("{size 4}{shake}ERREUR 404{}#Un virus a été détecté sur votre ordinateur.#{size 1}Veuillez quitter.") )
	cutscene_black(false)
}