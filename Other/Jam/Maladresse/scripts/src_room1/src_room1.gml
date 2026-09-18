function room1()
{
	return
	{
		event1 : function()
		{
			var _player = get_character_cutscene(obj_player)
	
			cutscene_wait( cutscene_move_to(_player, 0, 40, true, 0.5) )
			cutscene_wait( cutscene_move_to(_player, 40, 0, true, 0.5) )
			cutscene_text("Hello World !")
			cutscene_text("{wave}Comment vous sentez-vous, aujourd'hui ?")
			cutscene_wait( cutscene_text("Moi, eh bien...#Je me sens {color red}bien{} !") )
	
			cutscene_align_followers()
		}
	}
}