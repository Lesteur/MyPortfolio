switch menu {
	case 0:
		if keyboard_check_pressed(vk_space) {
			menu ++
			image_index = 1
		}
		break
	case 1:
		choice_file = select_choice(choice_file, 3, true)
		if keyboard_check_pressed(vk_space) {
			menu ++
		}
		break
	case 2:
		if keyboard_check_pressed(vk_space) {
			if check_file(choice_file) {
				var _data = load_file(choice_file)
				show_debug_message(_data)
				
				room_goto(_data[0])
				global.xgoto = _data[1]
				global.ygoto = _data[2]
			} else
				room_goto(rm_area0)
		}
		break
}