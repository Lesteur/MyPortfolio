/// @description Setup

setup = true

if ds_queue_empty(times)
{
	global.successful_attack = 1
} else {
	var _time = ds_queue_head(times)
	
	var_begin = _time[0]
	var_end = _time[1]
}