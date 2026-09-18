/// @function													cutscene_align_followers()
/// @description												Align the follower positions behind the current position of the player.
/// @self														obj_cutscene

function cutscene_align_followers()
{
	var _array = [obj_player]
	var _i = 0
	
	with _array[0]
		ds_queue_clear(following_queue)
	
	while _array[_i].follower != noone
	{
		var _character = get_character_cutscene(_array[_i].follower)
		
		array_push(_array, _character)
		_i ++
	}
	
	var _action
	for (var _j = 1; _j < _i + 1; _j ++)
	{
		_action = cutscene_move_to_marker(_array[_j], _array[0], 1)
		
		with _array[_j]
			ds_queue_clear(following_queue)
	}
	cutscene_wait( _action )
}