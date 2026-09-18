/// @function				get_input_check_pressed(action)
/// @description			Check if an input has been pressed or not.
/// @param  {Real}	action	Number of floors to climb or down.
/// @self					obj_player

function get_input_check_pressed(_action)
{
    var _mapping = global.input_map[? _action]
    
    // Check the keyboard
    if keyboard_check_pressed(_mapping.key)
        return true
	
    // Check the gamepad
	if GAMEPAD_SUPPORTED
	{
	    if gamepad_button_check_pressed(global.gamepad_index, _mapping.gamepad)
			return true
	}

    return false
}