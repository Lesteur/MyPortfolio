/// @description Loop Text

if setup
{
	if text == -1
	{
		var _misc = ds_queue_dequeue(list_text)
		
		text = _misc[0]
		effects = _misc[1]
		
		letter = 1
		letter_end = string_length(text)
	}
	
	if letter <= letter_end
	{
		sub_text = string_copy(text, 1, letter)
		
		letter ++
	}
	
	if get_input_check_pressed(INPUT.CONFIRM)
	{
		if letter <= letter_end
			letter = letter_end
		else {
			text = -1
			
			if ds_queue_empty(list_text)
				instance_destroy()
		}
	}
}