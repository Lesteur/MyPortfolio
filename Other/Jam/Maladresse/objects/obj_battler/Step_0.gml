/// @description Manage Depth, Timer, Sprite and Shadow

timer ++

if (spd_count > 0)
{
	x += xmove
	y += ymove
	
	spd_count --
	
	if spd_count == 0
	{
		x = xdest
		y = ydest
		
		xdest = -1
		ydest = -1
		
		xmove = -1
		ymove = -1
	}
}

// Inherit the parent event
event_inherited()