/// @description End Turn

end_turn = false
is_acting = false
item_used = false

var _new_enemies_array = []

for (var _i = 0; _i < array_length(enemies_array); _i++)
{
	var _enemy = enemies_array[_i]
	
	if instance_exists(_enemy) && (_enemy.hp > 0)
	{
		array_push(_new_enemies_array, _enemy)
	}
}

enemies_array = _new_enemies_array

if current_target >= array_length(enemies_array)
	current_target = array_length(enemies_array) - 1

if array_length(enemies_array) == 0
	is_acting = true

		
if is_allies_turn
{
	turn_allies ++
	
	back_line = []
	for (var _i = 0; _i < array_length(partymembers_array); _i++)
	{
		var _partymember = partymembers_array[_i]
			
		if _partymember.chosen == false
			array_push(back_line, _partymember)
	}
	
	current_back_line_number = array_length(back_line) - 1
			
	if turn_allies >= turn_allies_max
	{
		turn_allies = 0
		is_allies_turn = false
	}
	
} else {
	turn_enemies ++
			
	if turn_enemies >= array_length(enemies_array)
	{
		turn_enemies = 0
		front_line = []
		back_line = []
		
		for (var _i = 0; _i < array_length(partymembers_array); _i ++)
		{
			var _partymember = partymembers_array[_i]
			
			with _partymember
			{
				chosen = false
				
				xdest = xbegin
				ydest = ybegin
				
				event_user(3)
			}
			
			array_push(back_line, _partymember)
		}
		
		is_allies_turn = true
	}
}

if current_back_line_number >= array_length(back_line)
	current_back_line_number = array_length(back_line) - 1
else if current_back_line_number < 0
	current_back_line_number = 0