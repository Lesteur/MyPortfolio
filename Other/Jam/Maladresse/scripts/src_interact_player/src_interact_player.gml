/// @function		interact_player()
/// @description	Check if the player can interact with a NPC or interactable object.
/// @self			obj_player

function interact_player(_run = false)
{
	var _player = obj_player
	return
	(((place_meeting(x + 3, y, _player) && _player.player_direction == DIRECTIONS.LEFT) ||
	  (place_meeting(x - 3, y, _player) && _player.player_direction == DIRECTIONS.RIGHT) ||
	  (place_meeting(x, y + 3, _player) && _player.player_direction == DIRECTIONS.UP) ||
	  (place_meeting(x, y - 3, _player) && _player.player_direction == DIRECTIONS.DOWN)) &&
	  !global.lock &&
	  (input_check_pressed(INPUT.CONFIRM) || (_player.player_state = STATES_PLAYER.RUN && _run)))
}