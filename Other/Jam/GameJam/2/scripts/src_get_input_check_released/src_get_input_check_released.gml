/// @function				get_input_check_released(action)
/// @description			Check if an input has been released or not.
/// @param  {Real}	action	Number of floors to climb or down.
/// @self					obj_player

function get_input_check_released(_action)
{
    var _mapping = global.input_map[? _action]
    
    // Check the keyboard
    if keyboard_check_released(_mapping.key)
        return true
	
    // Check the gamepad
	if GAMEPAD_SUPPORTED
	{
	    if gamepad_button_check_released(global.gamepad_index, _mapping.gamepad)
			return true
	}

    return false
}