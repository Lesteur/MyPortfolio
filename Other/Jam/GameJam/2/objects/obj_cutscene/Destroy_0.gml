/// @description Destroy Cutscene

if free_player
	global.lock = false

if (launcher != noone) && instance_exists(launcher)
	launcher.lock = false

var _length = array_length(characters)

for (var _i = 0; _i < _length; _i ++)
	characters[_i].lock = false