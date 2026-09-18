/// @description Init Base Player

event_inherited()

// State of Player
current_direction = DIRECTIONS.DOWN
current_state = STATES_PLAYER.IDLE
current_locate = STATES_WORLD.GROUND

// Floor
update_floor()

// Follower
follower = noone
following_queue = ds_queue_create()

var _id = id
for (var _i = 0; _i < 3; _i++)
{
	repeat(30)
		ds_queue_enqueue(_id.following_queue, [0, 1, STATES_PLAYER.WALK, DIRECTIONS.DOWN])
	
	var _newf = instance_create_layer(_id.x, _id.y - 30, current_floor, obj_follower)
	_id.follower = _newf
	_newf.following = _id
	_id = _newf
}