/// @description Loop Text

if setup
{
	if letter <= letter_end
	{
		sub_text = string_copy(text, 1, letter)
		
		letter ++
	}
	
	if get_input_check_pressed(INPUT.CONFIRM)
	{
		if letter <= letter_end
			letter = letter_end
		else
			instance_destroy()
	}
}