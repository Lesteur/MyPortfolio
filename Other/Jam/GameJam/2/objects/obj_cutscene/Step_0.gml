/// @description Execute scene one by one

if !ds_queue_empty(cutscene)
{
	do
	{
		current_action = ds_queue_head(cutscene)
		var _act = script_execute_ext(current_action[0], current_action[1])
		
		if _act != -1
			array_push(array_alt, _act)
		
	} until wait || ds_queue_empty(cutscene)
	
} else
	instance_destroy()