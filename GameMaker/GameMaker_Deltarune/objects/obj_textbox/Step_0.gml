//Typing text
if setup {

	if time_wait > 0 {
		time_wait -= text_speed
	} else if draw_char < array_text_length[page] {
		
		draw_char += text_speed
		time_voice += speed_voice
		textbox_image += textbox_image_spd
		draw_char = clamp(draw_char, 0, array_text_length[page])
		var _letter = string_char_at(array_text[page], ceil(draw_char))
	
		if (time_voice mod 2 == 0) {
			if (array_length(array_text_sound) > page && array_text_sound[page] != noone)
				audio_play_sound(array_text_sound[page], 10, false)
			else
				audio_play_sound(snd_txtneutral, 10, false)
		}
	
	} else {
		sub_avance += 0.1
		sub_avance = clamp(sub_avance, -3, 0)
	}
	
	if draw_char == array_text_length[page]
		textbox_image = 0

	//Flip through pages
	if keyboard_check_pressed(global._vk_confirm) {
		//If the typing is done
		if draw_char == array_text_length[page] {
			//Next page
			sub_avance = -3
			if page < page_number - 1 {
				page ++
				draw_char = 0
			} else {
				text_end = true
				if destroy
					instance_destroy()
			}
			
		} else {
			sub_avance = -1
			draw_char = array_text_length[page]
		}
	} else if keyboard_check(global._vk_skip) {
		if page < page_number - 1 {
			page ++
			draw_char = 0
		}
	}

	//textbox_image += textbox_image_spd

}

//If choice to make
var _length = array_length(array_text_choice)

if nb_choice > 0 {
	if keyboard_check_pressed(global._vk_left) {
		choice = 0
	} else if keyboard_check_pressed(global._vk_right) && nb_choice >= 2 {
		choice = 1
	} else if keyboard_check_pressed(global._vk_up) && nb_choice >= 3 {
		choice = 2
	} else if keyboard_check_pressed(global._vk_down) && nb_choice >= 4 {
		choice = 3
	}
	
	if (keyboard_check_pressed(global._vk_confirm) && choice != -1) {
		choice_final = choice
	}
}