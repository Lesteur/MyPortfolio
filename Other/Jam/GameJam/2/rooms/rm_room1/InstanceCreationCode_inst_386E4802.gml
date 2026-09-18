sprite_index = spr_box_chest
visible = true

destroy = false

f1 = function()
{
	launcher.sprite_index = spr_box_chest
	launcher.visible = true
	obj_pix.x = 160
	obj_pix.y = 1150
	
	cutscene_black(true)
	cutscene_wait( cutscene_text("{size 4}{shake}Erreur détectée Problème{}#{glitch}Erreur Erreur Erreur Erreur Erreur.#{size 1}{shake}Veuillez redémarrer.") )
	cutscene_black(false)
}