/// @description Take time

if setup
{
	
	if input_check_pressed(INPUT.BATTLE1)
	{
		if (var_begin <= value) && (value <= var_end)
		{
			ds_queue_dequeue(times)
			event_user(0)
		} else {
			global.successful_attack = 0
		}
	}
	
	value = animcurve_channel_evaluate(channel, t)
	
	t += spd
	
	if (t >= 1) || (t <= 0)
		spd = -spd
}