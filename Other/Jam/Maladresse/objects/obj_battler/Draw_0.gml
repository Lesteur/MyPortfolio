/// @description Draw stats

// Inherit the parent event
event_inherited()

if is_shaking
{
	if timer_shake > 0
	{
		x = xbegin2 + random_range(-2, 2)
		y = ybegin2 + random_range(-2, 2)
		
		timer_shake --
	} else {
		x = xbegin2
		y = ybegin2
		
		timer_shake = 0
		is_shaking = false
		
		current_sprite = INDEX_SPRITES.FIGHT_IDLE
	}
}