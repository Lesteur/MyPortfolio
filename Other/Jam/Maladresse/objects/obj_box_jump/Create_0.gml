/// @description Init

event_inherited()

cutscene = function(_actor, _x, _y)
{
	with _actor
	{
		repeat 30
			ds_queue_enqueue(following_queue, [_x, _y, STATES_PLAYER.JUMP, current_direction])
	}

	if _y == 0
		cutscene_camera_speed(-1, 0)
	
	_actor = get_character_cutscene(_actor)
	cutscene_wait( cutscene_jump_to(_actor, _x, _y, true, 0.5) )
	
	if _y == 0
		cutscene_camera_speed(-1, -1)
}