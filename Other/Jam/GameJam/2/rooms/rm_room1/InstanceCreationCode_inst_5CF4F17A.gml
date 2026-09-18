destroy = false

f1 = function()
{
	obj_pix.x = 550
	obj_pix.y = 1280
	
	cutscene_black(true)
	cutscene_wait( cutscene_text("{glitch}Erreur. Mauvaise direction#Pas par là Pas par là Pas par là Pas par là Pas par là Pas par là#FATAL ERROR ---------------") )
	cutscene_black(false)
}

alarm[0] = 60 * 4