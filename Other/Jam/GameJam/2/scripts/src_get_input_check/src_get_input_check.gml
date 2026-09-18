/// @function				get_input_check(action)
/// @description			Check if an input is held down or not.
/// @param  {Real}	action	Number of floors to climb or down.
/// @self					obj_player

function get_input_check(_action)
{
    var _mapping = global.input_map[? _action]
    
    // Check the keyboard
    if keyboard_check(_mapping.key)
        return true
	
    // Check the gamepad
	if GAMEPAD_SUPPORTED
	{
	    if gamepad_button_check(global.gamepad_index, _mapping.gamepad)
			return true
	}

    return false
}