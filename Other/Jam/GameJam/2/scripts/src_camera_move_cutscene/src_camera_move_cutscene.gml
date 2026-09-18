/// @function													cutscene_camera_move(name, target)
/// @description												Create a transition by changing the type of camera.
/// @param {String}									name		The name of the new camera.
/// @param {Id.Instance OR Asset.GMObject}			target		The object to make the new target.
/// @param {Real}									time		The time of the transition.
/// @self														obj_cutscene

function cutscene_camera_move(_name, _target, _time = 30)
{
	var _f = function(_name, _target, _time = 30)
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
	
		var _inst = instance_create_depth(0, 0, depth, obj_cutscene_camera_move)
	
		with _inst
		{
			camera_target = _nb
			target = _target
			count = _time
		
			event_user(0)
		}
	
		next_cutscene()
	
		return _inst
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_name, _target, _time])
	return [count - 1]
}