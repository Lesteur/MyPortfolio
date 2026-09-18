/// @function													cutscene_camera(name, target)
/// @description												Make change the type of camera.
/// @param {String}									name		The name of the new camera.
/// @param {Id.Instance OR Asset.GMObject}			target		The object to make the new target.
/// @self														obj_cutscene

function cutscene_camera(_name, _target)
{
	var _f = function(_name, _target)
	{
		var _nb
		switch _name
		{
			case "default":
				_nb = 0
				break
			case "battle":
				_nb = 1
				break
			case "bigplan":
				_nb = 2
				break
			default:
				_nb = 0
				break
		}
	
		with obj_camera
		{
			view_visible[global.current_view] = false
			view_visible[_nb] = true
			global.current_view = _nb
		
			camera_set_view_target(view_camera[_nb], _target)
		}
	
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_name, _target])
}