/// @function					cutscene_wait(command)
/// @description				Make wait for seconds or until another command is over.
/// @param	{Real}	command		The command to wait.
/// @self						obj_cutscene

function cutscene_wait(_command)
{
	var _f1 = function(_command)
	{
		wait = true
		
		if !instance_exists(array_alt[_command[0]]) && !audio_exists(array_alt[_command[0]])
		{
			wait = false
			next_cutscene()
			
			return 0
		}
	
		return -1
	}

	var _f2 = function(_sec)
	{
		wait = true
		
		if sec >= _sec
		{
			sec = 0
			wait = false
			next_cutscene()
			
			return 0
		} else {
			sec ++
			
		}
	
		return -1
	}
	
	if reset
		return -1
	
	if is_real(_command)
		add_cutscene(_f2, [_command * FPS])
	else
		add_cutscene(_f1, [_command])
}