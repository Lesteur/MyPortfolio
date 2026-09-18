/// @function								get_character_cutscene(_command)
/// @description							Get the id of the character and include them in the cutscene.
/// @param {Id.Instance}	 character		The character to check.
/// @return {Id.Instance}
/// @self									obj_cutscene

function get_character_cutscene(_character, _add = true)
{
	if instance_exists(_character)
	{
		if _add
		{
			_character.lock = true
			array_push(characters, _character)
		}
			
		return _character
	} else {
		return noone
	}
}