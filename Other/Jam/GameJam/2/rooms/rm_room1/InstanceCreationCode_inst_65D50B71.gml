sprite_index = spr_box_chest
visible = true

destroy = false

f1 = function()
{
	hide_hitboxes_cutscene(true)
	obj_pix.x = 95
	obj_pix.y = 1445
	
	cutscene_black(true)
	cutscene_wait( cutscene_text("{size 4}{shake}ERROR NULL POINTEUR{}#{glitch}Erreur Erreur Erreur Erreur Erreur.#{size 1}{shake}PARTEZ.") )
	cutscene_black(false)
}