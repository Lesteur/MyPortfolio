/// @function													cutscene_make_timing1(begin, end)
/// @description												Make appear the bar timing numero 1.
/// @param {Real}							begin				The begin.
/// @param {Real}							end 				The end.
/// @return {Any}
/// @self														obj_cutscene

function cutscene_make_timing1(_begin, _end)
{
	var _f = function(_begin, _end)
	{
		var _inst
		
		if !instance_exists(obj_battle_timing1)
		{
			_inst = instance_create_layer(200, 20, "Instances_general", obj_battle_timing1)
			
			with _inst
			{
				var _array = [_begin, _end]
				ds_queue_enqueue(times, _array)
				
				event_user(0)
			}
			
			wait = true
			
			return -1
		} else {
			wait = true
			
			if global.successful_attack == -1
			{
				return -1
			} else {
				instance_destroy(obj_battle_timing1)
				
				reset_cutscene(global.successful_attack)
				global.successful_attack = -1
			}
		}
	}
	
	if reset
	{
		if array_length(variables) == current_variable + 1
			reset = false
		
		return variables[current_variable++]
	} else {
		reset = true
		
		add_cutscene(_f, [_begin, _end])
		return -1
	}
}