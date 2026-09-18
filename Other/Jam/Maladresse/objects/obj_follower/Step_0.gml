/// @description Control Player

var _point_distance = point_distance(following.x, following.y, x, y)

if (ds_queue_size(following.following_queue) > 30) && !lock
{
	var _point = ds_queue_dequeue(following.following_queue)
	switch _point[2]
	{
		case STATES_PLAYER.JUMP:
		
			repeat 29
			{
				ds_queue_dequeue(following.following_queue)
				ds_queue_enqueue(following_queue, _point)
			}
		
			current_floor = following.current_floor
			current_direction = _point[3]
			
			var _f = function(_actor, _x, _y)
			{
				_actor = get_character_cutscene(_actor)
				cutscene_wait( cutscene_jump_to(_actor, _x, _y, true, 2) )
			}
			
			create_cutscene(_f, [id, _point[0], _point[1]], false)
			break
		default:
			
			x += _point[0]
			y += _point[1]
			
			current_state = _point[2]
			current_direction = _point[3]
			
			break
	}
	ds_queue_enqueue(following_queue, _point)
} else
	current_state = STATES_PLAYER.IDLE

current_sprite = (current_direction * 3) + current_state

event_inherited()