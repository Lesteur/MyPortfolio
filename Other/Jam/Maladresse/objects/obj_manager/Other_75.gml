/// @description Detection Gamepad

var _event_type = async_load[? "event_type"]

switch _event_type
{
	case "gamepad discovered":
		if !global.gamepad_control
		{
			global.gamepad_index = async_load[? "pad_index"]
			global.gamepad_control = true
			
			gamepad_set_axis_deadzone(global.gamepad_index, 0.05)
			
			show_debug_message("Gamepad connecté !")
		}
		break
	case "gamepad lost":
		if !gamepad_is_connected(global.gamepad_index)
		{
			global.gamepad_index = -1
			var _count = GAMEPAD_NB_SLOTS
			
			for (var _i = 0; _i < _count; _i ++)
			{
				if gamepad_is_connected(_i)
				{
					global.gamepad_index = _i
					_i = _count
				}
			}
			
			if global.gamepad_index == -1
				global.gamepad_control = false
			
			show_debug_message("Gamepad déconnecté !")
		}
		break
}