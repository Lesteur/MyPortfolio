/// @function								get_character_cutscene(_character, add)
/// @description							Get the id of the character and include them in the cutscene.
/// @param {Id.Instance}	 character		The character to check.
/// @param {Bool}			 add			If you have to reinitalize theirs stats.
/// @return {Id.Instance}
/// @self									obj_cutscene

function get_character_cutscene(_character, _add = true)
{
	show_debug_message(_character)
	
	if is_array(_character)
		return array_alt[_character[0]]
	
	if instance_exists(_character)
	{
		if _add
		{
			with _character
			{
				lock = true
				sprite_lock = true
				
				update_floor()
				sprite_index = sprites_collection[? current_sprite] //sprites_grid[# player_direction, player_state]
			}
			
			array_push(characters, _character)
		}
			
		return _character
	} else {
		return noone
	}
}