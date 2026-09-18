/// @description Destroy Cutscene

if free_player
	global.lock = false

with launcher
{
	lock = false
	sprite_lock = false
}

var _length = array_length(characters)

for (var _i = 0; _i < _length; _i ++)
{
	with characters[_i]
	{
		lock = false
		sprite_lock = false
	}
}