depth = -y

if !global.lock {
	move()
}

if dead
{
	if image_index >= image_number - 1
	{
		image_speed = 0
		image_index = image_number - 1
	}
}

if path_position == 1
{
	path_end()
	path_position = 0
	alarm[1] = 1
}