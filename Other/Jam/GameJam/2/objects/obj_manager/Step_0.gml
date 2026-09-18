/// @description Increase Time Game

global.timegame ++

if GAMEPAD_SUPPORTED
{
	if !gamepad_is_connected(global.gamepad_index)
	{
		for (var _i = 0; _i < GAMEPAD_NB_SLOTS; _i ++)
		{
			if gamepad_is_connected(_i)
			{
				global.gamepad_index = _i
				_i = GAMEPAD_NB_SLOTS
			}
		}
	}
}