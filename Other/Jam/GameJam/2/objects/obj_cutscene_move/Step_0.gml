/// @description Begin

if setup
{
	if actor.path == -1
	{
		with actor
			sprite_index = sprites_grid[# player_direction, STATES_PLAYER.IDLE]
		
		instance_destroy()
	}
}