/// @description Init Base Player

event_inherited()

// State of Player
current_direction = DIRECTIONS.DOWN
current_state = STATES_PLAYER.IDLE
current_locate = STATES_WORLD.GROUND

// Floor
update_floor()

following_queue = ds_queue_create()
follower = noone
following = noone

jump = false