if keyboard_check_pressed(vk_space) {
	global.tension += 50
}

if global.tension > global.maxtension
	global.tension = global.maxtension