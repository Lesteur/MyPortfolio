/// @description Control Player

// Move the player
if !global.lock
	move_player()

if path_position == 1
{
	path_end()
	path_delete(path)
	path = -1
	path_position = 0
}

// Update Depth
depth = -y