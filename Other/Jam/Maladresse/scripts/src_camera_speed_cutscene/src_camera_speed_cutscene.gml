/// @function													cutscene_camera_speed(name, target)
/// @description												Update the speed of the current camera.
/// @param {Real}									xspd		The new speed on the horizontal axis.
/// @param {Real}									yspd		The new speed on the vertical axis.
/// @self														obj_cutscene

function cutscene_camera_speed(_xspd, _yspd)
{
	var _f = function(_xspd, _yspd)
	{
		camera_set_view_speed(view_camera[global.current_view], _xspd, _yspd)
	
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_xspd, _yspd])
}