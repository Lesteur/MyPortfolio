if place_meeting(x, y, obj_pock) && !count
{
	count = true
	global.lock = 1
	with obj_pock
	{
		image_speed = 0
		image_index = 0
		sprite_index = spr_pock_banana
		path_start(pth_path1, 3, path_action_stop, false)
	}
}