function cutscene_sans() {
	
	if !global.forced_run {
		var _spr = obj_npc_sans.sprite_index
		cutscene_text_voice(snd_txtsans)
		cutscene_text("{sans}* j'ai une blague pour toi.", spr_facesans_neutral)
		cutscene_text("{sans}* pourquoi le squelette n'a pas d'amis ?", spr_facesans_chuckle)
		cutscene_text("{sans}* parce qu'il n'OS pas parler aux autres.", spr_facesans_chuckle_b)
		cutscene_wait( cutscene_camera_transition("bigplan", obj_npc_sans) )
		cutscene_set_sprite(obj_npc_sans, spr_sans_joke)
		cutscene_wait( cutscene_play_sound(snd_badumtss) )
		cutscene_wait( cutscene_camera_transition("default", obj_kris) )
		cutscene_set_sprite(obj_npc_sans, _spr)
		cutscene_text_voice(snd_txtsans)
		cutscene_text("{sans}* pas mal, hein ?", spr_facesans_wink, true)
	} else {
		cutscene_text_voice(snd_txtsans)
		cutscene_text("{sans}* ...", spr_facesans_blink)
		cutscene_text("{sans}* t'as une sale tête, dis-moi.", spr_facesans_blink)
		cutscene_text("{sans}* j'ai pas l'impression qu'une blague te fera te sentir mieux.", spr_facesans_neutral)
		cutscene_text("{sans}* cette expression sur ton visage...", spr_facesans_blink)
		cutscene_text("{sans}* ...", spr_facesans_blink)
		cutscene_text("{sans}* fais très attention à toi et à tes amis, le mioche.", spr_facesans_neutral)
		cutscene_text("{sans}* devoir payer pour les actions de quelqu'un d'autre...", spr_facesans_neutral)
		cutscene_text("{sans}* c'est quand même un comble.", spr_facesans_blink)
	}
}