/// @description Check Collision

if !global.lock && !lock
{
	if get_current_floor_instance() == current_floor
	{
		if place_meeting(x, y, check_collider)
		{
			collider = instance_place(x, y, check_collider)
			
			collider.x += xx
			collider.y += yy
			
			event_user(0)
			
			if once
				instance_destroy()
		}
	}
}